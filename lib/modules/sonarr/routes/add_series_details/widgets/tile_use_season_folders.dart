import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrSeriesAddDetailsUseSeasonFoldersTile extends StatelessWidget {
  const SonarrSeriesAddDetailsUseSeasonFoldersTile({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LunaListTile(
      context: context,
      title: LunaText.title(
        text: 'sonarr.SeasonFolders'.tr(),
      ),
      subtitle: LunaText.subtitle(
        text: 'sonarr.SeasonFoldersDescription'.tr(),
      ),
      trailing: LunaSwitch(
        value: context.watch<SonarrSeriesAddDetailsState>().useSeasonFolders,
        onChanged: (value) {
          context.read<SonarrSeriesAddDetailsState>().useSeasonFolders = value;
          SonarrDatabaseValue.ADD_SERIES_DEFAULT_USE_SEASON_FOLDERS.put(value);
        },
      ),
    );
  }
}
