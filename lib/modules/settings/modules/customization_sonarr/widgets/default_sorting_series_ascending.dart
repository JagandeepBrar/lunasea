import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SettingsCustomizationSonarrDefaultSortingSeriesAscendingTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => ValueListenableBuilder(
        valueListenable: Database.lunaSeaBox.listenable(keys: [SonarrDatabaseValue.DEFAULT_SORTING_SERIES_ASCENDING.key]),
        builder: (context, box, _) => LSCardTile(
            title: LSTitle(text: 'Series Sort Direction'),
            subtitle: LSSubtitle(text: SonarrDatabaseValue.DEFAULT_SORTING_SERIES_ASCENDING.data
                ? 'Ascending'
                : 'Descending'
            ),
            trailing: Switch(
                value: SonarrDatabaseValue.DEFAULT_SORTING_SERIES_ASCENDING.data,
                onChanged: (value) {
                    SonarrDatabaseValue.DEFAULT_SORTING_SERIES_ASCENDING.put(value);
                    // Reset the state of the sorting
                    context.read<SonarrState>().seriesSortType = SonarrDatabaseValue.DEFAULT_SORTING_SERIES.data;
                    context.read<SonarrState>().seriesSortAscending = SonarrDatabaseValue.DEFAULT_SORTING_SERIES_ASCENDING.data;
                },
            ),
        ),
    );
}
