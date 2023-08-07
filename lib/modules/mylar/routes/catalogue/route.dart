import 'package:collection/collection.dart' show IterableExtension;
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/mylar.dart';
import 'package:lunasea/router/routes/mylar.dart';
import 'package:lunasea/types/list_view_option.dart';

class MylarCatalogueRoute extends StatefulWidget {
  const MylarCatalogueRoute({
    Key? key,
  }) : super(key: key);

  @override
  State<MylarCatalogueRoute> createState() => _State();
}

class _State extends State<MylarCatalogueRoute>
    with AutomaticKeepAliveClientMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  bool get wantKeepAlive => true;

  Future<void> _refresh() async {
    MylarState _state = context.read<MylarState>();
    _state.fetchAllSeries();
    _state.fetchQualityProfiles();
    _state.fetchLanguageProfiles();
    _state.fetchTags();

    await Future.wait([
      _state.series!,
      _state.qualityProfiles!,
      _state.tags!,
      _state.languageProfiles!,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return LunaScaffold(
      scaffoldKey: _scaffoldKey,
      module: LunaModule.SONARR,
      body: _body(),
      appBar: _appBar(),
    );
  }

  PreferredSizeWidget _appBar() {
    return LunaAppBar.empty(
      child: MylarSeriesSearchBar(
        scrollController: MylarNavigationBar.scrollControllers[0],
      ),
      height: LunaTextInputBar.defaultAppBarHeight,
    );
  }

  Widget _body() {
    return LunaRefreshIndicator(
      context: context,
      key: _refreshKey,
      onRefresh: _refresh,
      child: Selector<
          MylarState,
          Tuple2<Future<Map<int?, MylarSeries>>?,
              Future<List<MylarQualityProfile>>?>>(
        selector: (_, state) => Tuple2(
          state.series,
          state.qualityProfiles,
        ),
        builder: (context, tuple, _) => FutureBuilder(
          future: Future.wait([
            tuple.item1!,
            tuple.item2!,
          ]),
          builder: (context, AsyncSnapshot<List<Object>> snapshot) {
            if (snapshot.hasError) {
              if (snapshot.connectionState != ConnectionState.waiting) {
                LunaLogger().error(
                  'Unable to fetch Mylar series',
                  snapshot.error,
                  snapshot.stackTrace,
                );
              }
              return LunaMessage.error(
                onTap: _refreshKey.currentState!.show,
              );
            }
            if (snapshot.hasData) {
              return _series(
                snapshot.data![0] as Map<int, MylarSeries>,
                snapshot.data![1] as List<MylarQualityProfile>,
              );
            }
            return const LunaLoader();
          },
        ),
      ),
    );
  }

  List<MylarSeries> _filterAndSort(
    Map<int, MylarSeries> series,
    List<MylarQualityProfile> profiles,
    String query,
  ) {
    if (series.isEmpty) return [];
    MylarSeriesSorting sorting = context.watch<MylarState>().seriesSortType;
    MylarSeriesFilter filter = context.watch<MylarState>().seriesFilterType;
    bool ascending = context.watch<MylarState>().seriesSortAscending;
    // Filter
    List<MylarSeries> filtered = series.values.where((show) {
      if (query.isNotEmpty && show.id != null)
        return show.title!.toLowerCase().contains(query.toLowerCase());
      return show.id != null;
    }).toList();
    filtered = filter.filter(filtered);
    // Sort
    filtered = sorting.sort(filtered, ascending);
    return filtered;
  }

  Widget _series(
    Map<int, MylarSeries> series,
    List<MylarQualityProfile> qualities,
  ) {
    if (series.isEmpty)
      return LunaMessage(
        text: 'mylar.NoSeriesFound'.tr(),
        buttonText: 'lunasea.Refresh'.tr(),
        onTap: _refreshKey.currentState!.show,
      );
    return Selector<MylarState, String>(
      selector: (_, state) => state.seriesSearchQuery,
      builder: (context, query, _) {
        List<MylarSeries> _filtered = _filterAndSort(series, qualities, query);
        if (_filtered.isEmpty)
          return LunaListView(
            controller: MylarNavigationBar.scrollControllers[0],
            children: [
              LunaMessage.inList(text: 'mylar.NoSeriesFound'.tr()),
              if (query.isNotEmpty)
                LunaButtonContainer(
                  children: [
                    LunaButton.text(
                      icon: null,
                      text: query.length > 20
                          ? 'mylar.SearchFor'.tr(args: [
                              '"${query.substring(0, min(20, query.length))}${LunaUI.TEXT_ELLIPSIS}"'
                            ])
                          : 'mylar.SearchFor'.tr(args: ['"$query"']),
                      backgroundColor: LunaColours.accent,
                      onTap: () async {
                        MylarRoutes.ADD_SERIES.go(queryParams: {
                          'query': query,
                        });
                      },
                    ),
                  ],
                ),
            ],
          );
        switch (context.read<MylarState>().seriesViewType) {
          case LunaListViewOption.BLOCK_VIEW:
            return _blockView(_filtered, qualities);
          case LunaListViewOption.GRID_VIEW:
            return _gridView(_filtered, qualities);
          default:
            throw Exception('Invalid moviesViewType');
        }
      },
    );
  }

  Widget _blockView(
    List<MylarSeries> series,
    List<MylarQualityProfile> qualities,
  ) {
    return LunaListViewBuilder(
      controller: MylarNavigationBar.scrollControllers[0],
      itemCount: series.length,
      itemExtent: MylarSeriesTile.itemExtent,
      itemBuilder: (context, index) => MylarSeriesTile(
        series: series[index],
        profile: qualities.firstWhereOrNull(
          (element) => element.id == series[index].qualityProfileId,
        ),
      ),
    );
  }

  Widget _gridView(
    List<MylarSeries> series,
    List<MylarQualityProfile> qualities,
  ) {
    return LunaGridViewBuilder(
      controller: MylarNavigationBar.scrollControllers[0],
      sliverGridDelegate: LunaGridBlock.getMaxCrossAxisExtent(),
      itemCount: series.length,
      itemBuilder: (context, index) => MylarSeriesTile.grid(
        series: series[index],
        profile: qualities.firstWhereOrNull(
          (element) => element.id == series[index].qualityProfileId,
        ),
      ),
    );
  }
}
