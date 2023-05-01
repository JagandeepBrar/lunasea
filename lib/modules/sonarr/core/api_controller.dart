import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/extensions/string/string.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrAPIController {
  Future<bool> downloadRelease({
    required BuildContext context,
    required SonarrRelease release,
    bool showSnackbar = true,
  }) async {
    if (context.read<SonarrState>().enabled) {
      return context
          .read<SonarrState>()
          .api!
          .release
          .add(
            indexerId: release.indexerId!,
            guid: release.guid!,
          )
          .then((_) {
        if (showSnackbar) {
          showLunaSuccessSnackBar(
            title: 'sonarr.DownloadingRelease'.tr(),
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
            title: 'sonarr.FailedToDownloadRelease'.tr(),
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
    required SonarrEpisode episode,
    bool showSnackbar = true,
  }) async {
    SonarrEpisode _episode = episode.clone();
    _episode.monitored = !_episode.monitored!;
    if (context.read<SonarrState>().enabled) {
      return context.read<SonarrState>().api!.episode.setMonitored(
        episodeIds: [_episode.id!],
        monitored: _episode.monitored!,
      ).then((_) {
        context.read<SonarrSeasonDetailsState>().setSingleEpisode(_episode);
        if (showSnackbar) {
          showLunaSuccessSnackBar(
            title: _episode.monitored!
                ? 'sonarr.Monitoring'.tr()
                : 'sonarr.NoLongerMonitoring'.tr(),
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
                ? 'sonarr.FailedToMonitorEpisode'.tr()
                : 'sonarr.FailedToUnmonitorEpisode'.tr(),
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
    required SonarrEpisode episode,
    required SonarrEpisodeFile episodeFile,
    bool showSnackbar = true,
  }) async {
    SonarrEpisode _episode = episode.clone();
    _episode.hasFile = false;
    if (context.read<SonarrState>().enabled) {
      return context
          .read<SonarrState>()
          .api!
          .episodeFile
          .delete(episodeFileId: episodeFile.id!)
          .then((response) {
        context.read<SonarrSeasonDetailsState>().setSingleEpisode(_episode);
        if (showSnackbar) {
          showLunaSuccessSnackBar(
            title: 'sonarr.EpisodeFileDeleted'.tr(),
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
            title: 'sonarr.FailedToDeleteEpisodeFile'.tr(),
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
        title: 'sonarr.NoEpisodeFilesFound'.tr(),
        message: 'sonarr.NoEpisodeFilesFoundDeleteMessage'.tr(),
      );
      return true;
    }

    if (context.read<SonarrState>().enabled) {
      return context
          .read<SonarrState>()
          .api!
          .episodeFile
          .deleteBulk(episodeFileIds: episodeFileIds)
          .then((response) {
        if (showSnackbar) {
          showLunaSuccessSnackBar(
            title: 'sonarr.EpisodeFilesDeleted'.tr(),
            message: episodeFileIds.length > 1
                ? 'sonarr.EpisodesCount'
                    .tr(args: [episodeFileIds.length.toString()])
                : 'sonarr.OneEpisode'.tr(),
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
            title: 'sonarr.FailedToDeleteEpisodeFiles'.tr(),
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
    required SonarrEpisode episode,
    bool showSnackbar = true,
  }) async {
    if (context.read<SonarrState>().enabled) {
      return context
          .read<SonarrState>()
          .api!
          .command
          .episodeSearch(episodeIds: [episode.id!]).then((response) {
        if (showSnackbar) {
          showLunaSuccessSnackBar(
            title: 'sonarr.SearchingForEpisode'.tr(),
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
            title: 'sonarr.FailedToSearch'.tr(),
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
    if (context.read<SonarrState>().enabled) {
      return context
          .read<SonarrState>()
          .api!
          .command
          .episodeSearch(episodeIds: episodeIds)
          .then((response) {
        if (showSnackbar) {
          showLunaSuccessSnackBar(
            title: 'sonarr.SearchingForEpisodes'.tr(),
            message: episodeIds.length > 1
                ? 'sonarr.EpisodesCount'
                    .tr(args: [episodeIds.length.toString()])
                : 'sonarr.OneEpisode'.tr(),
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
            title: 'sonarr.FailedToSearchForEpisodes'.tr(),
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
    required SonarrSeriesSeason season,
    required int? seriesId,
    bool showSnackbar = true,
  }) async {
    if (context.read<SonarrState>().enabled) {
      return context.read<SonarrState>().series!.then((series) {
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
        await context.read<SonarrState>().api!.series.update(series: series);
        return series;
      }).then((series) {
        return context.read<SonarrState>().setSingleSeries(series);
      }).then((series) {
        if (showSnackbar) {
          showLunaSuccessSnackBar(
            title: season.monitored!
                ? 'sonarr.NoLongerMonitoring'.tr()
                : 'sonarr.Monitoring'.tr(),
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
                ? 'sonarr.FailedToUnmonitorSeason'.tr()
                : 'sonarr.FailedToMonitorSeason'.tr(),
            error: error,
          );
        return false;
      });
    }
    return false;
  }

  Future<bool> toggleSeriesMonitored({
    required BuildContext context,
    required SonarrSeries series,
    bool showSnackbar = true,
  }) async {
    if (context.read<SonarrState>().enabled) {
      SonarrSeries seriesCopy = series.clone();
      seriesCopy.monitored = !series.monitored!;
      return await context
          .read<SonarrState>()
          .api!
          .series
          .update(series: seriesCopy)
          .then((data) async {
        return await context
            .read<SonarrState>()
            .setSingleSeries(seriesCopy)
            .then((_) {
          if (showSnackbar) {
            showLunaSuccessSnackBar(
              title: seriesCopy.monitored!
                  ? 'sonarr.Monitoring'.tr()
                  : 'sonarr.NoLongerMonitoring'.tr(),
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
                ? 'sonarr.FailedToUnmonitorSeries'.tr()
                : 'sonarr.FailedToMonitorSeries'.tr(),
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
    if (context.read<SonarrState>().enabled) {
      return await context
          .read<SonarrState>()
          .api!
          .tag
          .create(label: label)
          .then((tag) {
        showLunaSuccessSnackBar(
          title: 'sonarr.AddedTag'.tr(),
          message: tag.label,
        );
        return true;
      }).catchError((error, stack) {
        LunaLogger().error('Failed to add tag: $label', error, stack);
        if (showSnackbar)
          showLunaErrorSnackBar(
            title: 'sonarr.FailedToAddTag'.tr(),
            error: error,
          );
        return false;
      });
    }
    return false;
  }

  Future<bool> updateSeries({
    required BuildContext context,
    required SonarrSeries series,
    bool showSnackbar = true,
  }) async {
    if (context.read<SonarrState>().enabled) {
      return await context
          .read<SonarrState>()
          .api!
          .series
          .update(series: series)
          .then((_) async {
        return await context
            .read<SonarrState>()
            .setSingleSeries(series)
            .then((_) {
          if (showSnackbar) {
            showLunaSuccessSnackBar(
              title: 'sonarr.UpdatedSeries'.tr(),
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
          title: 'sonarr.FailedToUpdateSeries'.tr(),
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
    if (context.read<SonarrState>().enabled) {
      return await context.read<SonarrState>().api!.command.backup().then((_) {
        if (showSnackbar) {
          showLunaSuccessSnackBar(
            title: 'sonarr.BackingUpDatabase'.tr(args: [LunaUI.TEXT_ELLIPSIS]),
            message: 'sonarr.BackingUpDatabaseDescription'.tr(),
          );
        }
        return true;
      }).catchError((error, stack) {
        LunaLogger().error(
          'Sonarr: Unable to backup database',
          error,
          stack,
        );
        if (showSnackbar)
          showLunaErrorSnackBar(
            title: 'sonarr.FailedToBackupDatabase'.tr(),
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
    if (context.read<SonarrState>().enabled) {
      return await context
          .read<SonarrState>()
          .api!
          .command
          .seasonSearch(seriesId: seriesId!, seasonNumber: seasonNumber!)
          .then((_) {
        if (showSnackbar)
          showLunaSuccessSnackBar(
            title: 'sonarr.SearchingForSeason'.tr(args: [LunaUI.TEXT_ELLIPSIS]),
            message: seasonNumber == 0
                ? 'sonarr.Specials'.tr()
                : 'sonarr.SeasonNumber'.tr(args: [seasonNumber.toString()]),
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
            title: 'sonarr.FailedToSeasonSearch'.tr(),
            error: error,
          );
        return false;
      });
    }
    return false;
  }

  Future<bool> seriesSearch({
    required BuildContext context,
    required SonarrSeries series,
    bool showSnackbar = true,
  }) async {
    if (context.read<SonarrState>().enabled) {
      return await context
          .read<SonarrState>()
          .api!
          .command
          .seriesSearch(seriesId: series.id!)
          .then((_) {
        if (showSnackbar)
          showLunaSuccessSnackBar(
            title: 'sonarr.SearchingForMonitoredEpisodes'.tr(),
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
            title: 'sonarr.FailedToSearchForMonitoredEpisodes'.tr(),
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
    if (context.read<SonarrState>().enabled) {
      return await context.read<SonarrState>().api!.command.rssSync().then((_) {
        if (showSnackbar)
          showLunaSuccessSnackBar(
            title: 'sonarr.RunningRSSSync'.tr(args: [LunaUI.TEXT_ELLIPSIS]),
            message: 'sonarr.RunningRSSSyncDescription'.tr(),
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
            title: 'sonarr.FailedToRunRSSSync'.tr(),
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
    if (context.read<SonarrState>().enabled) {
      return await context
          .read<SonarrState>()
          .api!
          .command
          .refreshSeries()
          .then((_) {
        if (showSnackbar)
          showLunaSuccessSnackBar(
            title: 'sonarr.UpdatingLibrary'.tr(args: [LunaUI.TEXT_ELLIPSIS]),
            message: 'sonarr.UpdatingLibraryDescription'.tr(),
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
            title: 'sonarr.FailedToUpdateLibrary'.tr(),
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
    if (context.read<SonarrState>().enabled) {
      return await context
          .read<SonarrState>()
          .api!
          .command
          .missingEpisodeSearch()
          .then((_) {
        if (showSnackbar)
          showLunaSuccessSnackBar(
            title: 'sonarr.Searching'.tr(args: [LunaUI.TEXT_ELLIPSIS]),
            message: 'sonarr.SearchingDescription'.tr(),
          );
        return true;
      }).catchError((error, stack) {
        LunaLogger().error(
          'Sonarr: Unable to search for all missing episodes',
          error,
          stack,
        );
        if (showSnackbar)
          showLunaErrorSnackBar(
            title: 'sonarr.FailedToSearch'.tr(),
            error: error,
          );
        return false;
      });
    }
    return false;
  }

  Future<bool> refreshSeries({
    required BuildContext context,
    required SonarrSeries series,
    bool showSnackbar = true,
  }) async {
    if (context.read<SonarrState>().enabled) {
      return await context
          .read<SonarrState>()
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
          'Sonarr: Unable to refresh movie: ${series.id}',
          error,
          stack,
        );
        if (showSnackbar)
          showLunaErrorSnackBar(
            title: 'sonarr.FailedToRefresh'.tr(),
            error: error,
          );
        return false;
      });
    }
    return false;
  }

  Future<bool> removeSeries({
    required BuildContext context,
    required SonarrSeries series,
    bool showSnackbar = true,
  }) async {
    if (context.read<SonarrState>().enabled) {
      return await context
          .read<SonarrState>()
          .api!
          .series
          .delete(
            seriesId: series.id!,
            deleteFiles: SonarrDatabase.REMOVE_SERIES_DELETE_FILES.read(),
            addImportListExclusion:
                SonarrDatabase.REMOVE_SERIES_EXCLUSION_LIST.read(),
          )
          .then((_) async {
        return await context
            .read<SonarrState>()
            .removeSingleSeries(series.id!)
            .then((_) {
          if (showSnackbar)
            showLunaSuccessSnackBar(
              title: SonarrDatabase.REMOVE_SERIES_DELETE_FILES.read()
                  ? 'sonarr.RemovedSeriesWithFiles'.tr()
                  : 'sonarr.RemovedSeries'.tr(),
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
            title: 'sonarr.FailedToRemoveSeries'.tr(),
            error: error,
          );
        return false;
      });
    }
    return false;
  }

  Future<SonarrSeries?> addSeries({
    required BuildContext context,
    required SonarrSeries series,
    required SonarrSeriesType seriesType,
    required bool seasonFolder,
    required SonarrQualityProfile qualityProfile,
    required SonarrRootFolder rootFolder,
    required SonarrSeriesMonitorType monitorType,
    required List<SonarrTag> tags,
    SonarrLanguageProfile? languageProfile,
    bool showSnackbar = true,
  }) async {
    if (context.read<SonarrState>().enabled) {
      series.id = 0;
      final result = await context
          .read<SonarrState>()
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
                SonarrDatabase.ADD_SERIES_SEARCH_FOR_MISSING.read(),
            searchForCutoffUnmetEpisodes:
                SonarrDatabase.ADD_SERIES_SEARCH_FOR_CUTOFF_UNMET.read(),
          )
          .then((series) {
        if (showSnackbar) {
          showLunaSuccessSnackBar(
            title: 'sonarr.AddedSeries'.tr(),
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
            title: 'sonarr.FailedToAddSeries'.tr(),
            error: error,
          );
        }
        return SonarrSeries();
      });
      if (result.id == null) return null;
      return result;
    }
    return null;
  }

  Future<bool> removeFromQueue({
    required BuildContext context,
    required SonarrQueueRecord queueRecord,
    bool showSnackbar = true,
  }) async {
    if (context.read<SonarrState>().enabled) {
      return context
          .read<SonarrState>()
          .api!
          .queue
          .delete(id: queueRecord.id!)
          .then((_) {
        if (showSnackbar)
          showLunaSuccessSnackBar(
            title: 'sonarr.RemovedFromQueue'.tr(),
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
            title: 'sonarr.FailedToRemoveFromQueue'.tr(),
            error: error,
          );
        return false;
      });
    }
    return false;
  }
}
