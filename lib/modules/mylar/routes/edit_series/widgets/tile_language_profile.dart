import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/mylar.dart';

class MylarSeriesEditLanguageProfileTile extends StatelessWidget {
  final List<MylarLanguageProfile?> profiles;

  const MylarSeriesEditLanguageProfileTile({
    Key? key,
    required this.profiles,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LunaBlock(
      title: 'mylar.LanguageProfile'.tr(),
      body: [
        TextSpan(
          text: context.watch<MylarSeriesEditState>().languageProfile?.name ??
              LunaUI.TEXT_EMDASH,
        ),
      ],
      trailing: const LunaIconButton.arrow(),
      onTap: () async => _onTap(context),
    );
  }

  Future<void> _onTap(BuildContext context) async {
    Tuple2<bool, MylarLanguageProfile?> result =
        await MylarDialogs().editLanguageProfiles(context, profiles);
    if (result.item1)
      context.read<MylarSeriesEditState>().languageProfile = result.item2!;
  }
}
