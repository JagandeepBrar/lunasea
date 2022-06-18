import 'package:lunasea/core.dart';

class LidarrAlbumData {
  String title;
  String releaseDate;
  int albumID;
  int trackCount;
  double percentageTracks;
  bool monitored;

  LidarrAlbumData({
    required this.albumID,
    required this.title,
    required this.monitored,
    required this.trackCount,
    required this.percentageTracks,
    required this.releaseDate,
  });

  DateTime? get releaseDateObject => DateTime.tryParse(releaseDate)?.toLocal();

  String get releaseDateString {
    if (releaseDateObject != null) {
      return DateFormat('MMMM dd, y').format(releaseDateObject!);
    }
    return 'Unknown Release Date';
  }

  String get tracks {
    return trackCount != 1 ? '$trackCount Tracks' : '$trackCount Track';
  }

  String albumCoverURI() {
    final host = LunaProfile.current.lidarrHost;
    final key = LunaProfile.current.lidarrKey;
    if (LunaProfile.current.lidarrEnabled) {
      String _base = host.endsWith('/')
          ? '${host}api/v1/MediaCover/Album'
          : '$host/api/v1/MediaCover/Album';
      return '$_base/$albumID/cover-250.jpg?apikey=$key';
    }
    return '';
  }
}
