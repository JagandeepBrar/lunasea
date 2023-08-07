import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/mylar.dart';

class MylarSeasonHeader extends StatelessWidget {
  final int seriesId;
  final int? seasonNumber;

  const MylarSeasonHeader({
    Key? key,
    required this.seriesId,
    required this.seasonNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: LunaHeader(
        text: seasonNumber == 0
            ? 'mylar.Specials'.tr()
            : 'mylar.SeasonNumber'.tr(
                args: [seasonNumber.toString()],
              ),
      ),
      onTap: () => context
          .read<MylarSeasonDetailsState>()
          .toggleSeasonEpisodes(seasonNumber!),
      onLongPress: () async {
        HapticFeedback.heavyImpact();
        Tuple2<bool, MylarSeasonSettingsType?> result =
            await MylarDialogs().seasonSettings(context, seasonNumber);
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
