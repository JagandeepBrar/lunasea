import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrAddSeriesSearchPage extends StatefulWidget {
  final ScrollController scrollController;

  const SonarrAddSeriesSearchPage({
    Key key,
    @required this.scrollController,
  }) : super(key: key);

  @override
  State<SonarrAddSeriesSearchPage> createState() => _State();
}

class _State extends State<SonarrAddSeriesSearchPage>
    with LunaLoadCallbackMixin {
  final GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  Future<void> loadCallback() async {
    if (context.read<SonarrAddSeriesState>().searchQuery.isNotEmpty) {
      context.read<SonarrAddSeriesState>().fetchLookup(context);
      await context.read<SonarrAddSeriesState>().lookup;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Selector<SonarrState, Future<List<SonarrSeries>>>(
      selector: (_, state) => state.series,
      builder: (context, series, _) => Selector<SonarrAddSeriesState,
          Tuple2<Future<List<SonarrSeries>>, Future<List<SonarrExclusion>>>>(
        selector: (_, state) => Tuple2(state.lookup, state.exclusions),
        builder: (context, tuple, _) {
          if (tuple.item1 == null) return Container();
          return _builder(
            lookup: tuple.item1,
            exclusions: tuple.item2,
            series: series,
          );
        },
      ),
    );
  }

  Widget _builder({
    @required Future<List<SonarrSeries>> lookup,
    @required Future<List<SonarrExclusion>> exclusions,
    @required Future<List<SonarrSeries>> series,
  }) {
    return LunaRefreshIndicator(
      context: context,
      key: _refreshKey,
      onRefresh: loadCallback,
      child: FutureBuilder(
        future: Future.wait([lookup, series, exclusions]),
        builder: (context, AsyncSnapshot<List> snapshot) {
          if (snapshot.hasError) {
            if (snapshot.connectionState != ConnectionState.waiting)
              LunaLogger().error(
                'Unable to fetch Sonarr series lookup',
                snapshot.error,
                snapshot.stackTrace,
              );
            return LunaMessage.error(onTap: _refreshKey.currentState.show);
          }
          if (snapshot.hasData)
            return _list(
              snapshot.data[0],
              snapshot.data[1],
              snapshot.data[2],
            );
          return const LunaLoader();
        },
      ),
    );
  }

  Widget _list(
    List<SonarrSeries> results,
    List<SonarrSeries> series,
    List<SonarrExclusion> exclusions,
  ) {
    if ((results?.length ?? 0) == 0)
      return LunaListView(
        controller: widget.scrollController,
        children: [
          LunaMessage.inList(text: 'sonarr.NoResultsFound'.tr()),
        ],
      );
    return LunaListViewBuilder(
        controller: widget.scrollController,
        itemCount: results.length,
        itemBuilder: (context, index) {
          SonarrExclusion exclusion = exclusions?.firstWhere(
            (exclusion) => exclusion.tvdbId == results[index].tvdbId,
            orElse: () => null,
          );
          SonarrSeries show = series?.firstWhere(
            (s) => (s?.id ?? -1) == results[index].id,
            orElse: () => null,
          );
          return SonarrSeriesAddSearchResultTile(
            series: results[index],
            exists: show != null,
            isExcluded: exclusion != null,
          );
        });
  }
}
