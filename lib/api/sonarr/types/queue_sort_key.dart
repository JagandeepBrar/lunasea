part of sonarr_types;

enum SonarrQueueSortKey {
  EPISODE,
  TIME_LEFT,
  ESTIMATED_COMPLETION_TIME,
  PROTOCOL,
  INDEXER,
  DOWNLOAD_CLIENT,
  LANGUAGE,
  QUALITY,
  STATUS,
  SERIES_SORT_TITLE,
  TITLE,
  EPISODE_AIRDATE_UTC,
  EPISODE_TITLE,
}

extension SonarrQueueSortKeyExtension on SonarrQueueSortKey {
  SonarrQueueSortKey? from(String? type) {
    switch (type) {
      case 'episode':
        return SonarrQueueSortKey.EPISODE;
      case 'timeleft':
        return SonarrQueueSortKey.TIME_LEFT;
      case 'estimatedCompletionTime':
        return SonarrQueueSortKey.ESTIMATED_COMPLETION_TIME;
      case 'protocol':
        return SonarrQueueSortKey.PROTOCOL;
      case 'indexer':
        return SonarrQueueSortKey.INDEXER;
      case 'downloadClient':
        return SonarrQueueSortKey.DOWNLOAD_CLIENT;
      case 'language':
        return SonarrQueueSortKey.LANGUAGE;
      case 'quality':
        return SonarrQueueSortKey.QUALITY;
      case 'status':
        return SonarrQueueSortKey.STATUS;
      case 'series.sortTitle':
        return SonarrQueueSortKey.SERIES_SORT_TITLE;
      case 'title':
        return SonarrQueueSortKey.TITLE;
      case 'episode.airDateUtc':
        return SonarrQueueSortKey.EPISODE_AIRDATE_UTC;
      case 'episode.title':
        return SonarrQueueSortKey.EPISODE_TITLE;
      default:
        return null;
    }
  }

  String? get value {
    switch (this) {
      case SonarrQueueSortKey.EPISODE:
        return 'episode';
      case SonarrQueueSortKey.TIME_LEFT:
        return 'timeleft';
      case SonarrQueueSortKey.ESTIMATED_COMPLETION_TIME:
        return 'estimatedCompletionTime';
      case SonarrQueueSortKey.PROTOCOL:
        return 'protocol';
      case SonarrQueueSortKey.INDEXER:
        return 'indexer';
      case SonarrQueueSortKey.DOWNLOAD_CLIENT:
        return 'downloadClient';
      case SonarrQueueSortKey.LANGUAGE:
        return 'language';
      case SonarrQueueSortKey.QUALITY:
        return 'quality';
      case SonarrQueueSortKey.STATUS:
        return 'status';
      case SonarrQueueSortKey.SERIES_SORT_TITLE:
        return 'series.sortTitle';
      case SonarrQueueSortKey.TITLE:
        return 'title';
      case SonarrQueueSortKey.EPISODE_AIRDATE_UTC:
        return 'episode.airDateUtc';
      case SonarrQueueSortKey.EPISODE_TITLE:
        return 'episode.title';
    }
  }
}
