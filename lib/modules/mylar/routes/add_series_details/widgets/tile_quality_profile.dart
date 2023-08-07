import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/mylar.dart';

class MylarSeriesAddDetailsQualityProfileTile extends StatelessWidget {
  const MylarSeriesAddDetailsQualityProfileTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LunaBlock(
      title: 'mylar.QualityProfile'.tr(),
      body: [
        TextSpan(
          text: context
                  .watch<MylarSeriesAddDetailsState>()
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
    List<MylarQualityProfile> _profiles =
        await context.read<MylarState>().qualityProfiles!;
    Tuple2<bool, MylarQualityProfile?> result =
        await MylarDialogs().editQualityProfile(context, _profiles);
    if (result.item1) {
      context.read<MylarSeriesAddDetailsState>().qualityProfile =
          result.item2!;
      MylarDatabase.ADD_SERIES_DEFAULT_QUALITY_PROFILE
          .update(result.item2!.id);
    }
  }
}
