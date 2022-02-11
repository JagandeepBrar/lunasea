import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';
import 'package:lunasea/modules/readarr.dart';

class SettingsConfigurationReadarrDefaultOptionsRouter
    extends SettingsPageRouter {
  SettingsConfigurationReadarrDefaultOptionsRouter()
      : super('/settings/configuration/readarr/options');

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
        LunaHeader(text: 'readarr.Authors'.tr()),
        _filteringSeries(),
        _sortingSeries(),
        _sortingSeriesDirection(),
        _viewSeries(),
        LunaHeader(text: 'readarr.Releases'.tr()),
        _filteringReleases(),
        _sortingReleases(),
        _sortingReleasesDirection(),
      ],
    );
  }

  Widget _viewSeries() {
    ReadarrDatabaseValue _db = ReadarrDatabaseValue.DEFAULT_VIEW_SERIES;
    return _db.listen(
      builder: (context, box, _) {
        LunaListViewOption _view = _db.data;
        return LunaBlock(
          title: 'lunasea.View'.tr(),
          body: [TextSpan(text: _view.readable)],
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
              context.read<ReadarrState>().seriesViewType = _opt;
              _db.put(_opt);
            }
          },
        );
      },
    );
  }

  Widget _sortingSeries() {
    ReadarrDatabaseValue _db = ReadarrDatabaseValue.DEFAULT_SORTING_SERIES;
    return _db.listen(
      builder: (context, box, _) => LunaBlock(
        title: 'settings.SortCategory'.tr(),
        body: [TextSpan(text: (_db.data as ReadarrAuthorSorting).readable)],
        trailing: const LunaIconButton.arrow(),
        onTap: () async {
          List<String?> titles = ReadarrAuthorSorting.values
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
            _db.put(ReadarrAuthorSorting.values[values.item2]);
            context.read<ReadarrState>().seriesSortType = _db.data;
            context.read<ReadarrState>().seriesSortAscending =
                ReadarrDatabaseValue.DEFAULT_SORTING_SERIES_ASCENDING.data;
          }
        },
      ),
    );
  }

  Widget _sortingSeriesDirection() {
    ReadarrDatabaseValue _db =
        ReadarrDatabaseValue.DEFAULT_SORTING_SERIES_ASCENDING;
    return _db.listen(
      builder: (context, box, _) => LunaBlock(
        title: 'settings.SortDirection'.tr(),
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

  Widget _filteringSeries() {
    ReadarrDatabaseValue _db = ReadarrDatabaseValue.DEFAULT_FILTERING_SERIES;
    return _db.listen(
      builder: (context, box, _) => LunaBlock(
        title: 'settings.FilterCategory'.tr(),
        body: [TextSpan(text: (_db.data as ReadarrAuthorFilter).readable)],
        trailing: const LunaIconButton.arrow(),
        onTap: () async {
          List<String> titles = ReadarrAuthorFilter.values
              .map<String>((sorting) => sorting.readable)
              .toList();
          List<IconData> icons = List.filled(titles.length, LunaIcons.FILTER);

          Tuple2<bool, int> values = await SettingsDialogs().setDefaultOption(
            context,
            title: 'settings.FilterCategory'.tr(),
            values: titles,
            icons: icons,
          );

          if (values.item1) {
            _db.put(ReadarrAuthorFilter.values[values.item2]);
          }
        },
      ),
    );
  }

  Widget _sortingReleases() {
    ReadarrDatabaseValue _db = ReadarrDatabaseValue.DEFAULT_SORTING_RELEASES;
    return _db.listen(
      builder: (context, box, _) => LunaBlock(
        title: 'settings.SortCategory'.tr(),
        body: [TextSpan(text: (_db.data as ReadarrReleasesSorting).readable)],
        trailing: const LunaIconButton.arrow(),
        onTap: () async {
          List<String?> titles = ReadarrReleasesSorting.values
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
            _db.put(ReadarrReleasesSorting.values[values.item2]);
          }
        },
      ),
    );
  }

  Widget _sortingReleasesDirection() {
    ReadarrDatabaseValue _db =
        ReadarrDatabaseValue.DEFAULT_SORTING_RELEASES_ASCENDING;
    return _db.listen(
      builder: (context, box, _) => LunaBlock(
        title: 'settings.SortDirection'.tr(),
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
    ReadarrDatabaseValue _db = ReadarrDatabaseValue.DEFAULT_FILTERING_RELEASES;
    return _db.listen(
      builder: (context, box, _) => LunaBlock(
        title: 'settings.FilterCategory'.tr(),
        body: [TextSpan(text: (_db.data as ReadarrReleasesFilter).readable)],
        trailing: const LunaIconButton.arrow(),
        onTap: () async {
          List<String> titles = ReadarrReleasesFilter.values
              .map<String>((sorting) => sorting.readable)
              .toList();
          List<IconData> icons = List.filled(titles.length, LunaIcons.FILTER);

          Tuple2<bool, int> values = await SettingsDialogs().setDefaultOption(
            context,
            title: 'settings.FilterCategory'.tr(),
            values: titles,
            icons: icons,
          );

          if (values.item1) {
            _db.put(ReadarrReleasesFilter.values[values.item2]);
          }
        },
      ),
    );
  }
}
