import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SettingsCustomizationSonarrDefaultSortingReleasesAscendingTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => ValueListenableBuilder(
        valueListenable: Database.lunaSeaBox.listenable(keys: [SonarrDatabaseValue.DEFAULT_SORTING_RELEASES_ASCENDING.key]),
        builder: (context, box, _) => LSCardTile(
            title: LSTitle(text: 'Releases Sort Direction'),
            subtitle: LSSubtitle(text: SonarrDatabaseValue.DEFAULT_SORTING_RELEASES_ASCENDING.data
                ? 'Ascending'
                : 'Descending'
            ),
            trailing: Switch(
                value: SonarrDatabaseValue.DEFAULT_SORTING_RELEASES_ASCENDING.data,
                onChanged: (value) {
                    SonarrDatabaseValue.DEFAULT_SORTING_RELEASES_ASCENDING.put(value);
                    // Reset the state of the sorting
                    context.read<SonarrState>().releasesSortType = SonarrDatabaseValue.DEFAULT_SORTING_RELEASES.data;
                    context.read<SonarrState>().releasesSortAscending = SonarrDatabaseValue.DEFAULT_SORTING_RELEASES_ASCENDING.data;
                },
            ),
        ),
    );
}
