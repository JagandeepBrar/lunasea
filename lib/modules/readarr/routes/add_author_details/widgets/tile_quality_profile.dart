import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/readarr.dart';

class ReadarrAuthorAddDetailsQualityProfileTile extends StatelessWidget {
  const ReadarrAuthorAddDetailsQualityProfileTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LunaBlock(
      title: 'readarr.QualityProfile'.tr(),
      body: [
        TextSpan(
          text: context
                  .watch<ReadarrAuthorAddDetailsState>()
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
    List<ReadarrQualityProfile> _profiles =
        await context.read<ReadarrState>().qualityProfiles!;
    Tuple2<bool, ReadarrQualityProfile?> result =
        await ReadarrDialogs().editQualityProfile(context, _profiles);
    if (result.item1) {
      context.read<ReadarrAuthorAddDetailsState>().qualityProfile =
          result.item2!;
      ReadarrDatabaseValue.ADD_SERIES_DEFAULT_QUALITY_PROFILE
          .put(result.item2!.id);
    }
  }
}
