import 'package:flutter/material.dart';
import 'package:lunasea/database/models/profile.dart';
import 'package:lunasea/router/routes/lidarr.dart';
import 'package:lunasea/widgets/ui.dart';
import 'package:lunasea/modules/lidarr/core/api/api.dart';
import 'package:lunasea/modules/dashboard/core/api/data/abstract.dart';

class CalendarLidarrData extends CalendarData {
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
  Future<void> enterContent(BuildContext context) async {
    LidarrRoutes.ARTIST.go(params: {
      'artist': artistId.toString(),
    });
  }

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
  Future<void> trailingOnLongPress(BuildContext context) async {
    LidarrRoutes.ARTIST_ALBUM_RELEASES.go(params: {
      'artist': artistId.toString(),
      'album': id.toString(),
    });
  }

  @override
  String backgroundUrl(BuildContext context) {
    final host = LunaProfile.current.lidarrHost;
    final key = LunaProfile.current.lidarrKey;
    if (LunaProfile.current.lidarrEnabled) {
      String _base = host.endsWith('/')
          ? '${host}api/v1/MediaCover/Artist'
          : '$host/api/v1/MediaCover/Artist';
      return '$_base/$artistId/fanart-360.jpg?apikey=$key';
    }
    return '';
  }

  @override
  String posterUrl(BuildContext context) {
    final host = LunaProfile.current.lidarrHost;
    final key = LunaProfile.current.lidarrKey;
    if (LunaProfile.current.lidarrEnabled) {
      String _base = host.endsWith('/')
          ? '${host}api/v1/MediaCover/Artist'
          : '$host/api/v1/MediaCover/Artist';
      return '$_base/$artistId/poster-500.jpg?apikey=$key';
    }
    return '';
  }
}
