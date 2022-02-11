part of readarr_types;

enum ReadarrQueueSortKey {
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

extension ReadarrQueueSortKeyExtension on ReadarrQueueSortKey {
  ReadarrQueueSortKey? from(String? type) {
    switch (type) {
      case 'episode':
        return ReadarrQueueSortKey.EPISODE;
      case 'timeleft':
        return ReadarrQueueSortKey.TIME_LEFT;
      case 'estimatedCompletionTime':
        return ReadarrQueueSortKey.ESTIMATED_COMPLETION_TIME;
      case 'protocol':
        return ReadarrQueueSortKey.PROTOCOL;
      case 'indexer':
        return ReadarrQueueSortKey.INDEXER;
      case 'downloadClient':
        return ReadarrQueueSortKey.DOWNLOAD_CLIENT;
      case 'language':
        return ReadarrQueueSortKey.LANGUAGE;
      case 'quality':
        return ReadarrQueueSortKey.QUALITY;
      case 'status':
        return ReadarrQueueSortKey.STATUS;
      case 'series.sortTitle':
        return ReadarrQueueSortKey.SERIES_SORT_TITLE;
      case 'title':
        return ReadarrQueueSortKey.TITLE;
      case 'episode.airDateUtc':
        return ReadarrQueueSortKey.EPISODE_AIRDATE_UTC;
      case 'episode.title':
        return ReadarrQueueSortKey.EPISODE_TITLE;
      default:
        return null;
    }
  }

  String? get value {
    switch (this) {
      case ReadarrQueueSortKey.EPISODE:
        return 'episode';
      case ReadarrQueueSortKey.TIME_LEFT:
        return 'timeleft';
      case ReadarrQueueSortKey.ESTIMATED_COMPLETION_TIME:
        return 'estimatedCompletionTime';
      case ReadarrQueueSortKey.PROTOCOL:
        return 'protocol';
      case ReadarrQueueSortKey.INDEXER:
        return 'indexer';
      case ReadarrQueueSortKey.DOWNLOAD_CLIENT:
        return 'downloadClient';
      case ReadarrQueueSortKey.LANGUAGE:
        return 'language';
      case ReadarrQueueSortKey.QUALITY:
        return 'quality';
      case ReadarrQueueSortKey.STATUS:
        return 'status';
      case ReadarrQueueSortKey.SERIES_SORT_TITLE:
        return 'series.sortTitle';
      case ReadarrQueueSortKey.TITLE:
        return 'title';
      case ReadarrQueueSortKey.EPISODE_AIRDATE_UTC:
        return 'episode.airDateUtc';
      case ReadarrQueueSortKey.EPISODE_TITLE:
        return 'episode.title';
    }
  }
}
