part of tautulli_types;

/// Enumerator to handle all library media information order columns used in Tautulli.
enum TautulliLibraryMediaInfoOrderColumn {
  ADDED_AT,
  SORT_TITLE,
  CONTAINER,
  BITRATE,
  VIDEO_CODEC,
  VIDEO_RESOLUTION,
  VIDEO_FRAMERATE,
  AUDIO_CODEC,
  AUDIO_CHANNELS,
  FILE_SIZE,
  LAST_PLAYED,
  PLAY_COUNT,
  NULL,
}

/// Extension on [TautulliLibraryMediaInfoOrderColumn] to implement extended functionality.
extension TautulliLibraryMediaInfoOrderColumnExtension
    on TautulliLibraryMediaInfoOrderColumn {
  /// The actual value/key for library media information order column used in Tautulli.
  String? get value {
    switch (this) {
      case TautulliLibraryMediaInfoOrderColumn.ADDED_AT:
        return 'added_at';
      case TautulliLibraryMediaInfoOrderColumn.SORT_TITLE:
        return 'sort_title';
      case TautulliLibraryMediaInfoOrderColumn.CONTAINER:
        return 'container';
      case TautulliLibraryMediaInfoOrderColumn.BITRATE:
        return 'bitrate';
      case TautulliLibraryMediaInfoOrderColumn.VIDEO_CODEC:
        return 'video_codec';
      case TautulliLibraryMediaInfoOrderColumn.VIDEO_RESOLUTION:
        return 'video_resolution';
      case TautulliLibraryMediaInfoOrderColumn.VIDEO_FRAMERATE:
        return 'video_framerate';
      case TautulliLibraryMediaInfoOrderColumn.AUDIO_CODEC:
        return 'audio_codec';
      case TautulliLibraryMediaInfoOrderColumn.AUDIO_CHANNELS:
        return 'audio_channels';
      case TautulliLibraryMediaInfoOrderColumn.FILE_SIZE:
        return 'file_size';
      case TautulliLibraryMediaInfoOrderColumn.LAST_PLAYED:
        return 'last_played';
      case TautulliLibraryMediaInfoOrderColumn.PLAY_COUNT:
        return 'play_count';
      case TautulliLibraryMediaInfoOrderColumn.NULL:
        return '';
    }
  }
}
