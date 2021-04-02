import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrSeriesEditSeasonFoldersTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return LunaListTile(
            context: context,
            title: LunaText.title(text: 'Use Season Folders'),
            subtitle: LunaText.subtitle(text: 'Sort episodes into season folders'),
            trailing: LunaSwitch(
                value: context.watch<SonarrSeriesEditState>().useSeasonFolders,
                onChanged: (value) => context.read<SonarrSeriesEditState>().useSeasonFolders = value,
            ),
        );
    }
}
