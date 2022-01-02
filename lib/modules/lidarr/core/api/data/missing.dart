import 'package:lunasea/core.dart';

class LidarrMissingData {
  final Map<String, dynamic> api = Database.currentProfileObject!.getLidarr();
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
    if (api['enabled']) {
      String _base = (api['host'] as String).endsWith('/')
          ? '${api['host']}api/v1/MediaCover/Album'
          : '${api['host']}/api/v1/MediaCover/Album';
      return '$_base/$albumID/cover-250.jpg?apikey=${api['key']}';
    }
    return '';
  }

  String posterURI() {
    if (api['enabled']) {
      String _base = (api['host'] as String).endsWith('/')
          ? '${api['host']}api/v1/MediaCover/Artist'
          : '${api['host']}/api/v1/MediaCover/Artist';
      return '$_base/$artistID/poster-500.jpg?apikey=${api['key']}';
    }
    return '';
  }

  String fanartURI({bool highRes = false}) {
    if (api['enabled']) {
      String _base = (api['host'] as String).endsWith('/')
          ? '${api['host']}api/v1/MediaCover/Artist'
          : '${api['host']}/api/v1/MediaCover/Artist';
      return '$_base/$artistID/fanart-360.jpg?apikey=${api['key']}';
    }
    return '';
  }
}
