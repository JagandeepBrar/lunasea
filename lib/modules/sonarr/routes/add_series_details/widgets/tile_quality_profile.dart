import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrSeriesAddDetailsQualityProfileTile extends StatelessWidget {
  const SonarrSeriesAddDetailsQualityProfileTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LunaBlock(
      title: 'sonarr.QualityProfile'.tr(),
      body: [
        TextSpan(
          text: context
                  .watch<SonarrSeriesAddDetailsState>()
                  .qualityProfile
                  .name ??
              LunaUI.TEXT_EMDASH,
        ),
      ],
      trailing: const LunaIconButton.arrow(),
      onTap: () async => _onTap(context),
    );
  }

  Future<void> _onTap(BuildContext context) async {
    List<SonarrQualityProfile> _profiles =
        await context.read<SonarrState>().qualityProfiles!;
    Tuple2<bool, SonarrQualityProfile?> result =
        await SonarrDialogs().editQualityProfile(context, _profiles);
    if (result.item1) {
      context.read<SonarrSeriesAddDetailsState>().qualityProfile =
          result.item2!;
      SonarrDatabase.ADD_SERIES_DEFAULT_QUALITY_PROFILE
          .update(result.item2!.id);
    }
  }
}
