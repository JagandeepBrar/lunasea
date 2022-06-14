import 'package:flutter/material.dart';
import 'package:lunasea/database/models/profile.dart';
import 'package:lunasea/extensions/int/duration.dart';
import 'package:lunasea/extensions/string/string.dart';
import 'package:lunasea/vendor.dart';
import 'package:lunasea/widgets/ui.dart';
import 'package:lunasea/modules/radarr/core/api_helper.dart';
import 'package:lunasea/modules/radarr/core/state.dart';
import 'package:lunasea/modules/radarr/routes/movie_details/route.dart';
import 'package:lunasea/modules/radarr/routes/releases/route.dart';
import 'package:lunasea/modules/dashboard/core/api/data/abstract.dart';

import 'package:provider/provider.dart';

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
          TextSpan(text: LunaUI.TEXT_BULLET.pad()),
          TextSpan(text: runtime.asVideoDuration()),
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
