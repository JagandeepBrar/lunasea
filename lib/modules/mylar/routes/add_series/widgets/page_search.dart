import 'package:collection/collection.dart' show IterableExtension;
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/Mylar.dart';

class MylarAddSeriesSearchPage extends StatefulWidget {
  final ScrollController scrollController;

  const MylarAddSeriesSearchPage({
    Key? key,
    required this.scrollController,
  }) : super(key: key);

  @override
  State<MylarAddSeriesSearchPage> createState() => _State();
}

class _State extends State<MylarAddSeriesSearchPage>
    with LunaLoadCallbackMixin {
  final GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  Future<void> loadCallback() async {
    if (context.read<MylarAddSeriesState>().searchQuery.isNotEmpty) {
      context.read<MylarAddSeriesState>().fetchLookup(context);
      await context.read<MylarAddSeriesState>().lookup;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MylarState>(
      builder: (context, state, _) => Selector<MylarAddSeriesState,
          Tuple2<Future<List<MylarSeries>>?, Future<List<MylarExclusion>>?>>(
        selector: (_, state) => Tuple2(state.lookup, state.exclusions),
        builder: (context, tuple, _) {
          if (tuple.item1 == null) return Container();
          return _builder(
            lookup: tuple.item1,
            exclusions: tuple.item2,
            series: state.series,
          );
        },
      ),
    );
  }

  Widget _builder({
    required Future<List<MylarSeries>>? lookup,
    required Future<List<MylarExclusion>>? exclusions,
    required Future<Map<int?, MylarSeries>>? series,
  }) {
    return LunaRefreshIndicator(
      context: context,
      key: _refreshKey,
      onRefresh: loadCallback,
      child: FutureBuilder(
        future: Future.wait([lookup!, series!, exclusions!]),
        builder: (context, AsyncSnapshot<List> snapshot) {
          if (snapshot.hasError) {
            if (snapshot.connectionState != ConnectionState.waiting)
              LunaLogger().error(
                'Unable to fetch Mylar series lookup',
                snapshot.error,
                snapshot.stackTrace,
              );
            return LunaMessage.error(onTap: _refreshKey.currentState!.show);
          }
          if (snapshot.hasData)
            return _list(
              snapshot.data![0],
              snapshot.data![1],
              snapshot.data![2],
            );
          return const LunaLoader();
        },
      ),
    );
  }

  Widget _list(
    List<MylarSeries> results,
    Map<int, MylarSeries> series,
    List<MylarExclusion> exclusions,
  ) {
    if (results.isEmpty)
      return LunaListView(
        controller: widget.scrollController,
        children: [
          LunaMessage.inList(text: 'Mylar.NoResultsFound'.tr()),
        ],
      );
    return LunaListViewBuilder(
      controller: widget.scrollController,
      itemExtent: MylarSeriesAddSearchResultTile.extent,
      itemCount: results.length,
      itemBuilder: (context, index) {
        MylarExclusion? exclusion = exclusions.firstWhereOrNull(
          (exclusion) => exclusion.tvdbId == results[index].tvdbId,
        );
        return MylarSeriesAddSearchResultTile(
          series: results[index],
          exists: series[results[index].id] != null,
          isExcluded: exclusion != null,
        );
      },
    );
  }
}
