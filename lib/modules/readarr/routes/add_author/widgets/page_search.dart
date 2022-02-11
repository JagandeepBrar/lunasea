import 'package:collection/collection.dart' show IterableExtension;
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/readarr.dart';

class ReadarrAddSeriesSearchPage extends StatefulWidget {
  final ScrollController scrollController;

  const ReadarrAddSeriesSearchPage({
    Key? key,
    required this.scrollController,
  }) : super(key: key);

  @override
  State<ReadarrAddSeriesSearchPage> createState() => _State();
}

class _State extends State<ReadarrAddSeriesSearchPage>
    with LunaLoadCallbackMixin {
  final GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  Future<void> loadCallback() async {
    if (context.read<ReadarrAddSeriesState>().searchQuery.isNotEmpty) {
      context.read<ReadarrAddSeriesState>().fetchLookup(context);
      await context.read<ReadarrAddSeriesState>().lookup;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ReadarrState>(
      builder: (context, state, _) => Selector<
          ReadarrAddSeriesState,
          Tuple2<Future<List<ReadarrAuthor>>?,
              Future<List<ReadarrExclusion>>?>>(
        selector: (_, state) => Tuple2(state.lookup, state.exclusions),
        builder: (context, tuple, _) {
          if (tuple.item1 == null) return Container();
          return _builder(
            lookup: tuple.item1,
            exclusions: tuple.item2,
            series: state.authors,
          );
        },
      ),
    );
  }

  Widget _builder({
    required Future<List<ReadarrAuthor>>? lookup,
    required Future<List<ReadarrExclusion>>? exclusions,
    required Future<Map<int?, ReadarrAuthor>>? series,
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
                'Unable to fetch Readarr series lookup',
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
    List<ReadarrAuthor> results,
    Map<int, ReadarrAuthor> series,
    List<ReadarrExclusion> exclusions,
  ) {
    if (results.isEmpty)
      return LunaListView(
        controller: widget.scrollController,
        children: [
          LunaMessage.inList(text: 'readarr.NoResultsFound'.tr()),
        ],
      );
    return LunaListViewBuilder(
      controller: widget.scrollController,
      itemExtent: ReadarrAuthorAddSearchResultTile.extent,
      itemCount: results.length,
      itemBuilder: (context, index) {
        ReadarrExclusion? exclusion = exclusions.firstWhereOrNull(
          (exclusion) => exclusion.foreignId == results[index].foreignAuthorId,
        );
        return ReadarrAuthorAddSearchResultTile(
          series: results[index],
          exists: series[results[index].id] != null,
          isExcluded: exclusion != null,
        );
      },
    );
  }
}
