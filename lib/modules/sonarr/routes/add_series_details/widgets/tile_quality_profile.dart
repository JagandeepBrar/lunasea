import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrSeriesAddDetailsQualityProfileTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LunaListTile(
      context: context,
      title: LunaText.title(text: 'Quality Profile'),
      subtitle: LunaText.subtitle(
          text: context
                  .watch<SonarrSeriesAddDetailsState>()
                  .qualityProfile
                  ?.name ??
              LunaUI.TEXT_EMDASH),
      trailing: LunaIconButton(icon: Icons.arrow_forward_ios_rounded),
      onTap: () async => _onTap(context),
    );
  }

  Future<void> _onTap(BuildContext context) async {
    List<SonarrQualityProfile> _profiles =
        await context.read<SonarrState>().qualityProfiles;
    Tuple2<bool, SonarrQualityProfile> result =
        await SonarrDialogs().editQualityProfile(context, _profiles);
    if (result.item1) {
      context.read<SonarrSeriesAddDetailsState>().qualityProfile = result.item2;
      SonarrDatabaseValue.ADD_SERIES_DEFAULT_QUALITY_PROFILE
          .put(result.item2.id);
    }
  }
}
