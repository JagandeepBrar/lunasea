part of radarr_types;

/// Enumerator to handle all protocol options used in Radarr.
enum RadarrProtocol {
  USENET,
  TORRENT,
}

/// Extension on [RadarrProtocol] to implement extended functionality.
extension RadarrProtocolExtension on RadarrProtocol {
  /// Given a String, will return the correct [RadarrProtocol] object.
  RadarrProtocol? from(String? type) {
    switch (type) {
      case 'usenet':
        return RadarrProtocol.USENET;
      case 'torrent':
        return RadarrProtocol.TORRENT;
      default:
        return null;
    }
  }

  String? get value {
    switch (this) {
      case RadarrProtocol.USENET:
        return 'usenet';
      case RadarrProtocol.TORRENT:
        return 'torrent';
      default:
        return null;
    }
  }

  String? get readable {
    switch (this) {
      case RadarrProtocol.USENET:
        return 'Usenet';
      case RadarrProtocol.TORRENT:
        return 'Torrent';
      default:
        return null;
    }
  }
}
