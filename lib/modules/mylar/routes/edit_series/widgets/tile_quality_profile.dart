import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/mylar.dart';

class MylarSeriesEditQualityProfileTile extends StatelessWidget {
  final List<MylarQualityProfile?> profiles;

  const MylarSeriesEditQualityProfileTile({
    Key? key,
    required this.profiles,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LunaBlock(
      title: 'mylar.QualityProfile'.tr(),
      body: [
        TextSpan(
          text: context.watch<MylarSeriesEditState>().qualityProfile?.name ??
              LunaUI.TEXT_EMDASH,
        )
      ],
      trailing: const LunaIconButton.arrow(),
      onTap: () async => _onTap(context),
    );
  }

  Future<void> _onTap(BuildContext context) async {
    Tuple2<bool, MylarQualityProfile?> result =
        await MylarDialogs().editQualityProfile(context, profiles);
    if (result.item1)
      context.read<MylarSeriesEditState>().qualityProfile = result.item2!;
  }
}
