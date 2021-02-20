import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class SettingsConfigurationRadarrDefaultSortingRouter extends LunaPageRouter {
    SettingsConfigurationRadarrDefaultSortingRouter() : super('/settings/configuration/radarr/sorting');

    @override
    void defineRoute(FluroRouter router) => super.noParameterRouteDefinition(router, _SettingsConfigurationRadarrRoute());
}

class _SettingsConfigurationRadarrRoute extends StatefulWidget {
    @override
    State<_SettingsConfigurationRadarrRoute> createState() => _State();
}

class _State extends State<_SettingsConfigurationRadarrRoute> with LunaScrollControllerMixin {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            key: _scaffoldKey,
            appBar: _appBar(),
            body: _body(),
        );
    }

    Widget _appBar() => LunaAppBar(title: 'Default Sorting & Filtering', scrollControllers: [scrollController]);

    Widget _body() {
        return LunaListView(
            controller: scrollController,
            children: [
                _sortingMovies(),
                _sortingMoviesDirection(),
                _filteringMovies(),
                LunaDivider(),
                _sortingReleases(),
                _sortingReleasesDirection(),
                _filteringReleases(),
            ],
        );
    }

    Widget _sortingMovies() {
        return RadarrDatabaseValue.DEFAULT_SORTING_MOVIES.listen(
            builder: (context, box, _) => LunaListTile(
                context: context,
                title: LunaText.title(text: 'Movies Sort Category'),
                subtitle: LunaText.subtitle(text: (RadarrDatabaseValue.DEFAULT_SORTING_MOVIES.data as RadarrMoviesSorting).readable),
                trailing: LunaIconButton(icon: Icons.arrow_forward_ios),
                onTap: () async {
                    List<String> titles = RadarrMoviesSorting.values.map<String>((e) => e.readable).toList();
                    Tuple2<bool, int> values = await RadarrDialogs().setDefaultSortingOrFiltering(context, titles: titles);
                    if(values.item1) {
                        RadarrDatabaseValue.DEFAULT_SORTING_MOVIES.put(RadarrMoviesSorting.values[values.item2]);
                        context.read<RadarrState>().moviesSortType = RadarrDatabaseValue.DEFAULT_SORTING_MOVIES.data;
                        context.read<RadarrState>().moviesSortAscending = RadarrDatabaseValue.DEFAULT_SORTING_MOVIES_ASCENDING.data;
                    }
                },
            ),
        );
    }

    Widget _sortingMoviesDirection() {
        return RadarrDatabaseValue.DEFAULT_SORTING_MOVIES_ASCENDING.listen(
            builder: (context, box, _) => LunaListTile(
                context: context,
                title: LunaText.title(text: 'Movies Sort Direction'),
                subtitle: LunaText.subtitle(text: RadarrDatabaseValue.DEFAULT_SORTING_MOVIES_ASCENDING.data ? 'Ascending' : 'Descending'),
                trailing: LunaSwitch(
                    value: RadarrDatabaseValue.DEFAULT_SORTING_MOVIES_ASCENDING.data,
                    onChanged: (value) {
                        RadarrDatabaseValue.DEFAULT_SORTING_MOVIES_ASCENDING.put(value);
                        context.read<RadarrState>().moviesSortType = RadarrDatabaseValue.DEFAULT_SORTING_MOVIES.data;
                        context.read<RadarrState>().moviesSortAscending = RadarrDatabaseValue.DEFAULT_SORTING_MOVIES_ASCENDING.data;
                    },
                ),
            ),
        );
    }

    Widget _filteringMovies() {
        return RadarrDatabaseValue.DEFAULT_FILTERING_MOVIES.listen(
            builder: (context, box, _) => LunaListTile(
                context: context,
                title: LunaText.title(text: 'Movies Filter Category'),
                subtitle: LunaText.subtitle(text: (RadarrDatabaseValue.DEFAULT_FILTERING_MOVIES.data as RadarrMoviesFilter).readable),
                trailing: LunaIconButton(icon: Icons.arrow_forward_ios),
                onTap: () async {
                    List<String> titles = RadarrMoviesFilter.values.map<String>((e) => e.readable).toList();
                    Tuple2<bool, int> values = await RadarrDialogs().setDefaultSortingOrFiltering(context, titles: titles);
                    if(values.item1) {
                        RadarrDatabaseValue.DEFAULT_FILTERING_MOVIES.put(RadarrMoviesFilter.values[values.item2]);
                        context.read<RadarrState>().moviesFilterType = RadarrDatabaseValue.DEFAULT_FILTERING_MOVIES.data;
                    }
                },
            ),
        );
    }

    Widget _sortingReleases() {
        return RadarrDatabaseValue.DEFAULT_SORTING_RELEASES.listen(
            builder: (context, box, _) => LunaListTile(
                context: context,
                title: LunaText.title(text: 'Releases Sort Category'),
                subtitle: LunaText.subtitle(text: (RadarrDatabaseValue.DEFAULT_SORTING_RELEASES.data as RadarrReleasesSorting).readable),
                trailing: LunaIconButton(icon: Icons.arrow_forward_ios),
                onTap: () async {
                    List<String> titles = RadarrReleasesSorting.values.map<String>((e) => e.readable).toList();
                    Tuple2<bool, int> values = await RadarrDialogs().setDefaultSortingOrFiltering(context, titles: titles);
                    if(values.item1) {
                        RadarrDatabaseValue.DEFAULT_SORTING_RELEASES.put(RadarrReleasesSorting.values[values.item2]);
                        context.read<RadarrState>().moviesSortType = RadarrDatabaseValue.DEFAULT_SORTING_RELEASES.data;
                        context.read<RadarrState>().moviesSortAscending = RadarrDatabaseValue.DEFAULT_SORTING_RELEASES_ASCENDING.data;
                    }
                },
            ),
        );
    }

    Widget _sortingReleasesDirection() {
        return RadarrDatabaseValue.DEFAULT_SORTING_RELEASES_ASCENDING.listen(
            builder: (context, box, _) => LunaListTile(
                context: context,
                title: LunaText.title(text: 'Releases Sort Direction'),
                subtitle: LunaText.subtitle(text: RadarrDatabaseValue.DEFAULT_SORTING_RELEASES_ASCENDING.data ? 'Ascending' : 'Descending'),
                trailing: LunaSwitch(
                    value: RadarrDatabaseValue.DEFAULT_SORTING_RELEASES_ASCENDING.data,
                    onChanged: (value) => RadarrDatabaseValue.DEFAULT_SORTING_RELEASES_ASCENDING.put(value),
                ),
            ),
        );
    }

    Widget _filteringReleases() {
        return RadarrDatabaseValue.DEFAULT_FILTERING_RELEASES.listen(
            builder: (context, box, _) => LunaListTile(
                context: context,
                title: LunaText.title(text: 'Releases Filter Category'),
                subtitle: LunaText.subtitle(text: (RadarrDatabaseValue.DEFAULT_FILTERING_RELEASES.data as RadarrReleasesFilter).readable),
                trailing: LunaIconButton(icon: Icons.arrow_forward_ios),
                onTap: () async {
                    List<String> titles = RadarrReleasesFilter.values.map<String>((e) => e.readable).toList();
                    Tuple2<bool, int> values = await RadarrDialogs().setDefaultSortingOrFiltering(context, titles: titles);
                    if(values.item1) RadarrDatabaseValue.DEFAULT_FILTERING_RELEASES.put(RadarrReleasesFilter.values[values.item2]);
                },
            ),
        );
    }
}
