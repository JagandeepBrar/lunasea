import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/readarr.dart';

extension ReadarrEventTypeLunaExtension on ReadarrEventType {
  Color lunaColour() {
    switch (this) {
      case ReadarrEventType.GRABBED:
        return LunaColours.orange;
      case ReadarrEventType.BOOK_FILE_IMPORTED:
        return LunaColours.accent;
      case ReadarrEventType.DOWNLOAD_FAILED:
        return LunaColours.red;
      case ReadarrEventType.BOOK_FILE_DELETED:
        return LunaColours.red;
      case ReadarrEventType.BOOK_FILE_RENAMED:
        return LunaColours.blue;
      case ReadarrEventType.BOOK_IMPORT_INCOMPLETE:
        return LunaColours.orange;
      case ReadarrEventType.DOWNLOAD_IMPORTED:
        return LunaColours.accent;
      case ReadarrEventType.BOOK_FILE_RETAGGED:
        return LunaColours.blue;
      case ReadarrEventType.DOWNLOAD_IGNORED:
        return LunaColours.purple;
    }
  }

  IconData lunaIcon() {
    switch (this) {
      case ReadarrEventType.GRABBED:
        return Icons.cloud_download_rounded;
      case ReadarrEventType.BOOK_FILE_IMPORTED:
        return Icons.download_rounded;
      case ReadarrEventType.DOWNLOAD_FAILED:
        return Icons.cloud_download_rounded;
      case ReadarrEventType.BOOK_FILE_DELETED:
        return Icons.delete_rounded;
      case ReadarrEventType.BOOK_FILE_RENAMED:
        return Icons.drive_file_rename_outline_rounded;
      case ReadarrEventType.BOOK_IMPORT_INCOMPLETE:
        return Icons.cloud_download_rounded;
      case ReadarrEventType.DOWNLOAD_IMPORTED:
        return Icons.download_rounded;
      case ReadarrEventType.BOOK_FILE_RETAGGED:
        return Icons.create_rounded;
      case ReadarrEventType.DOWNLOAD_IGNORED:
        return Icons.cancel_rounded;
    }
  }

  Color lunaIconColour() {
    switch (this) {
      case ReadarrEventType.GRABBED:
        return Colors.white;
      case ReadarrEventType.BOOK_FILE_IMPORTED:
        return Colors.white;
      case ReadarrEventType.DOWNLOAD_FAILED:
        return LunaColours.red;
      case ReadarrEventType.BOOK_FILE_DELETED:
        return Colors.white;
      case ReadarrEventType.BOOK_FILE_RENAMED:
        return Colors.white;
      case ReadarrEventType.BOOK_IMPORT_INCOMPLETE:
        return Colors.orange;
      case ReadarrEventType.DOWNLOAD_IMPORTED:
        return Colors.white;
      case ReadarrEventType.BOOK_FILE_RETAGGED:
        return Colors.white;
      case ReadarrEventType.DOWNLOAD_IGNORED:
        return Colors.white;
    }
  }

  String? lunaReadable(ReadarrHistoryRecord record) {
    switch (this) {
      case ReadarrEventType.GRABBED:
        return 'readarr.GrabbedFrom'.tr(
          args: [record.data!['indexer'] ?? 'lunasea.Unknown'.tr()],
        );
      case ReadarrEventType.BOOK_FILE_IMPORTED:
        return 'readarr.BookFileImported'.tr(
          args: [record.quality?.quality?.name ?? 'lunasea.Unknown'.tr()],
        );
      case ReadarrEventType.DOWNLOAD_FAILED:
        return 'readarr.DownloadFailed'.tr();
      case ReadarrEventType.BOOK_FILE_DELETED:
        return 'readarr.BookFileDeleted'.tr();
      case ReadarrEventType.BOOK_FILE_RENAMED:
        return 'readarr.BookFileRenamed'.tr();
      case ReadarrEventType.BOOK_IMPORT_INCOMPLETE:
        return 'readarr.BookImportIncomplete'.tr();
      case ReadarrEventType.DOWNLOAD_IMPORTED:
        return 'readarr.DownloadImported'.tr(
          args: [record.quality?.quality?.name ?? 'lunasea.Unknown'.tr()],
        );
      case ReadarrEventType.BOOK_FILE_RETAGGED:
        return 'readarr.BookFileRetagged'.tr();
      case ReadarrEventType.DOWNLOAD_IGNORED:
        return 'readarr.DownloadIgnored'.tr();
    }
  }

  List<LunaTableContent> lunaTableContent({
    required ReadarrHistoryRecord history,
    required bool showSourceTitle,
  }) {
    switch (this) {
      case ReadarrEventType.GRABBED:
        return _grabbedTableContent(history, showSourceTitle);
      case ReadarrEventType.BOOK_FILE_IMPORTED:
        return _downloadFolderImportedTableContent(history, showSourceTitle);
      case ReadarrEventType.DOWNLOAD_FAILED:
        return _downloadFailedTableContent(history, showSourceTitle);
      case ReadarrEventType.BOOK_FILE_DELETED:
        return _episodeFileDeletedTableContent(history, showSourceTitle);
      case ReadarrEventType.BOOK_FILE_RENAMED:
        return _episodeFileRenamedTableContent(history);
      case ReadarrEventType.BOOK_IMPORT_INCOMPLETE:
        return _bookImportIncompleteTableContent(history, showSourceTitle);
      case ReadarrEventType.DOWNLOAD_IMPORTED:
        return _downloadFolderImportedTableContent(history, showSourceTitle);
      case ReadarrEventType.DOWNLOAD_IGNORED:
        return _downloadIgnoredTableContent(history, showSourceTitle);
      default:
        return _defaultTableContent(history, showSourceTitle);
    }
  }

