part of radarr_types;

enum RadarrQueueSortKey {
  ESTIMATED_COMPLETION_TIME,
  LANGUAGES,
  MOVIES_TITLE,
  PROGRESS,
  QUALITY,
}

/// Extension on [RadarrQueueSortKey] to implement extended functionality.
extension RadarrQueueSortKeyExtension on RadarrQueueSortKey {
  /// Given a String, will return the correct `RadarrQueueSortKey` object.
  RadarrQueueSortKey? from(String? type) {
    switch (type) {
      case 'estimatedCompletionTime':
        return RadarrQueueSortKey.ESTIMATED_COMPLETION_TIME;
      case 'languages':
        return RadarrQueueSortKey.LANGUAGES;
      case 'movies.sortTitle':
        return RadarrQueueSortKey.MOVIES_TITLE;
      case 'progress':
        return RadarrQueueSortKey.PROGRESS;
      case 'quality':
        return RadarrQueueSortKey.QUALITY;
    }
    return null;
  }

  /// The actual value/key for sorting directions used in Radarr.
  String? get value {
    switch (this) {
      case RadarrQueueSortKey.ESTIMATED_COMPLETION_TIME:
        return 'estimatedCompletionTime';
      case RadarrQueueSortKey.MOVIES_TITLE:
        return 'movies.sortTitle';
      case RadarrQueueSortKey.LANGUAGES:
        return 'languages';
      case RadarrQueueSortKey.QUALITY:
        return 'quality';
      case RadarrQueueSortKey.PROGRESS:
        return 'progress';
    }
  }
}
