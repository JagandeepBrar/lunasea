import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/readarr.dart';

class ReadarrAuthorEditQualityProfileTile extends StatelessWidget {
  final List<ReadarrQualityProfile?> profiles;

  const ReadarrAuthorEditQualityProfileTile({
    Key? key,
    required this.profiles,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LunaBlock(
      title: 'readarr.QualityProfile'.tr(),
      body: [
        TextSpan(
          text: context.watch<ReadarrAuthorEditState>().qualityProfile?.name ??
              LunaUI.TEXT_EMDASH,
        )
      ],
      trailing: const LunaIconButton.arrow(),
      onTap: () async => _onTap(context),
    );
  }

  Future<void> _onTap(BuildContext context) async {
    Tuple2<bool, ReadarrQualityProfile?> result =
        await ReadarrDialogs().editQualityProfile(context, profiles);
    if (result.item1)
      context.read<ReadarrAuthorEditState>().qualityProfile = result.item2!;
  }
}
