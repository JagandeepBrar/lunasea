import 'package:flutter/material.dart';

import '../../../../../core/system/profile.dart';
import '../../../../../ui/ui.dart';
import '../../../../lidarr/core/api/api.dart';
import '../../../../lidarr/routes/details_artist.dart';
import '../../../../lidarr/routes/search_results.dart';
import './abstract.dart';

class CalendarLidarrData extends CalendarData {
  final Map<String, dynamic> api = LunaProfile.current.getLidarr();
  String albumTitle;
  int artistId;
  int totalTrackCount;
  bool hasAllFiles;

  CalendarLidarrData({
    required int id,
    required String title,
    required this.albumTitle,
    required this.artistId,
    required this.hasAllFiles,
    required this.totalTrackCount,
  }) : super(id, title);

  @override
  List<TextSpan> get body {
    return [
      TextSpan(
        text: albumTitle,
        style: const TextStyle(
          fontStyle: FontStyle.italic,
        ),
      ),
      TextSpan(
        text: totalTrackCount == 1 ? '1 Track' : '$totalTrackCount Tracks',
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
    await LidarrAPI.from(LunaProfile.current)
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
