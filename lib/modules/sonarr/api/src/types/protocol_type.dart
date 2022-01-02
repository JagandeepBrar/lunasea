part of sonarr_types;

enum SonarrProtocol {
  USENET,
  TORRENT,
}

extension SonarrProtocolExtension on SonarrProtocol {
  SonarrProtocol? from(String? type) {
    switch (type) {
      case 'usenet':
        return SonarrProtocol.USENET;
      case 'torrent':
        return SonarrProtocol.TORRENT;
      default:
        return null;
    }
  }

  String? get value {
    switch (this) {
      case SonarrProtocol.USENET:
        return 'usenet';
      case SonarrProtocol.TORRENT:
        return 'torrent';
      default:
        return null;
    }
  }

  String? get readable {
    switch (this) {
      case SonarrProtocol.USENET:
        return 'Usenet';
      case SonarrProtocol.TORRENT:
        return 'Torrent';
      default:
        return null;
    }
  }
}
