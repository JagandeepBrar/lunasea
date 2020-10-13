import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SettingsCustomizationSonarrDefaultPageSeriesDetailsTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => ValueListenableBuilder(
        valueListenable: Database.lunaSeaBox.listenable(keys: [SonarrDatabaseValue.NAVIGATION_INDEX_SERIES_DETAILS.key]),
        builder: (context, box, _) => LSCardTile(
            title: LSTitle(text: 'Series Details'),
            subtitle: LSSubtitle(text: SonarrSeriesDetailsNavigationBar.titles[SonarrDatabaseValue.NAVIGATION_INDEX_SERIES_DETAILS.data]),
            trailing: LSIconButton(icon: SonarrSeriesDetailsNavigationBar.icons[SonarrDatabaseValue.NAVIGATION_INDEX_SERIES_DETAILS.data]),
            onTap: () async => _defaultPage(context),
        ),
    );

    Future<void> _defaultPage(BuildContext context) async {
        List<dynamic> _values = await SonarrDialogs.setDefaultPage(context, titles: SonarrSeriesDetailsNavigationBar.titles, icons: SonarrSeriesDetailsNavigationBar.icons);
        if(_values[0]) SonarrDatabaseValue.NAVIGATION_INDEX_SERIES_DETAILS.put(_values[1]);
    }
}
