import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SettingsCustomizationSonarrDefaultSortingSeriesTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => ValueListenableBuilder(
        valueListenable: Database.lunaSeaBox.listenable(keys: [SonarrDatabaseValue.DEFAULT_SORTING_SERIES.key]),
        builder: (context, box, _) => LSCardTile(
            title: LSTitle(text: 'Series Category'),
            subtitle: LSSubtitle(text: (SonarrDatabaseValue.DEFAULT_SORTING_SERIES.data as SonarrSeriesSorting).readable),
            trailing: LSIconButton(icon: Icons.arrow_forward_ios),
            onTap: () async => _defaultSorting(context),
        ),
    );

    Future<void> _defaultSorting(BuildContext context) async {
        List<String> _titles = SonarrSeriesSorting.values.map<String>((e) => e.readable).toList();
        List _values = await SonarrDialogs.setDefaultSorting(context, titles: _titles);
        if(_values[0]) {
            SonarrDatabaseValue.DEFAULT_SORTING_SERIES.put(SonarrSeriesSorting.values[_values[1]]);
            // Reset the state of the sorting
            context.read<SonarrState>().seriesSortType = SonarrDatabaseValue.DEFAULT_SORTING_SERIES.data;
            context.read<SonarrState>().seriesSortAscending = SonarrDatabaseValue.DEFAULT_SORTING_SERIES_ASCENDING.data;
        }
    }
}
