import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class SonarrSeasonHeader extends StatelessWidget {
  final int seasonNumber;

  const SonarrSeasonHeader({
    Key key,
    @required this.seasonNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => LunaHeader(
        text: seasonNumber == 0
            ? 'sonarr.Specials'.tr()
            : 'sonarr.SeasonNumber'.tr(
                args: [seasonNumber.toString()],
              ),
      );
}
