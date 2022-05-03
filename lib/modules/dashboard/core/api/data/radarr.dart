import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/system/profile.dart';
import '../../../../../core/extensions.dart';
import '../../../../../ui/ui.dart';
import '../../../../../vendor.dart';
import '../../../../radarr/core/api_helper.dart';
import '../../../../radarr/core/state.dart';
import '../../../../radarr/routes/movie_details/route.dart';
import '../../../../radarr/routes/releases/route.dart';
import './abstract.dart';

class CalendarRadarrData extends CalendarData {
  final Map<String, dynamic> api = LunaProfile.current.getRadarr();
  bool hasFile;
  String? fileQualityProfile;
  int year;
  int runtime;
  String studio;

  CalendarRadarrData({
    required int id,
    required String title,
    required this.hasFile,
    required this.fileQualityProfile,
    required this.year,
    required this.runtime,
    required this.studio,
  }) : super(id, title);

  @override
  List<TextSpan> get body {
    return [
      TextSpan(
        children: [
          TextSpan(text: year.toString()),
          TextSpan(text: LunaUI.TEXT_BULLET.lunaPad()),
          TextSpan(text: runtime.lunaRuntime()),
        ],
      ),
      TextSpan(text: studio),
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
    ];
  }

  @override
  Future<void> enterContent(BuildContext context) async =>
      RadarrMoviesDetailsRouter().navigateTo(context, id);

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
      RadarrReleasesRouter().navigateTo(context, id);

  @override
  String? backgroundUrl(BuildContext context) {
    return context.read<RadarrState>().getFanartURL(this.id);
  }

  @override
  String? posterUrl(BuildContext context) {
    return context.read<RadarrState>().getPosterURL(this.id);
  }
}
