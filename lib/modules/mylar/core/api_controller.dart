import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/extensions/string/string.dart';
import 'package:lunasea/modules/mylar.dart';

class MylarAPIController {
  Future<bool> downloadRelease({
    required BuildContext context,
    required MylarRelease release,
    bool showSnackbar = true,
  }) async {
    if (context.read<MylarState>().enabled) {
      return context
          .read<MylarState>()
          .api!
          .release
          .add(
            indexerId: release.indexerId!,
            guid: release.guid!,
          )
          .then((_) {
        if (showSnackbar) {
          showLunaSuccessSnackBar(
            title: 'Mylar.DownloadingRelease'.tr(),
            message: release.title.uiSafe(),
          );
        }
        return true;
      }).catchError((error, stack) {
        LunaLogger().error(
          'Failed to set download release (${release.guid})',
          error,
          stack,
        );
        if (showSnackbar) {
          showLunaErrorSnackBar(
            title: 'Mylar.FailedToDownloadRelease'.tr(),
            error: error,
          );
        }
        return false;
      });
    }
    return false;
  }

  Future<bool> toggleEpisodeMonitored({
    required BuildContext context,
    required MylarEpisode episode,
    bool showSnackbar = true,
  }) async {
    MylarEpisode _episode = episode.clone();
    _episode.monitored = !_episode.monitored!;
    if (context.read<MylarState>().enabled) {
      return context.read<MylarState>().api!.episode.setMonitored(
        episodeIds: [_episode.id!],
        monitored: _episode.monitored!,
      ).then((_) {
        context.read<MylarSeasonDetailsState>().setSingleEpisode(_episode);
        if (showSnackbar) {
          showLunaSuccessSnackBar(
            title: _episode.monitored!
                ? 'Mylar.Monitoring'.tr()
                : 'Mylar.NoLongerMonitoring'.tr(),
            message: _episode.title,
          );
        }
        return true;
      }).catchError((error, stack) {
        LunaLogger().error(
          'Failed to set episode monitored state (${_episode.id})',
          error,
          stack,
        );
        if (showSnackbar) {
          showLunaErrorSnackBar(
            title: _episode.monitored!
                ? 'Mylar.FailedToMonitorEpisode'.tr()
                : 'Mylar.FailedToUnmonitorEpisode'.tr(),
            error: error,
          );
        }
        return false;
      });
    }
    return false;
  }

  Future<bool> deleteEpisode({
    required BuildContext context,
    required MylarEpisode episode,
    required MylarEpisodeFile episodeFile,
    bool showSnackbar = true,
  }) async {
    MylarEpisode _episode = episode.clone();
    _episode.hasFile = false;
    if (context.read<MylarState>().enabled) {
      return context
          .read<MylarState>()
          .api!
          .episodeFile
          .delete(episodeFileId: episodeFile.id!)
          .then((response) {
        context.read<MylarSeasonDetailsState>().setSingleEpisode(_episode);
        if (showSnackbar) {
          showLunaSuccessSnackBar(
            title: 'Mylar.EpisodeFileDeleted'.tr(),
            message: episodeFile.relativePath,
          );
        }
        return true;
      }).catchError((error, stack) {
        LunaLogger().error(
          'Failed to delete episode (${episodeFile.id})',
          error,
          stack,
        );
        if (showSnackbar) {
          showLunaErrorSnackBar(
            title: 'Mylar.FailedToDeleteEpisodeFile'.tr(),
            error: error,
          );
        }
        return false;
      });
    }
    return false;
  }

  Future<bool> deleteEpisodes({
    required BuildContext context,
    required List<int> episodeFileIds,
    bool showSnackbar = true,
  }) async {
    if (episodeFileIds.isEmpty) {
      showLunaInfoSnackBar(
        title: 'Mylar.NoEpisodeFilesFound'.tr(),
        message: 'Mylar.NoEpisodeFilesFoundDeleteMessage'.tr(),
      );
      return true;
    }

    if (context.read<MylarState>().enabled) {
      return context
          .read<MylarState>()
          .api!
          .episodeFile
          .deleteBulk(episodeFileIds: episodeFileIds)
          .then((response) {
        if (showSnackbar) {
          showLunaSuccessSnackBar(
            title: 'Mylar.EpisodeFilesDeleted'.tr(),
            message: episodeFileIds.length > 1
                ? 'Mylar.EpisodesCount'
                    .tr(args: [episodeFileIds.length.toString()])
                : 'Mylar.OneEpisode'.tr(),
          );
        }
        return true;
      }).catchError((error, stack) {
        LunaLogger().error(
          'Failed to delete episodes (${episodeFileIds.join(',')})',
          error,
          stack,
        );
        if (showSnackbar) {
          showLunaErrorSnackBar(
            title: 'Mylar.FailedToDeleteEpisodeFiles'.tr(),
            error: error,
          );
        }
        return false;
      });
    }
    return false;
  }

