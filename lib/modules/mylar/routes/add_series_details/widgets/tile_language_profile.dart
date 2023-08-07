import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/mylar.dart';

class MylarSeriesAddDetailsLanguageProfileTile extends StatelessWidget {
  const MylarSeriesAddDetailsLanguageProfileTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LunaBlock(
      title: 'mylar.LanguageProfile'.tr(),
      body: [
        TextSpan(
          text: context
                  .watch<MylarSeriesAddDetailsState>()
                  .languageProfile
                  .name ??
              LunaUI.TEXT_EMDASH,
        ),
      ],
      trailing: const LunaIconButton.arrow(),
      onTap: () async => _onTap(context),
    );
  }

  Future<void> _onTap(BuildContext context) async {
    List<MylarLanguageProfile> _profiles =
        await context.read<MylarState>().languageProfiles!;
    Tuple2<bool, MylarLanguageProfile?> result =
        await MylarDialogs().editLanguageProfiles(context, _profiles);
    if (result.item1) {
      context.read<MylarSeriesAddDetailsState>().languageProfile =
          result.item2!;
      MylarDatabase.ADD_SERIES_DEFAULT_LANGUAGE_PROFILE
          .update(result.item2!.id);
    }
  }
}
