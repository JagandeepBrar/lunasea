import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

extension SonarrEventTypeLunaExtension on SonarrEventType {
  Color lunaColour() {
    switch (this) {
      case SonarrEventType.EPISODE_FILE_RENAMED:
        return LunaColours.blue;
      case SonarrEventType.EPISODE_FILE_DELETED:
        return LunaColours.red;
      case SonarrEventType.DOWNLOAD_FOLDER_IMPORTED:
        return LunaColours.accent;
      case SonarrEventType.DOWNLOAD_FAILED:
        return LunaColours.red;
      case SonarrEventType.DOWNLOAD_IGNORED:
        return LunaColours.purple;
      case SonarrEventType.GRABBED:
        return LunaColours.orange;
      case SonarrEventType.SERIES_FOLDER_IMPORTED:
        return LunaColours.accent;
      default:
        return LunaColours.blueGrey;
    }
  }

  IconData lunaIcon() {
    switch (this) {
      case SonarrEventType.EPISODE_FILE_RENAMED:
        return Icons.drive_file_rename_outline;
      case SonarrEventType.EPISODE_FILE_DELETED:
        return Icons.delete;
      case SonarrEventType.DOWNLOAD_FOLDER_IMPORTED:
        return Icons.download_rounded;
      case SonarrEventType.DOWNLOAD_FAILED:
        return Icons.cloud_download;
      case SonarrEventType.DOWNLOAD_IGNORED:
        return Icons.cancel;
      case SonarrEventType.GRABBED:
        return Icons.cloud_download;
      case SonarrEventType.SERIES_FOLDER_IMPORTED:
        return Icons.download_rounded;
      default:
        return Icons.help;
    }
  }

  Color lunaIconColour() {
    switch (this) {
      case SonarrEventType.EPISODE_FILE_RENAMED:
        return Colors.white;
      case SonarrEventType.EPISODE_FILE_DELETED:
        return Colors.white;
      case SonarrEventType.DOWNLOAD_FOLDER_IMPORTED:
        return Colors.white;
      case SonarrEventType.DOWNLOAD_FAILED:
        return LunaColours.red;
      case SonarrEventType.DOWNLOAD_IGNORED:
        return Colors.white;
      case SonarrEventType.GRABBED:
        return Colors.white;
      case SonarrEventType.SERIES_FOLDER_IMPORTED:
        return Colors.white;
      default:
        return Colors.white;
    }
  }

  String lunaReadable(SonarrHistoryRecord record) {
    switch (this) {
      case SonarrEventType.EPISODE_FILE_RENAMED:
        return 'sonarr.EpisodeFileRenamed'.tr();
      case SonarrEventType.EPISODE_FILE_DELETED:
        return 'sonarr.EpisodeFileDeleted'.tr();
      case SonarrEventType.DOWNLOAD_FOLDER_IMPORTED:
        return 'sonarr.EpisodeImported'.tr(
          args: [record?.quality?.quality?.name ?? 'lunasea.Unknown'.tr()],
        );
      case SonarrEventType.DOWNLOAD_FAILED:
        return 'sonarr.DownloadFailed'.tr();
      case SonarrEventType.GRABBED:
        return 'sonarr.GrabbedFrom'.tr(
          args: [record.data['indexer'] ?? 'lunasea.Unknown'.tr()],
        );
      case SonarrEventType.DOWNLOAD_IGNORED:
        return 'sonarr.DownloadIgnored'.tr();
      case SonarrEventType.SERIES_FOLDER_IMPORTED:
        return 'sonarr.SeriesFolderImported'.tr();
    }
    return null;
  }

  List<LunaTableContent> lunaTableContent(SonarrHistoryRecord history) {
    switch (this) {
      case SonarrEventType.EPISODE_FILE_RENAMED:
        return [];
      case SonarrEventType.EPISODE_FILE_DELETED:
        return [];
      case SonarrEventType.DOWNLOAD_FOLDER_IMPORTED:
        return [];
      case SonarrEventType.DOWNLOAD_FAILED:
        return [];
      case SonarrEventType.DOWNLOAD_IGNORED:
        return [];
      case SonarrEventType.GRABBED:
        return _grabbedTableContent(history);
      case SonarrEventType.SERIES_FOLDER_IMPORTED:
        return [];
      default:
        return [];
    }
  }

  List<LunaTableContent> _grabbedTableContent(SonarrHistoryRecord history) {
    return [
      LunaTableContent(
        title: 'sonarr.Name'.tr(),
        body: history.sourceTitle ?? LunaUI.TEXT_EMDASH,
      ),
      LunaTableContent(
        title: 'sonarr.Indexer'.tr(),
        body: history.data['indexer'] ?? LunaUI.TEXT_EMDASH,
      ),
      if ((history.data['preferredWordScore'] ?? '0') != '0')
        LunaTableContent(
          title: 'sonarr.WordScore'.tr(),
          body: '+${history.data['preferredWordScore']}',
        ),
      if (history.data['releaseGroup'] != null)
        LunaTableContent(
          title: 'sonarr.ReleaseGroup'.tr(),
          body: history.data['releaseGroup'] ?? LunaUI.TEXT_EMDASH,
        ),
      LunaTableContent(
        title: 'sonarr.InfoURL'.tr(),
        body: history.data['nzbInfoUrl'] ?? LunaUI.TEXT_EMDASH,
        bodyIsUrl: history.data['nzbInfoUrl'] != null,
      ),
      LunaTableContent(
        title: 'sonarr.Client'.tr(),
        body: history.data['downloadClientName'] ?? LunaUI.TEXT_EMDASH,
      ),
      LunaTableContent(
        title: 'sonarr.Age'.tr(),
        body: double.tryParse(history.data['ageHours'])?.lunaHoursToAge() ??
            LunaUI.TEXT_EMDASH,
      ),
      LunaTableContent(
        title: 'sonarr.Published'.tr(),
        body: DateTime.tryParse(history.data['publishedDate'])
                ?.lunaDateTimeReadable(timeOnNewLine: true) ??
            LunaUI.TEXT_EMDASH,
      ),
    ];
  }
}
