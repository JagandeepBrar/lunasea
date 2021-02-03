import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrSeriesEditSeasonFoldersTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(text: 'Use Season Folders'),
        subtitle: LSSubtitle(text: 'Sort episodes into season folders'),
        trailing: LunaSwitch(
            value: context.watch<SonarrSeriesEditState>().useSeasonFolders,
            onChanged: (value) => context.read<SonarrSeriesEditState>().useSeasonFolders = value,
        ),
    );
}
