import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrSeriesAddDetailsUseSeasonFoldersTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(text: 'Use Season Folders'),
        subtitle: LSSubtitle(text: 'Sort episodes into season folders'),
        trailing: Switch(
            value: context.watch<SonarrSeriesAddDetailsState>().useSeasonFolders,
            onChanged: (value) {
                context.read<SonarrSeriesAddDetailsState>().useSeasonFolders = value;
                SonarrDatabaseValue.ADD_SERIES_DEFAULT_USE_SEASON_FOLDERS.put(value);
            },
        ),
    );
}
