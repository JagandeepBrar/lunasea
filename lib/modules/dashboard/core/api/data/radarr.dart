import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';
import './abstract.dart';

class CalendarRadarrData extends CalendarData {
  final Map<String, dynamic> api = Database.currentProfileObject.getRadarr();
  bool hasFile;
  String fileQualityProfile;
  int year;
  int runtime;

  CalendarRadarrData({
    @required int id,
    @required String title,
    @required this.hasFile,
    @required this.fileQualityProfile,
    @required this.year,
    @required this.runtime,
  }) : super(id, title);

  @override
  TextSpan get subtitle => TextSpan(
        style: const TextStyle(
          color: Colors.white70,
          fontSize: LunaUI.FONT_SIZE_H3,
        ),
        children: [
          TextSpan(
            children: [
              TextSpan(text: year.toString()),
              TextSpan(text: LunaUI.TEXT_BULLET.lunaPad(1, '\t')),
              TextSpan(text: runtime.lunaRuntime()),
            ],
          ),
          const TextSpan(text: '\n'),
          if (!hasFile)
            const TextSpan(
              text: 'Not Downloaded',
              style: TextStyle(
                fontWeight: LunaUI.FONT_WEIGHT_BOLD,
                color: LunaColours.red,
              ),
            ),
          if (hasFile)
            TextSpan(
              text: 'Downloaded ($fileQualityProfile)',
              style: const TextStyle(
                fontWeight: LunaUI.FONT_WEIGHT_BOLD,
                color: LunaColours.accent,
              ),
            )
        ],
      );

  @override
  String get bannerURI {
    if (api['enabled']) {
      if ((api['host'] as String).endsWith('/')) {
        return '${api['host']}api/MediaCover/$id/fanart-360.jpg?apikey=${api['key']}';
      }
      return '${api['host']}/api/MediaCover/$id/fanart-360.jpg?apikey=${api['key']}';
    }
    return '';
  }

  @override
  Future<void> enterContent(BuildContext context) async =>
      RadarrMoviesDetailsRouter().navigateTo(context, movieId: id);

  @override
  Widget trailing(BuildContext context) {
    return LunaIconButton(
      icon: Icons.search_rounded,
      onPressed: () async => trailingOnPress(context),
      onLongPress: () async => trailingOnLongPress(context),
    );
  }

  @override
  Future<void> trailingOnPress(BuildContext context) async => RadarrAPIHelper()
      .automaticSearch(context: context, movieId: id, title: title);

  @override
  Future<void> trailingOnLongPress(BuildContext context) async =>
      RadarrReleasesRouter().navigateTo(context, movieId: id);
}
