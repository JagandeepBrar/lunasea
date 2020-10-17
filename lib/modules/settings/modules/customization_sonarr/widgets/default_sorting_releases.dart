import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SettingsCustomizationSonarrDefaultSortingReleasesTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => ValueListenableBuilder(
        valueListenable: Database.lunaSeaBox.listenable(keys: [SonarrDatabaseValue.DEFAULT_SORTING_RELEASES.key]),
        builder: (context, box, _) => LSCardTile(
            title: LSTitle(text: 'Releases'),
            subtitle: LSSubtitle(text: (SonarrDatabaseValue.DEFAULT_SORTING_RELEASES.data as SonarrReleasesSorting).readable),
            trailing: LSIconButton(icon: Icons.arrow_forward_ios),
            onTap: () async => _defaultSorting(context),
        ),
    );

    Future<void> _defaultSorting(BuildContext context) async {
        List<String> _titles = SonarrReleasesSorting.values.map<String>((e) => e.readable).toList();
        List _values = await SonarrDialogs.setDefaultSorting(context, titles: _titles);
        if(_values[0]) {
            SonarrDatabaseValue.DEFAULT_SORTING_RELEASES.put(SonarrReleasesSorting.values[_values[1]]);
            // Reset the state of the sorting
            context.read<SonarrState>().releasesSortType = SonarrReleasesSorting.values[_values[1]];
            context.read<SonarrState>().releasesSortAscending = true;
        }
    }
}
