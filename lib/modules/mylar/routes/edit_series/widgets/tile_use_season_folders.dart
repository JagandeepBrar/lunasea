import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/mylar.dart';

class MylarSeriesEditSeasonFoldersTile extends StatelessWidget {
  const MylarSeriesEditSeasonFoldersTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LunaBlock(
      title: 'mylar.UseSeasonFolders'.tr(),
      trailing: LunaSwitch(
        value: context.watch<MylarSeriesEditState>().useSeasonFolders,
        onChanged: (value) {
          context.read<MylarSeriesEditState>().useSeasonFolders = value;
        },
      ),
    );
  }
}