  List<LunaTableContent> _downloadFailedTableContent(
    ReadarrHistoryRecord history,
    bool showSourceTitle,
  ) {
    return [
      if (showSourceTitle)
        LunaTableContent(
          title: 'readarr.SourceTitle'.tr(),
          body: history.sourceTitle,
        ),
      LunaTableContent(
        title: 'readarr.Message'.tr(),
        body: history.data!['message'],
      ),
    ];
  }

  List<LunaTableContent> _downloadFolderImportedTableContent(
    ReadarrHistoryRecord history,
    bool showSourceTitle,
  ) {
    return [
      if (showSourceTitle)
        LunaTableContent(
          title: 'readarr.SourceTitle'.tr(),
          body: history.sourceTitle,
        ),
      LunaTableContent(
        title: 'readarr.Quality'.tr(),
        body: history.quality?.quality?.name ?? LunaUI.TEXT_EMDASH,
      ),
      LunaTableContent(
        title: 'readarr.Client'.tr(),
        body: history.data!['downloadClient'] ?? LunaUI.TEXT_EMDASH,
      ),
      LunaTableContent(
        title: 'readarr.Source'.tr(),
        body: history.data!['droppedPath'],
      ),
      LunaTableContent(
        title: 'readarr.ImportedTo'.tr(),
        body: history.data!['importedPath'],
      ),
    ];
  }

  List<LunaTableContent> _downloadIgnoredTableContent(
    ReadarrHistoryRecord history,
    bool showSourceTitle,
  ) {
    return [
      if (showSourceTitle)
        LunaTableContent(
          title: 'readarr.Name'.tr(),
          body: history.sourceTitle,
        ),
      LunaTableContent(
        title: 'readarr.Message'.tr(),
        body: history.data!['message'],
      ),
    ];
  }

  List<LunaTableContent> _episodeFileDeletedTableContent(
    ReadarrHistoryRecord history,
    bool showSourceTitle,
  ) {
    String _reasonMapping(String? reason) {
      switch (reason) {
        case 'Upgrade':
          return 'readarr.DeleteReasonUpgrade'.tr();
        case 'MissingFromDisk':
          return 'readarr.DeleteReasonMissingFromDisk'.tr();
        case 'Manual':
          return 'readarr.DeleteReasonManual'.tr();
        default:
          return 'lunasea.Unknown'.tr();
      }
    }

    return [
      if (showSourceTitle)
        LunaTableContent(
          title: 'readarr.SourceTitle'.tr(),
          body: history.sourceTitle,
        ),
      LunaTableContent(
        title: 'readarr.Reason'.tr(),
        body: _reasonMapping(history.data!['reason']),
      ),
    ];
  }

  List<LunaTableContent> _episodeFileRenamedTableContent(
    ReadarrHistoryRecord history,
  ) {
    return [
      LunaTableContent(
        title: 'readarr.Source'.tr(),
        body: history.data!['sourcePath'],
      ),
      LunaTableContent(
        title: 'readarr.SourceRelative'.tr(),
        body: history.data!['sourceRelativePath'],
      ),
      LunaTableContent(
        title: 'readarr.Destination'.tr(),
        body: history.data!['path'],
      ),
      LunaTableContent(
        title: 'readarr.DestinationRelative'.tr(),
        body: history.data!['relativePath'],
      ),
    ];
  }

  List<LunaTableContent> _bookImportIncompleteTableContent(
    ReadarrHistoryRecord history,
    bool showSourceTitle,
  ) {
    return [
      if (showSourceTitle)
        LunaTableContent(
          title: 'readarr.SourceTitle'.tr(),
          body: history.sourceTitle,
        ),
      LunaTableContent(
        title: 'readarr.Messages'.tr(),
        body: history.data!['statusMessages'],
      ),
    ];
  }

  List<LunaTableContent> _grabbedTableContent(
    ReadarrHistoryRecord history,
    bool showSourceTitle,
  ) {
    return [
      if (showSourceTitle)
        LunaTableContent(
          title: 'readarr.SourceTitle'.tr(),
          body: history.sourceTitle,
        ),
      LunaTableContent(
        title: 'readarr.Quality'.tr(),
        body: history.quality?.quality?.name ?? LunaUI.TEXT_EMDASH,
      ),
      LunaTableContent(
        title: 'readarr.Indexer'.tr(),
        body: history.data!['indexer'],
      ),
      LunaTableContent(
        title: 'readarr.ReleaseGroup'.tr(),
        body: history.data!['releaseGroup'],
      ),
      LunaTableContent(
        title: 'readarr.InfoURL'.tr(),
        body: history.data!['nzbInfoUrl'],
        bodyIsUrl: history.data!['nzbInfoUrl'] != null,
      ),
      LunaTableContent(
        title: 'readarr.Client'.tr(),
        body: history.data!['downloadClientName'],
      ),
      LunaTableContent(
        title: 'readarr.DownloadID'.tr(),
        body: history.data!['downloadId'],
      ),
      LunaTableContent(
        title: 'readarr.Age'.tr(),
        body: double.tryParse(history.data!['ageHours'])?.asTimeAgo,
      ),
      LunaTableContent(
          title: 'readarr.PublishedDate'.tr(),
          body: DateTime.tryParse(history.data!['publishedDate'])
              ?.lunaDateTimeReadable(timeOnNewLine: true)),
    ];
  }

  List<LunaTableContent> _defaultTableContent(
    ReadarrHistoryRecord history,
    bool showSourceTitle,
  ) {
    return [
      if (showSourceTitle)
        LunaTableContent(
          title: 'readarr.Name'.tr(),
          body: history.sourceTitle,
        ),
    ];
  }
}
