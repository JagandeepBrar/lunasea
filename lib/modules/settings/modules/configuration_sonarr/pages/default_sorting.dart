import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsConfigurationSonarrDefaultSortingRouter extends LunaPageRouter {
    SettingsConfigurationSonarrDefaultSortingRouter() : super('/settings/configuration/sonarr/sorting');

    @override
    void defineRoute(FluroRouter router) => super.noParameterRouteDefinition(router, _SettingsConfigurationSonarrRoute());
}

class _SettingsConfigurationSonarrRoute extends StatefulWidget {
    @override
    State<_SettingsConfigurationSonarrRoute> createState() => _State();
}

class _State extends State<_SettingsConfigurationSonarrRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            key: _scaffoldKey,
            appBar: _appBar(),
            body: _body(),
        );
    }

    Widget _appBar() {
        return LunaAppBar(
            title: 'Default Sorting & Filtering',
            state: context.read<SettingsState>(),
        );
    }

    Widget _body() {
        return LunaListView(
            scrollController: context.read<SettingsState>().scrollController,
            children: [
                _sortingSeries(),
                _sortingSeriesDirection(),
                LunaDivider(),
                _sortingReleases(),
                _sortingReleasesDirection(),
            ],
        );
    }

    Widget _sortingSeries() {
        return SonarrDatabaseValue.DEFAULT_SORTING_SERIES.listen(
            builder: (context, box, _) => LunaListTile(
                context: context,
                title: LunaText.title(text: 'Series Sort Category'),
                subtitle: LunaText.subtitle(text: (SonarrDatabaseValue.DEFAULT_SORTING_SERIES.data as SonarrSeriesSorting).readable),
                trailing: LunaIconButton(icon: Icons.arrow_forward_ios),
                onTap: () async {
                    List<String> titles = SonarrSeriesSorting.values.map<String>((e) => e.readable).toList();
                    List values = await SonarrDialogs.setDefaultSortingOrFiltering(context, titles: titles);
                    if(values[0]) {
                        SonarrDatabaseValue.DEFAULT_SORTING_SERIES.put(SonarrSeriesSorting.values[values[1]]);
                        context.read<SonarrState>().seriesSortType = SonarrDatabaseValue.DEFAULT_SORTING_SERIES.data;
                        context.read<SonarrState>().seriesSortAscending = SonarrDatabaseValue.DEFAULT_SORTING_SERIES_ASCENDING.data;
                    }
                },
            ),
        );
    }

    Widget _sortingSeriesDirection() {
        return SonarrDatabaseValue.DEFAULT_SORTING_SERIES_ASCENDING.listen(
            builder: (context, box, _) => LunaListTile(
                context: context,
                title: LunaText.title(text: 'Series Sort Direction'),
                subtitle: LunaText.subtitle(text: SonarrDatabaseValue.DEFAULT_SORTING_SERIES_ASCENDING.data ? 'Ascending' : 'Descending'),
                trailing: LunaSwitch(
                    value: SonarrDatabaseValue.DEFAULT_SORTING_SERIES_ASCENDING.data,
                    onChanged: (value) {
                        SonarrDatabaseValue.DEFAULT_SORTING_SERIES_ASCENDING.put(value);
                        context.read<SonarrState>().seriesSortType = SonarrDatabaseValue.DEFAULT_SORTING_SERIES.data;
                        context.read<SonarrState>().seriesSortAscending = SonarrDatabaseValue.DEFAULT_SORTING_SERIES_ASCENDING.data;
                    },
                ),
            ),
        );
    }

    Widget _sortingReleases() {
        return SonarrDatabaseValue.DEFAULT_SORTING_RELEASES.listen(
            builder: (context, box, _) => LunaListTile(
                context: context,
                title: LunaText.title(text: 'Releases Sort Category'),
                subtitle: LunaText.subtitle(text: (SonarrDatabaseValue.DEFAULT_SORTING_RELEASES.data as SonarrReleasesSorting).readable),
                trailing: LunaIconButton(icon: Icons.arrow_forward_ios),
                onTap: () async {
                    List<String> titles = SonarrReleasesSorting.values.map<String>((e) => e.readable).toList();
                    List values = await SonarrDialogs.setDefaultSortingOrFiltering(context, titles: titles);
                    if(values[0]) {
                        SonarrDatabaseValue.DEFAULT_SORTING_RELEASES.put(SonarrReleasesSorting.values[values[1]]);
                        context.read<SonarrState>().releasesSortType = SonarrDatabaseValue.DEFAULT_SORTING_RELEASES.data;
                        context.read<SonarrState>().releasesSortAscending = SonarrDatabaseValue.DEFAULT_SORTING_RELEASES_ASCENDING.data;
                    }
                },
            ),
        );
    }

    Widget _sortingReleasesDirection() {
        return SonarrDatabaseValue.DEFAULT_SORTING_RELEASES_ASCENDING.listen(
            builder: (context, box, _) => LunaListTile(
                context: context,
                title: LunaText.title(text: 'Releases Sort Direction'),
                subtitle: LunaText.subtitle(text: SonarrDatabaseValue.DEFAULT_SORTING_RELEASES_ASCENDING.data ? 'Ascending' : 'Descending'),
                trailing: LunaSwitch(
                    value: SonarrDatabaseValue.DEFAULT_SORTING_RELEASES_ASCENDING.data,
                    onChanged: (value) {
                        SonarrDatabaseValue.DEFAULT_SORTING_RELEASES_ASCENDING.put(value);
                        context.read<SonarrState>().releasesSortType = SonarrDatabaseValue.DEFAULT_SORTING_RELEASES.data;
                        context.read<SonarrState>().releasesSortAscending = SonarrDatabaseValue.DEFAULT_SORTING_RELEASES_ASCENDING.data;
                    },
                ),
            ),
        );
    }
}