  Future<bool> episodeSearch({
    required BuildContext context,
    required MylarEpisode episode,
    bool showSnackbar = true,
  }) async {
    if (context.read<MylarState>().enabled) {
      return context
          .read<MylarState>()
          .api!
          .command
          .episodeSearch(episodeIds: [episode.id!]).then((response) {
        if (showSnackbar) {
          showLunaSuccessSnackBar(
            title: 'Mylar.SearchingForEpisode'.tr(),
            message: episode.title,
          );
        }
        return true;
      }).catchError((error, stack) {
        LunaLogger().error(
          'Failed to search for episode: ${episode.id}',
          error,
          stack,
        );
        if (showSnackbar) {
          showLunaErrorSnackBar(
            title: 'Mylar.FailedToSearch'.tr(),
            error: error,
          );
        }
        return false;
      });
    }
    return false;
  }

  Future<bool> multiEpisodeSearch({
    required BuildContext context,
    required List<int> episodeIds,
    bool showSnackbar = true,
  }) async {
    if (context.read<MylarState>().enabled) {
      return context
          .read<MylarState>()
          .api!
          .command
          .episodeSearch(episodeIds: episodeIds)
          .then((response) {
        if (showSnackbar) {
          showLunaSuccessSnackBar(
            title: 'Mylar.SearchingForEpisodes'.tr(),
            message: episodeIds.length > 1
                ? 'Mylar.EpisodesCount'
                    .tr(args: [episodeIds.length.toString()])
                : 'Mylar.OneEpisode'.tr(),
          );
        }
        return true;
      }).catchError((error, stack) {
        LunaLogger().error(
          'Failed to search for episode: ${episodeIds.join(',')}',
          error,
          stack,
        );
        if (showSnackbar) {
          showLunaErrorSnackBar(
            title: 'Mylar.FailedToSearchForEpisodes'.tr(),
            error: error,
          );
        }
        return false;
      });
    }
    return false;
  }

  Future<bool> toggleSeasonMonitored({
    required BuildContext context,
    required MylarSeriesSeason season,
    required int? seriesId,
    bool showSnackbar = true,
  }) async {
    if (context.read<MylarState>().enabled) {
      return context.read<MylarState>().series!.then((series) {
        if (series[seriesId] == null) {
          throw Exception('Series does not exist in catalogue');
        }
        return series[seriesId]!.clone();
      }).then((series) async {
        series.seasons!.forEach((seriesSeason) {
          if (seriesSeason.seasonNumber == season.seasonNumber) {
            seriesSeason.monitored = !seriesSeason.monitored!;
          }
        });
        await context.read<MylarState>().api!.series.update(series: series);
        return series;
      }).then((series) {
        return context.read<MylarState>().setSingleSeries(series);
      }).then((series) {
        if (showSnackbar) {
          showLunaSuccessSnackBar(
            title: season.monitored!
                ? 'Mylar.NoLongerMonitoring'.tr()
                : 'Mylar.Monitoring'.tr(),
            message: season.seasonNumber == 0
                ? 'Specials'
                : 'Season ${season.seasonNumber}',
          );
        }
        return true;
      }).catchError((error, stack) {
        LunaLogger().error(
          'Unable to toggle season monitored state: ${season.monitored.toString()} to ${(!season.monitored!).toString()}',
          error,
          stack,
        );
        if (showSnackbar)
          showLunaErrorSnackBar(
            title: season.monitored!
                ? 'Mylar.FailedToUnmonitorSeason'.tr()
                : 'Mylar.FailedToMonitorSeason'.tr(),
            error: error,
          );
        return false;
      });
    }
    return false;
  }

