import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrSeriesEditQualityProfileTile extends StatelessWidget {
  final List<SonarrQualityProfile?> profiles;

  const SonarrSeriesEditQualityProfileTile({
    Key? key,
    required this.profiles,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LunaBlock(
      title: 'sonarr.QualityProfile'.tr(),
      body: [
        TextSpan(
          text: context.watch<SonarrSeriesEditState>().qualityProfile?.name ??
              LunaUI.TEXT_EMDASH,
        )
      ],
      trailing: const LunaIconButton.arrow(),
      onTap: () async => _onTap(context),
    );
  }

  Future<void> _onTap(BuildContext context) async {
    Tuple2<bool, SonarrQualityProfile?> result =
        await SonarrDialogs().editQualityProfile(context, profiles);
    if (result.item1)
      context.read<SonarrSeriesEditState>().qualityProfile = result.item2!;
  }
}
