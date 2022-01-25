part of radarr_types;

enum RadarrImportMode {
  COPY,
  MOVE,
}

/// Extension on [RadarrImportMode] to implement extended functionality.
extension RadarrImportModeExtension on RadarrImportMode {
  /// Given a String, will return the correct [RadarrImportMode] object.
  RadarrImportMode? from(String? type) {
    switch (type) {
      case 'copy':
        return RadarrImportMode.COPY;
      case 'move':
        return RadarrImportMode.MOVE;
      default:
        return null;
    }
  }

  String get value {
    switch (this) {
      case RadarrImportMode.COPY:
        return 'copy';
      case RadarrImportMode.MOVE:
        return 'move';
    }
  }
}
