import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';
import './abstract.dart';

class CalendarSonarrData extends CalendarData {
  final Map<String, dynamic> api = Database.currentProfileObject!.getSonarr();
  String episodeTitle;
  int seasonNumber;
  int episodeNumber;
  int seriesID;
  String airTime;
  bool hasFile;
  String? fileQualityProfile;

  CalendarSonarrData({
    required int id,
    required String title,
    required this.episodeTitle,
    required this.seasonNumber,
    required this.episodeNumber,
    required this.seriesID,
    required this.airTime,
    required this.hasFile,
    required this.fileQualityProfile,
  }) : super(id, title);

  @override
  List<TextSpan> get body {
    return [
      TextSpan(
        children: [
          TextSpan(
              text: seasonNumber == 0 ? 'Specials' : 'Season $seasonNumber'),
          TextSpan(text: LunaUI.TEXT_BULLET.lunaPad()),
          TextSpan(text: 'Episode $episodeNumber'),
        ],
      ),
      TextSpan(
        style: const TextStyle(
          fontStyle: FontStyle.italic,
        ),
        text: episodeTitle ?? 'lunasea.Unknown'.tr(),
      ),
      if (!hasFile)
        TextSpan(
          text: hasAired ? 'sonarr.Missing'.tr() : 'sonarr.Unaired'.tr(),
          style: TextStyle(
            fontWeight: LunaUI.FONT_WEIGHT_BOLD,
            color: hasAired ? LunaColours.red : LunaColours.blue,
          ),
        ),
      if (hasFile)
        TextSpan(
          text: 'Downloaded ($fileQualityProfile)',
          style: const TextStyle(
            fontWeight: LunaUI.FONT_WEIGHT_BOLD,
            color: LunaColours.accent,
          ),
        ),
    ];
  }

  bool get hasAired {
    if (airTimeObject != null) return DateTime.now().isAfter(airTimeObject!);
    return false;
  }

  @override
  Future<void> enterContent(BuildContext context) async =>
      SonarrSeriesDetailsRouter().navigateTo(
        context,
        seriesId: seriesID,
      );

  @override
  Widget trailing(BuildContext context) => LunaIconButton(
        text: airTimeString,
        onPressed: () async => trailingOnPress(context),
        onLongPress: () => trailingOnLongPress(context),
      );

  DateTime? get airTimeObject {
    return DateTime.tryParse(airTime)?.toLocal();
  }

  String get airTimeString {
    if (airTimeObject != null) {
      return LunaDatabaseValue.USE_24_HOUR_TIME.data
          ? DateFormat.Hm().format(airTimeObject!)
          : DateFormat('hh:mm\na').format(airTimeObject!);
    }
    return 'Unknown';
  }

  @override
  Future<void> trailingOnPress(BuildContext context) async {
    if (context.read<SonarrState>().api != null)
      context
          .read<SonarrState>()
          .api!
          .command
          .episodeSearch(episodeIds: [id])
          .then((_) => showLunaSuccessSnackBar(
                title: 'Searching for Episode...',
                message: episodeTitle,
              ))
          .catchError((error, stack) {
            LunaLogger().error(
              'Failed to search for episode: $id',
              error,
              stack,
            );
            showLunaErrorSnackBar(
              title: 'Failed to Search',
              error: error,
            );
          });
  }

  @override
  Future<void> trailingOnLongPress(BuildContext context) async =>
      SonarrReleasesRouter().navigateTo(
        context,
        episodeId: id,
      );

  @override
  String? backgroundUrl(BuildContext context) {
    return context.read<SonarrState>().getFanartURL(this.seriesID);
  }

  @override
  String? posterUrl(BuildContext context) {
    return context.read<SonarrState>().getPosterURL(this.seriesID);
  }
}
