import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/readarr.dart';

class ReadarrAPIController {
  Future<bool> downloadRelease({
    required BuildContext context,
    required ReadarrRelease release,
    bool showSnackbar = true,
  }) async {
    if (context.read<ReadarrState>().enabled) {
      return context
          .read<ReadarrState>()
          .api!
          .release
          .add(
            indexerId: release.indexerId!,
            guid: release.guid!,
          )
          .then((_) {
        if (showSnackbar) {
          showLunaSuccessSnackBar(
            title: 'readarr.DownloadingRelease'.tr(),
            message: lunaSafeString(release.title),
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
            title: 'readarr.FailedToDownloadRelease'.tr(),
            error: error,
          );
        }
        return false;
      });
    }
    return false;
  }

  Future<bool> toggleBookMonitored({
    required BuildContext context,
    required ReadarrBook book,
    bool showSnackbar = true,
  }) async {
    ReadarrBook _book = book.clone();
    _book.monitored = !_book.monitored!;
    if (context.read<ReadarrState>().enabled) {
      return context.read<ReadarrState>().api!.book.setMonitored(
        bookIds: [_book.id!],
        monitored: _book.monitored!,
      ).then((_) {
        context.read<ReadarrState>().setSingleBook(_book);
        if (showSnackbar) {
          showLunaSuccessSnackBar(
            title: _book.monitored!
                ? 'readarr.Monitoring'.tr()
                : 'readarr.NoLongerMonitoring'.tr(),
            message: _book.title,
          );
        }
        return true;
      }).catchError((error, stack) {
        LunaLogger().error(
          'Failed to set episode monitored state (${_book.id})',
          error,
          stack,
        );
        if (showSnackbar) {
          showLunaErrorSnackBar(
            title: _book.monitored!
                ? 'readarr.FailedToMonitorBook'.tr()
                : 'readarr.FailedToUnmonitorBook'.tr(),
            error: error,
          );
        }
        return false;
      });
    }
    return false;
  }

  Future<bool> deleteBookFile({
    required BuildContext context,
    required ReadarrBookFile bookFile,
    bool showSnackbar = true,
  }) async {
    if (context.read<ReadarrState>().enabled) {
      return context
          .read<ReadarrState>()
          .api!
          .bookFile
          .delete(bookFileId: bookFile.id!)
          .then((response) {
        //context.read<ReadarrBookDetailsState>().setSingleEpisode(_episode);
        if (showSnackbar) {
          showLunaSuccessSnackBar(
            title: 'readarr.EpisodeFileDeleted'.tr(),
            message: bookFile.path,
          );
        }
        return true;
      }).catchError((error, stack) {
        LunaLogger().error(
          'Failed to delete episode (${bookFile.id})',
          error,
          stack,
        );
        if (showSnackbar) {
          showLunaErrorSnackBar(
            title: 'readarr.FailedToDeleteEpisodeFile'.tr(),
            error: error,
          );
        }
        return false;
      });
    }
    return false;
  }

  Future<bool> authorSearch({
    required BuildContext context,
    required ReadarrAuthor author,
    bool showSnackbar = true,
  }) async {
    if (context.read<ReadarrState>().enabled) {
      return context
          .read<ReadarrState>()
          .api!
          .command
          .authorSearch(authorId: author.id!)
          .then((response) {
        if (showSnackbar) {
          showLunaSuccessSnackBar(
            title: 'readarr.SearchingForAuthor'.tr(),
            message: author.title,
          );
        }
        return true;
      }).catchError((error, stack) {
        LunaLogger().error(
          'Failed to search for author: ${author.id}',
          error,
          stack,
        );
        if (showSnackbar) {
          showLunaErrorSnackBar(
            title: 'readarr.FailedToSearch'.tr(),
            error: error,
          );
        }
        return false;
      });
    }
    return false;
  }

  Future<bool> bookSearch({
    required BuildContext context,
    required ReadarrBook book,
    bool showSnackbar = true,
  }) async {
    if (context.read<ReadarrState>().enabled) {
      return context
          .read<ReadarrState>()
          .api!
          .command
          .bookSearch(bookIds: [book.id!]).then((response) {
        if (showSnackbar) {
          showLunaSuccessSnackBar(
            title: 'readarr.SearchingForBook'.tr(),
            message: book.title,
          );
        }
        return true;
      }).catchError((error, stack) {
        LunaLogger().error(
          'Failed to search for book: ${book.id}',
          error,
          stack,
        );
        if (showSnackbar) {
          showLunaErrorSnackBar(
            title: 'readarr.FailedToSearch'.tr(),
            error: error,
          );
        }
        return false;
      });
    }
    return false;
  }

