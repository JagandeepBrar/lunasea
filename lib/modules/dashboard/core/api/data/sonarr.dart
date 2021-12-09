import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';
import './abstract.dart';

class CalendarSonarrData extends CalendarData {
  final Map<String, dynamic> api = Database.currentProfileObject.getSonarr();
  String episodeTitle;
  int seasonNumber;
  int episodeNumber;
  int seriesID;
  String airTime;
  bool hasFile;
  String fileQualityProfile;

  CalendarSonarrData({
    @required int id,
    @required String title,
    @required this.episodeTitle,
    @required this.seasonNumber,
    @required this.episodeNumber,
    @required this.seriesID,
    @required this.airTime,
    @required this.hasFile,
    @required this.fileQualityProfile,
  }) : super(id, title);

  @override
  TextSpan get subtitle => TextSpan(
        style: const TextStyle(
          color: Colors.white70,
          fontSize: LunaUI.FONT_SIZE_H3,
        ),
        children: <TextSpan>[
          TextSpan(
            text: 'Season $seasonNumber Episode $episodeNumber: ',
          ),
          TextSpan(
            text: episodeTitle,
            style: const TextStyle(
              fontStyle: FontStyle.italic,
            ),
          ),
          if (!hasFile)
            TextSpan(
              text: hasAired ? '\nMissing' : '\nUnaired',
              style: TextStyle(
                fontWeight: LunaUI.FONT_WEIGHT_BOLD,
                color: hasAired ? LunaColours.red : LunaColours.blue,
              ),
            ),
          if (hasFile)
            TextSpan(
              text: '\nDownloaded ($fileQualityProfile)',
              style: const TextStyle(
                fontWeight: LunaUI.FONT_WEIGHT_BOLD,
                color: LunaColours.accent,
              ),
            )
        ],
      );

  bool get hasAired {
    if (airTimeObject != null) return DateTime.now().isAfter(airTimeObject);
    return false;
  }

  @override
  String get bannerURI {
    return api['enabled']
        ? (api['host'] as String).endsWith('/')
            ? '${api['host']}api/mediacover/$seriesID/banner-70.jpg?apikey=${api['key']}'
            : '${api['host']}/api/mediacover/$seriesID/banner-70.jpg?apikey=${api['key']}'
        : '';
  }

  @override
  Future<void> enterContent(BuildContext context) async =>
      SonarrSeriesDetailsRouter().navigateTo(
        context,
        seriesId: seriesID,
      );

  @override
  Widget trailing(BuildContext context) => InkWell(
        child: LunaIconButton(
          text: airTimeString,
          onPressed: () async => trailingOnPress(context),
          onLongPress: () => trailingOnLongPress(context),
        ),
      );

  DateTime get airTimeObject {
    return DateTime.tryParse(airTime)?.toLocal();
  }

  String get airTimeString {
    if (airTimeObject != null) {
      return LunaDatabaseValue.USE_24_HOUR_TIME.data
          ? DateFormat.Hm().format(airTimeObject)
          : DateFormat('hh:mm\na').format(airTimeObject);
    }
    return 'Unknown';
  }

  @override
  Future<void> trailingOnPress(BuildContext context) async {
    if (context.read<SonarrState>().api != null)
      context
          .read<SonarrState>()
          .api
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
}
