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
    return SonarrDatabaseValue.DEFAULT_SORTING_SERIES.listen(
      builder: (context, box, _) => LunaListTile(
        context: context,
        title: LunaText.title(text: 'Series Sort Category'),
        subtitle: LunaText.subtitle(
            text: (SonarrDatabaseValue.DEFAULT_SORTING_SERIES.data
                    as SonarrSeriesSorting)
                .readable),
        trailing: LunaIconButton(icon: Icons.arrow_forward_ios_rounded),
        onTap: () async {
          List<String> titles = SonarrSeriesSorting.values
              .map<String>((e) => e.readable)
              .toList();
          Tuple2<bool, int> values = await SonarrDialogs()
              .setDefaultSortingOrFiltering(context, titles: titles);
          if (values.item1) {
            SonarrDatabaseValue.DEFAULT_SORTING_SERIES
                .put(SonarrSeriesSorting.values[values.item2]);
            context.read<SonarrState>().seriesSortType =
                SonarrDatabaseValue.DEFAULT_SORTING_SERIES.data;
            context.read<SonarrState>().seriesSortAscending =
                SonarrDatabaseValue.DEFAULT_SORTING_SERIES_ASCENDING.data;
          }
        },
      ),
    );
  }

  Widget _filteringSeries() {
    return SonarrDatabaseValue.DEFAULT_FILTERING_SERIES.listen(
      builder: (context, box, _) => LunaListTile(
        context: context,
        title: LunaText.title(text: 'Series Filter Category'),
        subtitle: LunaText.subtitle(
            text: (SonarrDatabaseValue.DEFAULT_FILTERING_SERIES.data
                    as SonarrSeriesFilter)
                .readable),
        trailing: LunaIconButton(icon: Icons.arrow_forward_ios_rounded),
        onTap: () async {
          List<String> titles =
              SonarrSeriesFilter.values.map<String>((e) => e.readable).toList();
          Tuple2<bool, int> values = await SonarrDialogs()
              .setDefaultSortingOrFiltering(context, titles: titles);
          if (values.item1) {
            SonarrDatabaseValue.DEFAULT_FILTERING_SERIES
                .put(SonarrSeriesFilter.values[values.item2]);
          }
        },
      ),
    );
  }

  Widget _filteringReleases() {
    return SonarrDatabaseValue.DEFAULT_FILTERING_RELEASES.listen(
      builder: (context, box, _) => LunaListTile(
        context: context,
        title: LunaText.title(text: 'Releases Filter Category'),
        subtitle: LunaText.subtitle(
            text: (SonarrDatabaseValue.DEFAULT_FILTERING_RELEASES.data
                    as SonarrReleasesFilter)
                .readable),
        trailing: LunaIconButton(icon: Icons.arrow_forward_ios_rounded),
        onTap: () async {
          List<String> titles = SonarrReleasesFilter.values
              .map<String>((e) => e.readable)
              .toList();
          Tuple2<bool, int> values = await SonarrDialogs()
              .setDefaultSortingOrFiltering(context, titles: titles);
          if (values.item1) {
            SonarrDatabaseValue.DEFAULT_FILTERING_RELEASES
                .put(SonarrReleasesFilter.values[values.item2]);
            context.read<SonarrState>().seriesFilterType =
                SonarrDatabaseValue.DEFAULT_FILTERING_RELEASES.data;
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
        subtitle: LunaText.subtitle(
            text: SonarrDatabaseValue.DEFAULT_SORTING_SERIES_ASCENDING.data
                ? 'Ascending'
                : 'Descending'),
        trailing: LunaSwitch(
          value: SonarrDatabaseValue.DEFAULT_SORTING_SERIES_ASCENDING.data,
          onChanged: (value) {
            SonarrDatabaseValue.DEFAULT_SORTING_SERIES_ASCENDING.put(value);
            context.read<SonarrState>().seriesSortType =
                SonarrDatabaseValue.DEFAULT_SORTING_SERIES.data;
            context.read<SonarrState>().seriesSortAscending =
                SonarrDatabaseValue.DEFAULT_SORTING_SERIES_ASCENDING.data;
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
        subtitle: LunaText.subtitle(
            text: (SonarrDatabaseValue.DEFAULT_SORTING_RELEASES.data
                    as SonarrReleasesSorting)
                .readable),
        trailing: LunaIconButton(icon: Icons.arrow_forward_ios_rounded),
        onTap: () async {
          List<String> titles = SonarrReleasesSorting.values
              .map<String>((e) => e.readable)
              .toList();
          Tuple2<bool, int> values =
              await SonarrDialogs().setDefaultSortingOrFiltering(
            context,
            titles: titles,
          );
          if (values.item1) {
            SonarrDatabaseValue.DEFAULT_SORTING_RELEASES
                .put(SonarrReleasesSorting.values[values.item2]);
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
        subtitle: LunaText.subtitle(
            text: SonarrDatabaseValue.DEFAULT_SORTING_RELEASES_ASCENDING.data
                ? 'Ascending'
                : 'Descending'),
        trailing: LunaSwitch(
          value: SonarrDatabaseValue.DEFAULT_SORTING_RELEASES_ASCENDING.data,
          onChanged: (value) =>
              SonarrDatabaseValue.DEFAULT_SORTING_RELEASES_ASCENDING.put(value),
        ),
      ),
    );
  }
}