  Future<bool> toggleSeriesMonitored({
    required BuildContext context,
    required MylarSeries series,
    bool showSnackbar = true,
  }) async {
    if (context.read<MylarState>().enabled) {
      MylarSeries seriesCopy = series.clone();
      seriesCopy.monitored = !series.monitored!;
      return await context
          .read<MylarState>()
          .api!
          .series
          .update(series: seriesCopy)
          .then((data) async {
        return await context
            .read<MylarState>()
            .setSingleSeries(seriesCopy)
            .then((_) {
          if (showSnackbar) {
            showLunaSuccessSnackBar(
              title: seriesCopy.monitored!
                  ? 'Mylar.Monitoring'.tr()
                  : 'Mylar.NoLongerMonitoring'.tr(),
              message: seriesCopy.title,
            );
          }
          return true;
        });
      }).catchError((error, stack) {
        LunaLogger().error(
          'Unable to toggle monitored state: ${series.monitored.toString()} to ${seriesCopy.monitored.toString()}',
          error,
          stack,
        );
        if (showSnackbar)
          showLunaErrorSnackBar(
            title: series.monitored!
                ? 'Mylar.FailedToUnmonitorSeries'.tr()
                : 'Mylar.FailedToMonitorSeries'.tr(),
            error: error,
          );
        return false;
      });
    }
    return false;
  }

  Future<bool> addTag({
    required BuildContext context,
    required String label,
    bool showSnackbar = true,
  }) async {
    if (context.read<MylarState>().enabled) {
      return await context
          .read<MylarState>()
          .api!
          .tag
          .create(label: label)
          .then((tag) {
        showLunaSuccessSnackBar(
          title: 'Mylar.AddedTag'.tr(),
          message: tag.label,
        );
        return true;
      }).catchError((error, stack) {
        LunaLogger().error('Failed to add tag: $label', error, stack);
        if (showSnackbar)
          showLunaErrorSnackBar(
            title: 'Mylar.FailedToAddTag'.tr(),
            error: error,
          );
        return false;
      });
    }
    return false;
  }

  Future<bool> updateSeries({
    required BuildContext context,
    required MylarSeries series,
    bool showSnackbar = true,
  }) async {
    if (context.read<MylarState>().enabled) {
      return await context
          .read<MylarState>()
          .api!
          .series
          .update(series: series)
          .then((_) async {
        return await context
            .read<MylarState>()
            .setSingleSeries(series)
            .then((_) {
          if (showSnackbar) {
            showLunaSuccessSnackBar(
              title: 'Mylar.UpdatedSeries'.tr(),
              message: series.title,
            );
          }
          return true;
        });
      }).catchError((error, stack) {
        LunaLogger().error(
          'Failed to update series: ${series.id}',
          error,
          stack,
        );
        showLunaErrorSnackBar(
          title: 'Mylar.FailedToUpdateSeries'.tr(),
          error: error,
        );
        return false;
      });
    }
    return true;
  }

  Future<bool> backupDatabase({
    required BuildContext context,
    bool showSnackbar = true,
  }) async {
    if (context.read<MylarState>().enabled) {
      return await context.read<MylarState>().api!.command.backup().then((_) {
        if (showSnackbar) {
          showLunaSuccessSnackBar(
            title: 'Mylar.BackingUpDatabase'.tr(args: [LunaUI.TEXT_ELLIPSIS]),
            message: 'Mylar.BackingUpDatabaseDescription'.tr(),
          );
        }
        return true;
      }).catchError((error, stack) {
        LunaLogger().error(
          'Mylar: Unable to backup database',
          error,
          stack,
        );
        if (showSnackbar)
          showLunaErrorSnackBar(
            title: 'Mylar.FailedToBackupDatabase'.tr(),
            error: error,
          );
        return false;
      });
    }
    return false;
  }

  Future<bool> automaticSeasonSearch({
    required BuildContext context,
    required int? seriesId,
    required int? seasonNumber,
    bool showSnackbar = true,
  }) async {
    if (context.read<MylarState>().enabled) {
      return await context
          .read<MylarState>()
          .api!
          .command
          .seasonSearch(seriesId: seriesId!, seasonNumber: seasonNumber!)
          .then((_) {
        if (showSnackbar)
          showLunaSuccessSnackBar(
            title: 'Mylar.SearchingForSeason'.tr(args: [LunaUI.TEXT_ELLIPSIS]),
            message: seasonNumber == 0
                ? 'Mylar.Specials'.tr()
                : 'Mylar.SeasonNumber'.tr(args: [seasonNumber.toString()]),
          );
        return true;
      }).catchError((error, stack) {
        LunaLogger().error(
          'Failed to season search ($seriesId, $seasonNumber)',
          error,
          stack,
        );
        if (showSnackbar)
          showLunaErrorSnackBar(
            title: 'Mylar.FailedToSeasonSearch'.tr(),
            error: error,
          );
        return false;
      });
    }
    return false;
  }

