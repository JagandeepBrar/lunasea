import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/mylar.dart';

class MylarSeriesAddDetailsUseSeasonFoldersTile extends StatelessWidget {
  const MylarSeriesAddDetailsUseSeasonFoldersTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LunaBlock(
      title: 'mylar.SeasonFolders'.tr(),
      trailing: LunaSwitch(
        value: context.watch<MylarSeriesAddDetailsState>().useSeasonFolders,
        onChanged: (value) {
          context.read<MylarSeriesAddDetailsState>().useSeasonFolders = value;
          MylarDatabase.ADD_SERIES_DEFAULT_USE_SEASON_FOLDERS.update(value);
        },
      ),
    );
  }
}
