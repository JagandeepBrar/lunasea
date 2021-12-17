import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';
import 'package:lunasea/modules/sonarr.dart';

class SettingsConfigurationSonarrDefaultSortingRouter
    extends SettingsPageRouter {
  SettingsConfigurationSonarrDefaultSortingRouter()
      : super('/settings/configuration/sonarr/sorting');

  @override
  _Widget widget() => _Widget();

  @override
  void defineRoute(FluroRouter router) =>
      super.noParameterRouteDefinition(router);
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
        _sortingSeries(),
        _sortingSeriesDirection(),
        _filteringSeries(),
        const LunaDivider(),
        _sortingReleases(),
        _sortingReleasesDirection(),
        _filteringReleases(),
      ],
    );
  }

  Widget _sortingSeries() {
    SonarrDatabaseValue _db = SonarrDatabaseValue.DEFAULT_SORTING_SERIES;
    return _db.listen(
      builder: (context, box, _) => LunaBlock(
        title: 'Series Sort Category',
        body: [TextSpan(text: (_db.data as SonarrSeriesSorting).readable)],
        trailing: const LunaIconButton.arrow(),
        onTap: () async {
          List<String> titles = SonarrSeriesSorting.values
              .map<String>((sorting) => sorting.readable)
              .toList();
          Tuple2<bool, int> values = await SonarrDialogs()
              .setDefaultSortingOrFiltering(context, titles: titles);
          if (values.item1) {
            _db.put(SonarrSeriesSorting.values[values.item2]);
            context.read<SonarrState>().seriesSortType = _db.data;
            context.read<SonarrState>().seriesSortAscending =
                SonarrDatabaseValue.DEFAULT_SORTING_SERIES_ASCENDING.data;
          }
        },
      ),
    );
  }

  Widget _sortingSeriesDirection() {
    SonarrDatabaseValue _db =
        SonarrDatabaseValue.DEFAULT_SORTING_SERIES_ASCENDING;
    return _db.listen(
      builder: (context, box, _) => LunaBlock(
        title: 'Series Sort Direction',
        body: [TextSpan(text: _db.data ? 'Ascending' : 'Descending')],
        trailing: LunaSwitch(
          value: _db.data,
          onChanged: (value) {
            _db.put(value);
            context.read<SonarrState>().seriesSortType =
                SonarrDatabaseValue.DEFAULT_SORTING_SERIES.data;
            context.read<SonarrState>().seriesSortAscending = _db.data;
          },
        ),
      ),
    );
  }

  Widget _filteringSeries() {
    SonarrDatabaseValue _db = SonarrDatabaseValue.DEFAULT_FILTERING_SERIES;
    return _db.listen(
      builder: (context, box, _) => LunaBlock(
        title: 'Series Filter Category',
        body: [TextSpan(text: (_db.data as SonarrSeriesFilter).readable)],
        trailing: const LunaIconButton.arrow(),
        onTap: () async {
          List<String> titles = SonarrSeriesFilter.values
              .map<String>((filter) => filter.readable)
              .toList();
          Tuple2<bool, int> values = await SonarrDialogs()
              .setDefaultSortingOrFiltering(context, titles: titles);
          if (values.item1) {
            _db.put(SonarrSeriesFilter.values[values.item2]);
          }
        },
      ),
    );
  }

  Widget _sortingReleases() {
    SonarrDatabaseValue _db = SonarrDatabaseValue.DEFAULT_SORTING_RELEASES;
    return _db.listen(
      builder: (context, box, _) => LunaBlock(
        title: 'Releases Sort Category',
        body: [TextSpan(text: (_db.data as SonarrReleasesSorting).readable)],
        trailing: const LunaIconButton.arrow(),
        onTap: () async {
          List<String> titles = SonarrReleasesSorting.values
              .map<String>((sorting) => sorting.readable)
              .toList();
          Tuple2<bool, int> values = await SonarrDialogs()
              .setDefaultSortingOrFiltering(context, titles: titles);
          if (values.item1) {
            _db.put(SonarrReleasesSorting.values[values.item2]);
          }
        },
      ),
    );
  }

  Widget _sortingReleasesDirection() {
    SonarrDatabaseValue _db =
        SonarrDatabaseValue.DEFAULT_SORTING_RELEASES_ASCENDING;
    return _db.listen(
      builder: (context, box, _) => LunaBlock(
        title: 'Releases Sort Direction',
        body: [TextSpan(text: _db.data ? 'Ascending' : 'Descending')],
        trailing: LunaSwitch(
          value: _db.data,
          onChanged: (value) => _db.put(value),
        ),
      ),
    );
  }

  Widget _filteringReleases() {
    SonarrDatabaseValue _db = SonarrDatabaseValue.DEFAULT_FILTERING_RELEASES;
    return _db.listen(
      builder: (context, box, _) => LunaBlock(
        title: 'Releases Filter Category',
        body: [TextSpan(text: (_db.data as SonarrReleasesFilter).readable)],
        trailing: const LunaIconButton.arrow(),
        onTap: () async {
          List<String> titles = SonarrReleasesFilter.values
              .map<String>((filter) => filter.readable)
              .toList();
          Tuple2<bool, int> values = await SonarrDialogs()
              .setDefaultSortingOrFiltering(context, titles: titles);
          if (values.item1) {
            _db.put(SonarrReleasesFilter.values[values.item2]);
            context.read<SonarrState>().seriesFilterType = _db.data;
          }
        },
      ),
    );
  }
}