  Future<bool> seriesSearch({
    required BuildContext context,
    required MylarSeries series,
    bool showSnackbar = true,
  }) async {
    if (context.read<MylarState>().enabled) {
      return await context
          .read<MylarState>()
          .api!
          .command
          .seriesSearch(seriesId: series.id!)
          .then((_) {
        if (showSnackbar)
          showLunaSuccessSnackBar(
            title: 'Mylar.SearchingForMonitoredEpisodes'.tr(),
            message: series.title!,
          );
        return true;
      }).catchError((error, stack) {
        LunaLogger().error(
          'Failed to search for monitored episodes (${series.id})',
          error,
          stack,
        );
        if (showSnackbar)
          showLunaErrorSnackBar(
            title: 'Mylar.FailedToSearchForMonitoredEpisodes'.tr(),
            error: error,
          );
        return false;
      });
    }
    return false;
  }

  Future<bool> runRSSSync({
    required BuildContext context,
    bool showSnackbar = true,
  }) async {
    if (context.read<MylarState>().enabled) {
      return await context.read<MylarState>().api!.command.rssSync().then((_) {
        if (showSnackbar)
          showLunaSuccessSnackBar(
            title: 'Mylar.RunningRSSSync'.tr(args: [LunaUI.TEXT_ELLIPSIS]),
            message: 'Mylar.RunningRSSSyncDescription'.tr(),
          );
        return true;
      }).catchError((error, stack) {
        LunaLogger().error(
          'Unable to run RSS sync',
          error,
          stack,
        );
        if (showSnackbar)
          showLunaErrorSnackBar(
            title: 'Mylar.FailedToRunRSSSync'.tr(),
            error: error,
          );
        return false;
      });
    }
    return false;
  }

  Future<bool> updateLibrary({
    required BuildContext context,
    bool showSnackbar = true,
  }) async {
    if (context.read<MylarState>().enabled) {
      return await context
          .read<MylarState>()
          .api!
          .command
          .refreshSeries()
          .then((_) {
        if (showSnackbar)
          showLunaSuccessSnackBar(
            title: 'Mylar.UpdatingLibrary'.tr(args: [LunaUI.TEXT_ELLIPSIS]),
            message: 'Mylar.UpdatingLibraryDescription'.tr(),
          );
        return true;
      }).catchError((error, stack) {
        LunaLogger().error(
          'Unable to update library',
          error,
          stack,
        );
        if (showSnackbar)
          showLunaErrorSnackBar(
            title: 'Mylar.FailedToUpdateLibrary'.tr(),
            error: error,
          );
        return false;
      });
    }
    return false;
  }

  Future<bool> missingEpisodesSearch({
    required BuildContext context,
    bool showSnackbar = true,
  }) async {
    if (context.read<MylarState>().enabled) {
      return await context
          .read<MylarState>()
          .api!
          .command
          .missingEpisodeSearch()
          .then((_) {
        if (showSnackbar)
          showLunaSuccessSnackBar(
            title: 'Mylar.Searching'.tr(args: [LunaUI.TEXT_ELLIPSIS]),
            message: 'Mylar.SearchingDescription'.tr(),
          );
        return true;
      }).catchError((error, stack) {
        LunaLogger().error(
          'Mylar: Unable to search for all missing episodes',
          error,
          stack,
        );
        if (showSnackbar)
          showLunaErrorSnackBar(
            title: 'Mylar.FailedToSearch'.tr(),
            error: error,
          );
        return false;
      });
    }
    return false;
  }

  Future<bool> refreshSeries({
    required BuildContext context,
    required MylarSeries series,
    bool showSnackbar = true,
  }) async {
    if (context.read<MylarState>().enabled) {
      return await context
          .read<MylarState>()
          .api!
          .command
          .refreshSeries(seriesId: series.id)
          .then((_) {
        if (showSnackbar)
          showLunaSuccessSnackBar(
            title: 'lunasea.Refreshing'.tr(),
            message: series.title,
          );
        return true;
      }).catchError((error, stack) {
        LunaLogger().error(
          'Mylar: Unable to refresh movie: ${series.id}',
          error,
          stack,
        );
        if (showSnackbar)
          showLunaErrorSnackBar(
            title: 'Mylar.FailedToRefresh'.tr(),
            error: error,
          );
        return false;
      });
    }
    return false;
  }

