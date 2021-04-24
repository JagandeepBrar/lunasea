import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrSeriesAddDetailsUseSeasonFoldersTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) => LunaListTile(
        context: context,
        title: LunaText.title(text: 'Use Season Folders'),
        subtitle: LunaText.subtitle(text: 'Sort episodes into season folders'),
        trailing: LunaSwitch(
          value: context.watch<SonarrSeriesAddDetailsState>().useSeasonFolders,
          onChanged: (value) {
            context.read<SonarrSeriesAddDetailsState>().useSeasonFolders =
                value;
            SonarrDatabaseValue.ADD_SERIES_DEFAULT_USE_SEASON_FOLDERS
                .put(value);
          },
        ),
      );
}
