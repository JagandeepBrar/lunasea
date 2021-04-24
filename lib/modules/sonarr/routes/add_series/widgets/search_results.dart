import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrSeriesAddSearchResults extends StatefulWidget {
  final ScrollController scrollController;

  SonarrSeriesAddSearchResults({
    Key key,
    @required this.scrollController,
  }) : super(key: key);

  @override
  State<SonarrSeriesAddSearchResults> createState() => _State();
}

class _State extends State<SonarrSeriesAddSearchResults>
    with LunaLoadCallbackMixin {
  final GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();

  Future<void> loadCallback() async {
    if (context.read<SonarrAddSeriesState>().searchQuery.isNotEmpty) {
      context.read<SonarrAddSeriesState>().fetchLookup(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Selector<SonarrState, Future<List<SonarrSeries>>>(
      selector: (_, state) => state.series,
      builder: (context, series, _) =>
          Selector<SonarrAddSeriesState, Future<List<SonarrSeriesLookup>>>(
        selector: (_, state) => state.lookup,
        builder: (context, lookup, _) {
          if (lookup == null) return Container();
          return _futureBuilder(
            lookup: lookup,
            series: series,
          );
        },
      ),
    );
  }

  Widget _futureBuilder({
    @required Future<List<SonarrSeriesLookup>> lookup,
    @required Future<List<SonarrSeries>> series,
  }) {
    return LunaRefreshIndicator(
      context: context,
      key: _refreshKey,
      onRefresh: loadCallback,
      child: FutureBuilder(
        future: Future.wait([
          lookup,
          series,
        ]),
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
            return _results(snapshot.data[0], snapshot.data[1]);
          return LunaLoader();
        },
      ),
    );
  }

  Widget _results(List<SonarrSeriesLookup> results, List<SonarrSeries> series) {
    if ((results?.length ?? 0) == 0)
      return LunaListView(
        controller: widget.scrollController,
        children: [
          LunaMessage.inList(text: 'No Results Found'),
        ],
      );
    return LunaListViewBuilder(
      controller: widget.scrollController,
      itemCount: results.length,
      itemBuilder: (context, index) => SonarrSeriesAddSearchResultTile(
        series: results[index],
        exists: series.indexWhere(
                (series) => series.tvdbId == results[index].tvdbId) >=
            0,
      ),
    );
  }
}
