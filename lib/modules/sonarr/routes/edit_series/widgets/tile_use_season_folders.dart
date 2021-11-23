import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrSeriesEditSeasonFoldersTile extends StatelessWidget {
  const SonarrSeriesEditSeasonFoldersTile({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LunaListTile(
      context: context,
      title: LunaText.title(text: 'sonarr.UseSeasonFolders'.tr()),
      subtitle:
          LunaText.subtitle(text: 'sonarr.UseSeasonFoldersDescription'.tr()),
      trailing: LunaSwitch(
        value: context.watch<SonarrSeriesEditState>().useSeasonFolders,
        onChanged: (value) =>
            context.read<SonarrSeriesEditState>().useSeasonFolders = value,
      ),
    );
  }
}
