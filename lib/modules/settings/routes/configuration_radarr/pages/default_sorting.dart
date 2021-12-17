import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsConfigurationRadarrDefaultSortingRouter
    extends SettingsPageRouter {
  SettingsConfigurationRadarrDefaultSortingRouter()
      : super('/settings/configuration/radarr/sorting');

  @override
  Widget widget() => _Widget();

  @override
  void defineRoute(FluroRouter router) {
    super.noParameterRouteDefinition(router);
  }
}

class _Widget extends StatefulWidget {
  @override
  State<_Widget> createState() => _State();
}

class _State extends State<_Widget> with LunaScrollControllerMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return LunaScaffold(
      scaffoldKey: _scaffoldKey,
      appBar: _appBar(),
      body: _body(),
    );
  }

  Widget _appBar() {
    return LunaAppBar(
      title: 'Default Sorting & Filtering',
      scrollControllers: [scrollController],
    );
  }

  Widget _body() {
    return LunaListView(
      controller: scrollController,
      children: [
        _sortingMovies(),
        _sortingMoviesDirection(),
        _filteringMovies(),
        const LunaDivider(),
        _sortingReleases(),
        _sortingReleasesDirection(),
        _filteringReleases(),
      ],
    );
  }

  Widget _sortingMovies() {
    RadarrDatabaseValue _db = RadarrDatabaseValue.DEFAULT_SORTING_MOVIES;
    return _db.listen(
      builder: (context, box, _) => LunaBlock(
        title: 'Movies Sort Category',
        body: [TextSpan(text: (_db.data as RadarrMoviesSorting).readable)],
        trailing: const LunaIconButton.arrow(),
        onTap: () async {
          List<String> titles = RadarrMoviesSorting.values
              .map<String>((sorting) => sorting.readable)
              .toList();
          Tuple2<bool, int> values = await RadarrDialogs()
              .setDefaultSortingOrFiltering(context, titles: titles);
          if (values.item1) {
            _db.put(RadarrMoviesSorting.values[values.item2]);
            context.read<RadarrState>().moviesSortType = _db.data;
            context.read<RadarrState>().moviesSortAscending =
                RadarrDatabaseValue.DEFAULT_SORTING_MOVIES_ASCENDING.data;
          }
        },
      ),
    );
  }

  Widget _sortingMoviesDirection() {
    RadarrDatabaseValue _db =
        RadarrDatabaseValue.DEFAULT_SORTING_MOVIES_ASCENDING;
    return _db.listen(
      builder: (context, box, _) => LunaBlock(
        title: 'Movies Sort Direction',
        body: [
          TextSpan(
            text:
                _db.data ? 'lunasea.Ascending'.tr() : 'lunasea.Descending'.tr(),
          ),
        ],
        trailing: LunaSwitch(
          value: _db.data,
          onChanged: (value) {
            _db.put(value);
            context.read<RadarrState>().moviesSortType =
                RadarrDatabaseValue.DEFAULT_SORTING_MOVIES.data;
            context.read<RadarrState>().moviesSortAscending = _db.data;
          },
        ),
      ),
    );
  }

  Widget _filteringMovies() {
    RadarrDatabaseValue _db = RadarrDatabaseValue.DEFAULT_FILTERING_MOVIES;
    return _db.listen(
      builder: (context, box, _) => LunaBlock(
        title: 'Movies Filter Category',
        body: [TextSpan(text: (_db.data as RadarrMoviesFilter).readable)],
        trailing: const LunaIconButton.arrow(),
        onTap: () async {
          List<String> titles = RadarrMoviesFilter.values
              .map<String>((filter) => filter.readable)
              .toList();
          Tuple2<bool, int> values = await RadarrDialogs()
              .setDefaultSortingOrFiltering(context, titles: titles);
          if (values.item1) {
            _db.put(RadarrMoviesFilter.values[values.item2]);
            context.read<RadarrState>().moviesFilterType = _db.data;
          }
        },
      ),
    );
  }

  Widget _sortingReleases() {
    RadarrDatabaseValue _db = RadarrDatabaseValue.DEFAULT_SORTING_RELEASES;
    return _db.listen(
      builder: (context, box, _) => LunaBlock(
        title: 'Releases Sort Category',
        body: [TextSpan(text: (_db.data as RadarrReleasesSorting).readable)],
        trailing: const LunaIconButton.arrow(),
        onTap: () async {
          List<String> titles = RadarrReleasesSorting.values
              .map<String>((sorting) => sorting.readable)
              .toList();
          Tuple2<bool, int> values = await RadarrDialogs()
              .setDefaultSortingOrFiltering(context, titles: titles);
          if (values.item1) _db.put(RadarrReleasesSorting.values[values.item2]);
        },
      ),
    );
  }

  Widget _sortingReleasesDirection() {
    RadarrDatabaseValue _db =
        RadarrDatabaseValue.DEFAULT_SORTING_RELEASES_ASCENDING;
    return _db.listen(
      builder: (context, box, _) => LunaBlock(
        title: 'Releases Sort Direction',
        body: [
          TextSpan(
            text:
                _db.data ? 'lunasea.Ascending'.tr() : 'lunasea.Descending'.tr(),
          ),
        ],
        trailing: LunaSwitch(
          value: _db.data,
          onChanged: (value) => _db.put(value),
        ),
      ),
    );
  }

  Widget _filteringReleases() {
    RadarrDatabaseValue _db = RadarrDatabaseValue.DEFAULT_FILTERING_RELEASES;
    return _db.listen(
      builder: (context, box, _) => LunaBlock(
        title: 'Releases Filter Category',
        body: [TextSpan(text: (_db.data as RadarrReleasesFilter).readable)],
        trailing: const LunaIconButton.arrow(),
        onTap: () async {
          List<String> titles = RadarrReleasesFilter.values
              .map<String>((filter) => filter.readable)
              .toList();
          Tuple2<bool, int> values = await RadarrDialogs()
              .setDefaultSortingOrFiltering(context, titles: titles);
          if (values.item1) _db.put(RadarrReleasesFilter.values[values.item2]);
        },
      ),
    );
  }
}
