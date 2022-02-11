part of readarr_types;

enum ReadarrProtocol {
  USENET,
  TORRENT,
}

extension ReadarrProtocolExtension on ReadarrProtocol {
  ReadarrProtocol? from(String? type) {
    switch (type) {
      case 'usenet':
        return ReadarrProtocol.USENET;
      case 'torrent':
        return ReadarrProtocol.TORRENT;
      default:
        return null;
    }
  }

  String? get value {
    switch (this) {
      case ReadarrProtocol.USENET:
        return 'usenet';
      case ReadarrProtocol.TORRENT:
        return 'torrent';
      default:
        return null;
    }
  }

  String? get readable {
    switch (this) {
      case ReadarrProtocol.USENET:
        return 'Usenet';
      case ReadarrProtocol.TORRENT:
        return 'Torrent';
      default:
        return null;
    }
  }
}
