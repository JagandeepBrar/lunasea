part of tautulli_types;

/// Enumerator to handle all library order columns used in Tautulli.
enum TautulliLibrariesOrderColumn {
  LIBRARY_THUMB,
  SECTION_NAME,
  SECTION_TYPE,
  COUNT,
  PARENT_COUNT,
  CHILD_COUNT,
  LAST_ACCESSED,
  LAST_PLAYED,
  PLAYS,
  DURATION,
  NULL,
}

/// Extension on [TautulliLibrariesOrderColumn] to implement extended functionality.
extension TautulliLibrariesOrderColumnExtension
    on TautulliLibrariesOrderColumn {
  /// The actual value/key for the library order column used in Tautulli.
  String? get value {
    switch (this) {
      case TautulliLibrariesOrderColumn.LIBRARY_THUMB:
        return 'library_thumb';
      case TautulliLibrariesOrderColumn.SECTION_NAME:
        return 'section_name';
      case TautulliLibrariesOrderColumn.SECTION_TYPE:
        return 'section_type';
      case TautulliLibrariesOrderColumn.COUNT:
        return 'count';
      case TautulliLibrariesOrderColumn.PARENT_COUNT:
        return 'parent_count';
      case TautulliLibrariesOrderColumn.CHILD_COUNT:
        return 'child_count';
      case TautulliLibrariesOrderColumn.LAST_ACCESSED:
        return 'last_accessed';
      case TautulliLibrariesOrderColumn.LAST_PLAYED:
        return 'last_played';
      case TautulliLibrariesOrderColumn.PLAYS:
        return 'plays';
      case TautulliLibrariesOrderColumn.DURATION:
        return 'duration';
      case TautulliLibrariesOrderColumn.NULL:
        return '';
    }
  }
}