  Future<bool> toggleAuthorMonitored({
    required BuildContext context,
    required ReadarrAuthor author,
    bool showSnackbar = true,
  }) async {
    if (context.read<ReadarrState>().enabled) {
      ReadarrAuthor authorCopy = author.clone();
      authorCopy.monitored = !author.monitored!;
      return await context
          .read<ReadarrState>()
          .api!
          .author
          .update(author: authorCopy)
          .then((data) async {
        return await context
            .read<ReadarrState>()
            .setSingleAuthor(authorCopy)
            .then((_) {
          if (showSnackbar) {
            showLunaSuccessSnackBar(
              title: authorCopy.monitored!
                  ? 'readarr.Monitoring'.tr()
                  : 'readarr.NoLongerMonitoring'.tr(),
              message: authorCopy.title,
            );
          }
          return true;
        });
      }).catchError((error, stack) {
        LunaLogger().error(
          'Unable to toggle monitored state: ${author.monitored.toString()} to ${authorCopy.monitored.toString()}',
          error,
          stack,
        );
        if (showSnackbar)
          showLunaErrorSnackBar(
            title: author.monitored!
                ? 'readarr.FailedToUnmonitorAuthor'.tr()
                : 'readarr.FailedToMonitorAuthor'.tr(),
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
    if (context.read<ReadarrState>().enabled) {
      return await context
          .read<ReadarrState>()
          .api!
          .tag
          .create(label: label)
          .then((tag) {
        showLunaSuccessSnackBar(
          title: 'readarr.AddedTag'.tr(),
          message: tag.label,
        );
        return true;
      }).catchError((error, stack) {
        LunaLogger().error('Failed to add tag: $label', error, stack);
        if (showSnackbar)
          showLunaErrorSnackBar(
            title: 'readarr.FailedToAddTag'.tr(),
            error: error,
          );
        return false;
      });
    }
    return false;
  }

  Future<bool> updateAuthor({
    required BuildContext context,
    required ReadarrAuthor series,
    bool showSnackbar = true,
  }) async {
    if (context.read<ReadarrState>().enabled) {
      return await context
          .read<ReadarrState>()
          .api!
          .author
          .update(author: series)
          .then((_) async {
        return await context
            .read<ReadarrState>()
            .setSingleAuthor(series)
            .then((_) {
          if (showSnackbar) {
            showLunaSuccessSnackBar(
              title: 'readarr.UpdatedSeries'.tr(),
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
          title: 'readarr.FailedToUpdateAuthor'.tr(),
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
    if (context.read<ReadarrState>().enabled) {
      return await context.read<ReadarrState>().api!.command.backup().then((_) {
        if (showSnackbar) {
          showLunaSuccessSnackBar(
            title: 'readarr.BackingUpDatabase'.tr(args: [LunaUI.TEXT_ELLIPSIS]),
            message: 'readarr.BackingUpDatabaseDescription'.tr(),
          );
        }
        return true;
      }).catchError((error, stack) {
        LunaLogger().error(
          'Readarr: Unable to backup database',
          error,
          stack,
        );
        if (showSnackbar)
          showLunaErrorSnackBar(
            title: 'readarr.FailedToBackupDatabase'.tr(),
            error: error,
          );
        return false;
      });
    }
    return false;
  }

  Future<bool> automaticSeasonSearch({
    required BuildContext context,
    required int? authorId,
    required int? seasonNumber,
    bool showSnackbar = true,
  }) async {
    if (context.read<ReadarrState>().enabled) {
      return await context
          .read<ReadarrState>()
          .api!
          .command
          .seasonSearch(authorId: authorId!, seasonNumber: seasonNumber!)
          .then((_) {
        if (showSnackbar)
          showLunaSuccessSnackBar(
            title:
                'readarr.SearchingForSeason'.tr(args: [LunaUI.TEXT_ELLIPSIS]),
            message: seasonNumber == 0
                ? 'readarr.Specials'.tr()
                : 'readarr.SeasonNumber'.tr(args: [seasonNumber.toString()]),
          );
        return true;
      }).catchError((error, stack) {
        LunaLogger().error(
          'Failed to season search ($authorId, $seasonNumber)',
          error,
          stack,
        );
        if (showSnackbar)
          showLunaErrorSnackBar(
            title: 'readarr.FailedToSeasonSearch'.tr(),
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
    if (context.read<ReadarrState>().enabled) {
      return await context
          .read<ReadarrState>()
          .api!
          .command
          .rssSync()
          .then((_) {
        if (showSnackbar)
          showLunaSuccessSnackBar(
            title: 'readarr.RunningRSSSync'.tr(args: [LunaUI.TEXT_ELLIPSIS]),
            message: 'readarr.RunningRSSSyncDescription'.tr(),
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
            title: 'readarr.FailedToRunRSSSync'.tr(),
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
    if (context.read<ReadarrState>().enabled) {
      return await context
          .read<ReadarrState>()
          .api!
          .command
          .refreshAuthor()
          .then((_) {
        if (showSnackbar)
          showLunaSuccessSnackBar(
            title: 'readarr.UpdatingLibrary'.tr(args: [LunaUI.TEXT_ELLIPSIS]),
            message: 'readarr.UpdatingLibraryDescription'.tr(),
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
            title: 'readarr.FailedToUpdateLibrary'.tr(),
            error: error,
          );
        return false;
      });
    }
    return false;
  }

  Future<bool> missingBooksSearch({
    required BuildContext context,
    bool showSnackbar = true,
  }) async {
    if (context.read<ReadarrState>().enabled) {
      return await context
          .read<ReadarrState>()
          .api!
          .command
          .missingBooksSearch()
          .then((_) {
        if (showSnackbar)
          showLunaSuccessSnackBar(
            title: 'readarr.Searching'.tr(args: [LunaUI.TEXT_ELLIPSIS]),
            message: 'readarr.SearchingDescription'.tr(),
          );
        return true;
      }).catchError((error, stack) {
        LunaLogger().error(
          'Readarr: Unable to search for all missing episodes',
          error,
          stack,
        );
        if (showSnackbar)
          showLunaErrorSnackBar(
            title: 'readarr.FailedToSearch'.tr(),
            error: error,
          );
        return false;
      });
    }
    return false;
  }

  Future<bool> refreshAuthor({
    required BuildContext context,
    required ReadarrAuthor series,
    bool showSnackbar = true,
  }) async {
    if (context.read<ReadarrState>().enabled) {
      return await context
          .read<ReadarrState>()
          .api!
          .command
          .refreshAuthor(authorId: series.id)
          .then((_) {
        if (showSnackbar)
          showLunaSuccessSnackBar(
            title: 'lunasea.Refreshing'.tr(),
            message: series.title,
          );
        return true;
      }).catchError((error, stack) {
        LunaLogger().error(
          'Readarr: Unable to refresh book: ${series.id}',
          error,
          stack,
        );
        if (showSnackbar)
          showLunaErrorSnackBar(
            title: 'readarr.FailedToRefresh'.tr(),
            error: error,
          );
        return false;
      });
    }
    return false;
  }

  Future<bool> refreshBook({
    required BuildContext context,
    required ReadarrBook book,
    bool showSnackbar = true,
  }) async {
    if (context.read<ReadarrState>().enabled) {
      return await context
          .read<ReadarrState>()
          .api!
          .command
          .refreshBook(bookId: book.id)
          .then((_) {
        if (showSnackbar)
          showLunaSuccessSnackBar(
            title: 'lunasea.Refreshing'.tr(),
            message: book.title,
          );
        return true;
      }).catchError((error, stack) {
        LunaLogger().error(
          'Readarr: Unable to refresh book: ${book.id}',
          error,
          stack,
        );
        if (showSnackbar)
          showLunaErrorSnackBar(
            title: 'readarr.FailedToRefresh'.tr(),
            error: error,
          );
        return false;
      });
    }
    return false;
  }

  Future<bool> removeAuthor({
    required BuildContext context,
    required ReadarrAuthor author,
    bool showSnackbar = true,
  }) async {
    if (context.read<ReadarrState>().enabled) {
      return await context
          .read<ReadarrState>()
          .api!
          .author
          .delete(
            authorId: author.id!,
            deleteFiles: ReadarrDatabaseValue.REMOVE_SERIES_DELETE_FILES.data,
            addImportListExclusion:
                ReadarrDatabaseValue.REMOVE_SERIES_EXCLUSION_LIST.data,
          )
          .then((_) async {
        return await context
            .read<ReadarrState>()
            .removeSingleAuthor(author.id!)
            .then((_) {
          if (showSnackbar)
            showLunaSuccessSnackBar(
              title: ReadarrDatabaseValue.REMOVE_SERIES_DELETE_FILES.data
                  ? 'readarr.RemovedAuthorWithFiles'.tr()
                  : 'readarr.RemovedAuthor'.tr(),
              message: author.title,
            );
          return true;
        });
      }).catchError((error, stack) {
        LunaLogger().error(
          'Failed to remove author: ${author.id}',
          error,
          stack,
        );
        if (showSnackbar)
          showLunaErrorSnackBar(
            title: 'readarr.FailedToRemoveAuthor'.tr(),
            error: error,
          );
        return false;
      });
    }
    return false;
  }

  Future<bool> removeBook({
    required BuildContext context,
    required ReadarrBook book,
    bool showSnackbar = true,
  }) async {
    if (context.read<ReadarrState>().enabled) {
      return await context
          .read<ReadarrState>()
          .api!
          .book
          .delete(
            bookId: book.id!,
            deleteFiles: ReadarrDatabaseValue.REMOVE_BOOK_DELETE_FILES.data,
            addImportListExclusion:
                ReadarrDatabaseValue.REMOVE_BOOK_EXCLUSION_LIST.data,
          )
          .then((_) async {
        return await context
            .read<ReadarrState>()
            .removeSingleBook(book.id!)
            .then((_) {
          if (showSnackbar)
            showLunaSuccessSnackBar(
              title: ReadarrDatabaseValue.REMOVE_BOOK_DELETE_FILES.data
                  ? 'readarr.RemovedBookWithFiles'.tr()
                  : 'readarr.RemovedBook'.tr(),
              message: book.title,
            );
          return true;
        });
      }).catchError((error, stack) {
        LunaLogger().error(
          'Failed to remove series: ${book.id}',
          error,
          stack,
        );
        if (showSnackbar)
          showLunaErrorSnackBar(
            title: 'readarr.FailedToRemoveBook'.tr(),
            error: error,
          );
        return false;
      });
    }
    return false;
  }

  Future<ReadarrAuthor?> addAuthor({
    required BuildContext context,
    required ReadarrAuthor author,
    required ReadarrQualityProfile qualityProfile,
    required ReadarrMetadataProfile metadataProfile,
    required ReadarrRootFolder rootFolder,
    required ReadarrAuthorMonitorType monitorType,
    required List<ReadarrTag> tags,
    bool showSnackbar = true,
  }) async {
    if (context.read<ReadarrState>().enabled) {
      author.id = 0;
      return await context
          .read<ReadarrState>()
          .api!
          .author
          .create(
            author: author,
            qualityProfile: qualityProfile,
            metadataProfile: metadataProfile,
            rootFolder: rootFolder,
            monitorType: monitorType,
            tags: tags,
            searchForMissingEpisodes:
                ReadarrDatabaseValue.ADD_SERIES_SEARCH_FOR_MISSING.data,
            searchForCutoffUnmetEpisodes:
                ReadarrDatabaseValue.ADD_SERIES_SEARCH_FOR_CUTOFF_UNMET.data,
          )
          .then((series) {
        if (showSnackbar) {
          showLunaSuccessSnackBar(
            title: 'readarr.AddedSeries'.tr(),
            message: series.title,
          );
        }
        return series;
      }).catchError((error, stack) {
        LunaLogger().error(
          'Failed to add series (foreignId: ${author.foreignAuthorId})',
          error,
          stack,
        );
        if (showSnackbar) {
          showLunaErrorSnackBar(
            title: 'readarr.FailedToAddAuthor'.tr(),
            error: error,
          );
        }
      });
    }
    return null;
  }

  Future<bool> removeFromQueue({
    required BuildContext context,
    required ReadarrQueueRecord queueRecord,
    bool showSnackbar = true,
  }) async {
    if (context.read<ReadarrState>().enabled) {
      return context
          .read<ReadarrState>()
          .api!
          .queue
          .delete(id: queueRecord.id!)
          .then((_) {
        if (showSnackbar)
          showLunaSuccessSnackBar(
            title: 'readarr.RemovedFromQueue'.tr(),
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
            title: 'readarr.FailedToRemoveFromQueue'.tr(),
            error: error,
          );
        return false;
      });
    }
    return false;
  }
}
