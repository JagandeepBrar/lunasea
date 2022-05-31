import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsConfigurationRadarrDefaultOptionsRouter
    extends SettingsPageRouter {
  SettingsConfigurationRadarrDefaultOptionsRouter()
      : super('/settings/configuration/radarr/options');

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
      appBar: _appBar() as PreferredSizeWidget?,
      body: _body(),
    );
  }

  Widget _appBar() {
    return LunaAppBar(
      title: 'settings.DefaultOptions'.tr(),
      scrollControllers: [scrollController],
    );
  }

  Widget _body() {
    return LunaListView(
      controller: scrollController,
      children: [
        LunaHeader(text: 'radarr.Movies'.tr()),
        _filteringMovies(),
        _sortingMovies(),
        _sortingMoviesDirection(),
        _viewMovies(),
        LunaHeader(text: 'radarr.Releases'.tr()),
        _filteringReleases(),
        _sortingReleases(),
        _sortingReleasesDirection(),
      ],
    );
  }

  Widget _viewMovies() {
    const _db = RadarrDatabase.DEFAULT_VIEW_MOVIES;
    return _db.listen(
      builder: (context, _) {
        return LunaBlock(
          title: 'lunasea.View'.tr(),
          body: [TextSpan(text: _db.read().readable)],
          trailing: const LunaIconButton.arrow(),
          onTap: () async {
            List<String> titles = LunaListViewOption.values
                .map<String>((view) => view.readable)
                .toList();
            List<IconData> icons = LunaListViewOption.values
                .map<IconData>((view) => view.icon)
                .toList();

            Tuple2<bool, int> values = await SettingsDialogs().setDefaultOption(
              context,
              title: 'lunasea.View'.tr(),
              values: titles,
              icons: icons,
            );

            if (values.item1) {
              LunaListViewOption _opt = LunaListViewOption.values[values.item2];
              context.read<RadarrState>().moviesViewType = _opt;
              _db.update(_opt);
            }
          },
        );
      },
    );
  }

  Widget _sortingMovies() {
    const _db = RadarrDatabase.DEFAULT_SORTING_MOVIES;
    return _db.listen(
      builder: (context, _) => LunaBlock(
        title: 'settings.SortCategory'.tr(),
        body: [TextSpan(text: _db.read().readable)],
        trailing: const LunaIconButton.arrow(),
        onTap: () async {
          List<String> titles = RadarrMoviesSorting.values
              .map<String>((sorting) => sorting.readable)
              .toList();
          List<IconData> icons = List.filled(titles.length, LunaIcons.SORT);

          Tuple2<bool, int> values = await SettingsDialogs().setDefaultOption(
            context,
            title: 'settings.SortCategory'.tr(),
            values: titles,
            icons: icons,
          );

          if (values.item1) {
            _db.update(RadarrMoviesSorting.values[values.item2]);
            context.read<RadarrState>().moviesSortType = _db.read();
            context.read<RadarrState>().moviesSortAscending =
                RadarrDatabase.DEFAULT_SORTING_MOVIES_ASCENDING.read();
          }
        },
      ),
    );
  }

  Widget _sortingMoviesDirection() {
    const _db = RadarrDatabase.DEFAULT_SORTING_MOVIES_ASCENDING;
    return _db.listen(
      builder: (context, _) => LunaBlock(
        title: 'settings.SortDirection'.tr(),
        body: [
          TextSpan(
            text: _db.read()
                ? 'lunasea.Ascending'.tr()
                : 'lunasea.Descending'.tr(),
          ),
        ],
        trailing: LunaSwitch(
          value: _db.read(),
          onChanged: (value) {
            _db.update(value);
            context.read<RadarrState>().moviesSortType =
                RadarrDatabase.DEFAULT_SORTING_MOVIES.read();
            context.read<RadarrState>().moviesSortAscending = _db.read();
          },
        ),
      ),
    );
  }

  Widget _filteringMovies() {
    const _db = RadarrDatabase.DEFAULT_FILTERING_MOVIES;
    return _db.listen(
      builder: (context, _) => LunaBlock(
        title: 'settings.FilterCategory'.tr(),
        body: [TextSpan(text: _db.read().readable)],
        trailing: const LunaIconButton.arrow(),
        onTap: () async {
          List<String?> titles = RadarrMoviesFilter.values
              .map<String?>((filter) => filter.readable)
              .toList();
          List<IconData> icons = List.filled(titles.length, LunaIcons.FILTER);

          Tuple2<bool, int> values = await SettingsDialogs().setDefaultOption(
            context,
            title: 'settings.FilterCategory'.tr(),
            values: titles,
            icons: icons,
          );

          if (values.item1) {
            _db.update(RadarrMoviesFilter.values[values.item2]);
            context.read<RadarrState>().moviesFilterType = _db.read();
          }
        },
      ),
    );
  }

  Widget _sortingReleases() {
    const _db = RadarrDatabase.DEFAULT_SORTING_RELEASES;
    return _db.listen(
      builder: (context, _) => LunaBlock(
        title: 'settings.SortCategory'.tr(),
        body: [TextSpan(text: _db.read().readable)],
        trailing: const LunaIconButton.arrow(),
        onTap: () async {
          List<String?> titles = RadarrReleasesSorting.values
              .map<String?>((sorting) => sorting.readable)
              .toList();
          List<IconData> icons = List.filled(titles.length, LunaIcons.SORT);

          Tuple2<bool, int> values = await SettingsDialogs().setDefaultOption(
            context,
            title: 'settings.SortCategory'.tr(),
            values: titles,
            icons: icons,
          );

          if (values.item1) {
            _db.update(RadarrReleasesSorting.values[values.item2]);
          }
        },
      ),
    );
  }

  Widget _sortingReleasesDirection() {
    const _db = RadarrDatabase.DEFAULT_SORTING_RELEASES_ASCENDING;
    return _db.listen(
      builder: (context, _) => LunaBlock(
        title: 'settings.SortDirection'.tr(),
        body: [
          TextSpan(
            text: _db.read()
                ? 'lunasea.Ascending'.tr()
                : 'lunasea.Descending'.tr(),
          ),
        ],
        trailing: LunaSwitch(
          value: _db.read(),
          onChanged: (value) => _db.update(value),
        ),
      ),
    );
  }

  Widget _filteringReleases() {
    const _db = RadarrDatabase.DEFAULT_FILTERING_RELEASES;
    return _db.listen(
      builder: (context, _) => LunaBlock(
        title: 'settings.FilterCategory'.tr(),
        body: [TextSpan(text: _db.read().readable)],
        trailing: const LunaIconButton.arrow(),
        onTap: () async {
          List<String?> titles = RadarrReleasesFilter.values
              .map<String?>((sorting) => sorting.readable)
              .toList();
          List<IconData> icons = List.filled(titles.length, LunaIcons.FILTER);

          Tuple2<bool, int> values = await SettingsDialogs().setDefaultOption(
            context,
            title: 'settings.FilterCategory'.tr(),
            values: titles,
            icons: icons,
          );

          if (values.item1) {
            _db.update(RadarrReleasesFilter.values[values.item2]);
          }
        },
      ),
    );
  }
}
