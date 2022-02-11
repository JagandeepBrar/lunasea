import 'dart:math';

import 'package:collection/collection.dart' show IterableExtension;
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/readarr.dart';

class ReadarrCatalogueRoute extends StatefulWidget {
  const ReadarrCatalogueRoute({
    Key? key,
  }) : super(key: key);

  @override
  State<ReadarrCatalogueRoute> createState() => _State();
}

class _State extends State<ReadarrCatalogueRoute>
    with AutomaticKeepAliveClientMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  bool get wantKeepAlive => true;

  Future<void> _refresh() async {
    ReadarrState _state = context.read<ReadarrState>();
    _state.fetchAllAuthors();
    _state.fetchQualityProfiles();
    _state.fetchMetadataProfiles();
    _state.fetchTags();

    await Future.wait([
      _state.authors!,
      _state.qualityProfiles!,
      _state.tags!,
      _state.metadataProfiles!,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return LunaScaffold(
      scaffoldKey: _scaffoldKey,
      module: LunaModule.READARR,
      hideDrawer: true,
      body: _body(),
      appBar: _appBar() as PreferredSizeWidget?,
    );
  }

  Widget _appBar() {
    return LunaAppBar.empty(
      child: ReadarrAuthorSearchBar(
        scrollController: ReadarrNavigationBar.scrollControllers[0],
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
          ReadarrState,
          Tuple2<Future<Map<int?, ReadarrAuthor>>?,
              Future<List<ReadarrQualityProfile>>?>>(
        selector: (_, state) => Tuple2(
          state.authors,
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
                  'Unable to fetch Readarr series',
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
                snapshot.data![0] as Map<int, ReadarrAuthor>,
                snapshot.data![1] as List<ReadarrQualityProfile>,
              );
            }
            return const LunaLoader();
          },
        ),
      ),
    );
  }

  List<ReadarrAuthor> _filterAndSort(
    Map<int, ReadarrAuthor> series,
    List<ReadarrQualityProfile> profiles,
    String query,
  ) {
    if (series.isEmpty) return [];
    ReadarrAuthorSorting sorting = context.watch<ReadarrState>().seriesSortType;
    ReadarrAuthorFilter filter = context.watch<ReadarrState>().seriesFilterType;
    bool ascending = context.watch<ReadarrState>().seriesSortAscending;
    // Filter
    List<ReadarrAuthor> filtered = series.values.where((show) {
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
    Map<int, ReadarrAuthor> series,
    List<ReadarrQualityProfile> qualities,
  ) {
    if (series.isEmpty)
      return LunaMessage(
        text: 'readarr.NoSeriesFound'.tr(),
        buttonText: 'lunasea.Refresh'.tr(),
        onTap: _refreshKey.currentState!.show,
      );
    return Selector<ReadarrState, String>(
      selector: (_, state) => state.seriesSearchQuery,
      builder: (context, query, _) {
        List<ReadarrAuthor> _filtered =
            _filterAndSort(series, qualities, query);
        if (_filtered.isEmpty)
          return LunaListView(
            controller: ReadarrNavigationBar.scrollControllers[0],
            children: [
              LunaMessage.inList(text: 'readarr.NoSeriesFound'.tr()),
              if (query.isNotEmpty)
                LunaButtonContainer(
                  children: [
                    LunaButton.text(
                      icon: null,
                      text: query.length > 20
                          ? 'readarr.SearchFor'.tr(args: [
                              '"${query.substring(0, min(20, query.length))}${LunaUI.TEXT_ELLIPSIS}"'
                            ])
                          : 'readarr.SearchFor'.tr(args: ['"$query"']),
                      backgroundColor: LunaColours.accent,
                      onTap: () async => ReadarrAddSeriesRouter().navigateTo(
                        context,
                        query,
                      ),
                    ),
                  ],
                ),
            ],
          );
        switch (context.read<ReadarrState>().seriesViewType) {
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
    List<ReadarrAuthor> series,
    List<ReadarrQualityProfile> qualities,
  ) {
    return LunaListViewBuilder(
      controller: ReadarrNavigationBar.scrollControllers[0],
      itemCount: series.length,
      itemExtent: ReadarrAuthorTile.itemExtent,
      itemBuilder: (context, index) => ReadarrAuthorTile(
        series: series[index],
        profile: qualities.firstWhereOrNull(
          (element) => element.id == series[index].qualityProfileId,
        ),
      ),
    );
  }

  Widget _gridView(
    List<ReadarrAuthor> series,
    List<ReadarrQualityProfile> qualities,
  ) {
    return LunaGridViewBuilder(
      controller: ReadarrNavigationBar.scrollControllers[0],
      sliverGridDelegate: LunaGridBlock.getMaxCrossAxisExtent(),
      itemCount: series.length,
      itemBuilder: (context, index) => ReadarrAuthorTile.grid(
        series: series[index],
        profile: qualities.firstWhereOrNull(
          (element) => element.id == series[index].qualityProfileId,
        ),
      ),
    );
  }
}
