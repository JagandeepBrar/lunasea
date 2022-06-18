import 'package:lunasea/core.dart';

class LidarrMissingData {
  String title;
  String artistTitle;
  String releaseDate;
  int artistID;
  int albumID;
  bool monitored;

  LidarrMissingData({
    required this.title,
    required this.artistTitle,
    required this.artistID,
    required this.albumID,
    required this.releaseDate,
    required this.monitored,
  });

  DateTime? get releaseDateObject {
    return DateTime.tryParse(releaseDate)?.toLocal();
  }

  String get releaseDateString {
    if (releaseDateObject != null) {
      Duration age = DateTime.now().difference(releaseDateObject!);
      if (age.inDays >= 1) {
        return age.inDays <= 1
            ? '${age.inDays} Day Ago'
            : '${age.inDays} Days Ago';
      }
      if (age.inHours >= 1) {
        return age.inHours <= 1
            ? '${age.inHours} Hour Ago'
            : '${age.inHours} Hours Ago';
      }
      return age.inMinutes <= 1
          ? '${age.inMinutes} Minute Ago'
          : '${age.inMinutes} Minutes Ago';
    }
    return 'Unknown Date/Time';
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

  String posterURI() {
    final host = LunaProfile.current.lidarrHost;
    final key = LunaProfile.current.lidarrKey;
    if (LunaProfile.current.lidarrEnabled) {
      String _base = host.endsWith('/')
          ? '${host}api/v1/MediaCover/Artist'
          : '$host/api/v1/MediaCover/Artist';
      return '$_base/$artistID/poster-500.jpg?apikey=$key';
    }
    return '';
  }

  String fanartURI({bool highRes = false}) {
    final host = LunaProfile.current.lidarrHost;
    final key = LunaProfile.current.lidarrKey;
    if (LunaProfile.current.lidarrEnabled) {
      String _base = host.endsWith('/')
          ? '${host}api/v1/MediaCover/Artist'
          : '$host/api/v1/MediaCover/Artist';
      return '$_base/$artistID/fanart-360.jpg?apikey=$key';
    }
    return '';
  }
}
