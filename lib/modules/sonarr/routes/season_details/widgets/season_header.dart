import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrSeasonHeader extends StatelessWidget {
  final int seriesId;
  final int? seasonNumber;

  const SonarrSeasonHeader({
    Key? key,
    required this.seriesId,
    required this.seasonNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: LunaHeader(
        text: seasonNumber == 0
            ? 'sonarr.Specials'.tr()
            : 'sonarr.SeasonNumber'.tr(
                args: [seasonNumber.toString()],
              ),
      ),
      onTap: () => context
          .read<SonarrSeasonDetailsState>()
          .toggleSeasonEpisodes(seasonNumber!),
      onLongPress: () async {
        HapticFeedback.heavyImpact();
        Tuple2<bool, SonarrSeasonSettingsType?> result =
            await SonarrDialogs().seasonSettings(context, seasonNumber);
        if (result.item1) {
          result.item2!.execute(
            context,
            seriesId,
            seasonNumber,
          );
        }
      },
    );
  }
}
