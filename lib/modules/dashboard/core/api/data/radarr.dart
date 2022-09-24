import 'package:flutter/material.dart';
import 'package:lunasea/extensions/int/duration.dart';
import 'package:lunasea/extensions/string/string.dart';
import 'package:lunasea/router/routes/radarr.dart';
import 'package:lunasea/vendor.dart';
import 'package:lunasea/widgets/ui.dart';
import 'package:lunasea/modules/radarr/core/api_helper.dart';
import 'package:lunasea/modules/radarr/core/state.dart';
import 'package:lunasea/modules/dashboard/core/api/data/abstract.dart';

class CalendarRadarrData extends CalendarData {
  bool hasFile;
  String? fileQualityProfile;
  int year;
  int runtime;
  String studio;
  DateTime releaseDate;

  CalendarRadarrData({
    required int id,
    required String title,
    required this.hasFile,
    required this.fileQualityProfile,
    required this.year,
    required this.runtime,
    required this.studio,
    required this.releaseDate,
  }) : super(id, title);

  bool get hasReleased => DateTime.now().isAfter(releaseDate);

  @override
  List<TextSpan> get body {
    final released = hasReleased;
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
        TextSpan(
          text: released ? 'radarr.Missing'.tr() : 'radarr.Unreleased'.tr(),
          style: TextStyle(
            fontWeight: LunaUI.FONT_WEIGHT_BOLD,
            color: released ? LunaColours.red : LunaColours.blue,
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
  Future<void> enterContent(BuildContext context) async {
    RadarrRoutes.MOVIE.go(params: {
      'movie': id.toString(),
    });
  }

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
  Future<void> trailingOnLongPress(BuildContext context) async {
    RadarrRoutes.MOVIE_RELEASES.go(params: {
      'movie': id.toString(),
    });
  }

  @override
  String? backgroundUrl(BuildContext context) {
    return context.read<RadarrState>().getFanartURL(this.id);
  }

  @override
  String? posterUrl(BuildContext context) {
    return context.read<RadarrState>().getPosterURL(this.id);
  }
}
