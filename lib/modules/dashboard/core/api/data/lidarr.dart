import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/lidarr.dart';
import './abstract.dart';

class CalendarLidarrData extends CalendarData {
  final Map<String, dynamic> api = Database.currentProfileObject.getLidarr();
  String albumTitle;
  int artistId;
  bool hasAllFiles;

  @override
  bool get isPosterSquare => true;

  CalendarLidarrData({
    @required int id,
    @required String title,
    @required this.albumTitle,
    @required this.artistId,
    @required this.hasAllFiles,
  }) : super(id, title);

  @override
  String get bannerURI {
    return api['enabled']
        ? (api['host'] as String).endsWith('/')
            ? '${api['host']}api/v1/MediaCover/Artist/$artistId/banner.jpg?apikey=${api['key']}'
            : '${api['host']}/api/v1/MediaCover/Artist/$artistId/banner.jpg?apikey=${api['key']}'
        : '';
  }

  @override
  List<TextSpan> get body {
    return [
      TextSpan(
        text: albumTitle,
        style: const TextStyle(
          fontStyle: FontStyle.italic,
        ),
      ),
      if (!hasAllFiles)
        const TextSpan(
          text: 'Not Downloaded',
          style: TextStyle(
            fontWeight: LunaUI.FONT_WEIGHT_BOLD,
            color: LunaColours.red,
          ),
        ),
      if (hasAllFiles)
        const TextSpan(
          text: 'Downloaded',
          style: TextStyle(
            fontWeight: LunaUI.FONT_WEIGHT_BOLD,
            color: LunaColours.accent,
          ),
        )
    ];
  }

  @override
  Future<void> enterContent(BuildContext context) async =>
      Navigator.of(context).pushNamed(
        LidarrDetailsArtist.ROUTE_NAME,
        arguments: LidarrDetailsArtistArguments(
          artistID: artistId,
          data: null,
        ),
      );

  @override
  Widget trailing(BuildContext context) => LunaIconButton(
        icon: Icons.search_rounded,
        onPressed: () async => trailingOnPress(context),
        onLongPress: () async => trailingOnLongPress(context),
      );

  @override
  Future<void> trailingOnPress(BuildContext context) async {
    await LidarrAPI.from(Database.currentProfileObject)
        .searchAlbums([id])
        .then((_) =>
            showLunaSuccessSnackBar(title: 'Searching...', message: albumTitle))
        .catchError((error) =>
            showLunaErrorSnackBar(title: 'Failed to Search', error: error));
  }

  @override
  Future<void> trailingOnLongPress(BuildContext context) async =>
      Navigator.of(context).pushNamed(
        LidarrSearchResults.ROUTE_NAME,
        arguments: LidarrSearchResultsArguments(
          albumID: id,
          title: albumTitle,
        ),
      );

  @override
  String backgroundUrl(BuildContext context) {
    return api['enabled']
        ? (api['host'] as String).endsWith('/')
            ? '${api['host']}api/v1/MediaCover/Artist/$artistId/fanart-360.jpg?apikey=${api['key']}'
            : '${api['host']}/api/v1/MediaCover/Artist/$artistId/fanart-360.jpg?apikey=${api['key']}'
        : '';
  }

  @override
  String posterUrl(BuildContext context) {
    return api['enabled']
        ? (api['host'] as String).endsWith('/')
            ? '${api['host']}api/v1/MediaCover/Artist/$artistId/poster-500.jpg?apikey=${api['key']}'
            : '${api['host']}/api/v1/MediaCover/Artist/$artistId/poster-500.jpg?apikey=${api['key']}'
        : '';
  }
}