  Future<bool> removeSeries({
    required BuildContext context,
    required MylarSeries series,
    bool showSnackbar = true,
  }) async {
    if (context.read<MylarState>().enabled) {
      return await context
          .read<MylarState>()
          .api!
          .series
          .delete(
            seriesId: series.id!,
            deleteFiles: MylarDatabase.REMOVE_SERIES_DELETE_FILES.read(),
            addImportListExclusion:
                MylarDatabase.REMOVE_SERIES_EXCLUSION_LIST.read(),
          )
          .then((_) async {
        return await context
            .read<MylarState>()
            .removeSingleSeries(series.id!)
            .then((_) {
          if (showSnackbar)
            showLunaSuccessSnackBar(
              title: MylarDatabase.REMOVE_SERIES_DELETE_FILES.read()
                  ? 'Mylar.RemovedSeriesWithFiles'.tr()
                  : 'Mylar.RemovedSeries'.tr(),
              message: series.title,
            );
          return true;
        });
      }).catchError((error, stack) {
        LunaLogger().error(
          'Failed to remove series: ${series.id}',
          error,
          stack,
        );
        if (showSnackbar)
          showLunaErrorSnackBar(
            title: 'Mylar.FailedToRemoveSeries'.tr(),
            error: error,
          );
        return false;
      });
    }
    return false;
  }

  Future<MylarSeries?> addSeries({
    required BuildContext context,
    required MylarSeries series,
    required MylarSeriesType seriesType,
    required bool seasonFolder,
    required MylarQualityProfile qualityProfile,
    required MylarRootFolder rootFolder,
    required MylarSeriesMonitorType monitorType,
    required List<MylarTag> tags,
    MylarLanguageProfile? languageProfile,
    bool showSnackbar = true,
  }) async {
    if (context.read<MylarState>().enabled) {
      series.id = 0;
      final result = await context
          .read<MylarState>()
          .api!
          .series
          .create(
            series: series,
            seriesType: seriesType,
            seasonFolder: seasonFolder,
            qualityProfile: qualityProfile,
            languageProfile: languageProfile,
            rootFolder: rootFolder,
            monitorType: monitorType,
            tags: tags,
            searchForMissingEpisodes:
                MylarDatabase.ADD_SERIES_SEARCH_FOR_MISSING.read(),
            searchForCutoffUnmetEpisodes:
                MylarDatabase.ADD_SERIES_SEARCH_FOR_CUTOFF_UNMET.read(),
          )
          .then((series) {
        if (showSnackbar) {
          showLunaSuccessSnackBar(
            title: 'Mylar.AddedSeries'.tr(),
            message: series.title,
          );
        }
        return series;
      }).catchError((error, stack) {
        LunaLogger().error(
          'Failed to add series (tmdbId: ${series.tvdbId})',
          error,
          stack,
        );
        if (showSnackbar) {
          showLunaErrorSnackBar(
            title: 'Mylar.FailedToAddSeries'.tr(),
            error: error,
          );
        }
        return MylarSeries();
      });
      if (result.id == null) return null;
      return result;
    }
    return null;
  }

  Future<bool> removeFromQueue({
    required BuildContext context,
    required MylarQueueRecord queueRecord,
    bool showSnackbar = true,
  }) async {
    if (context.read<MylarState>().enabled) {
      return context
          .read<MylarState>()
          .api!
          .queue
          .delete(id: queueRecord.id!)
          .then((_) {
        if (showSnackbar)
          showLunaSuccessSnackBar(
            title: 'Mylar.RemovedFromQueue'.tr(),
            message: queueRecord.title,
          );
        return true;
      }).catchError((error, stack) {
        LunaLogger().error(
          'Failed to remove queue record: ${queueRecord.id}',
          error,
          stack,
        );
        if (showSnackbar)
          showLunaErrorSnackBar(
            title: 'Mylar.FailedToRemoveFromQueue'.tr(),
            error: error,
          );
        return false;
      });
    }
    return false;
  }
}
