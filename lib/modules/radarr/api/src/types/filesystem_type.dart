part of radarr_types;

/// Enumerator to handle all fileystem types used in Radarr.
enum RadarrFileSystemType {
  FOLDER,
  FILE,
}

/// Extension on [RadarrFileSystemType] to implement extended functionality.
extension RadarrFileSystemTypeExtension on RadarrFileSystemType {
  /// Given a String, will return the correct [RadarrFileSystemType] object.
  RadarrFileSystemType? from(String? type) {
    switch (type) {
      case 'folder':
        return RadarrFileSystemType.FOLDER;
      case 'file':
        return RadarrFileSystemType.FILE;
      default:
        return null;
    }
  }

  String? get value {
    switch (this) {
      case RadarrFileSystemType.FOLDER:
        return 'folder';
      case RadarrFileSystemType.FILE:
        return 'file';
      default:
        return null;
    }
  }

  String? get readable {
    switch (this) {
      case RadarrFileSystemType.FOLDER:
        return 'Folder';
      case RadarrFileSystemType.FILE:
        return 'File';
      default:
        return null;
    }
  }
}
