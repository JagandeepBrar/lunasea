import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';
import 'package:tautulli/tautulli.dart';

class TautulliSearchSearchResults extends StatefulWidget {
    @override
    State<TautulliSearchSearchResults> createState() => _State();
}

class _State extends State<TautulliSearchSearchResults> {
    final GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey<RefreshIndicatorState>();

    Future<void> _refresh() async => context.read<TautulliState>().fetchSearch();

    @override
    Widget build(BuildContext context) => Selector<TautulliState, Future<TautulliSearch>>(
        selector: (_, state) => state.search,
        builder: (context, future, _) {
            if(future == null) return Container();
            return _futureBuilder(future);
        },
    );

    Widget _futureBuilder(Future<TautulliSearch> future) => LSRefreshIndicator(
        refreshKey: _refreshKey,
        onRefresh: _refresh,
        child: FutureBuilder(
            future: future,
            builder: (context, AsyncSnapshot<TautulliSearch> snapshot) {
                if(snapshot.hasError) {
                    if(snapshot.connectionState != ConnectionState.waiting) {
                        LunaLogger().error('Unable to fetch Tautulli search results', snapshot.error, snapshot.stackTrace);
                    }
                    return LSErrorMessage(onTapHandler: () async => _refreshKey.currentState.show());
                }
                switch(snapshot.connectionState) {
                    case ConnectionState.none: return Container();
                    case ConnectionState.done:
                        if(snapshot.hasData) return snapshot.data.count == 0
                            ? _noResults()
                            : _results(snapshot.data.results);
                        break;
                    case ConnectionState.waiting:
                    case ConnectionState.active:
                    default: break;
                }
                return LSLoader(); 
            },
        ),
    );

    Widget _noResults() => LSGenericMessage(text: 'No Results Found');

    Widget _results(TautulliSearchResults results) => LSListView(
        children: [
            ..._movies(results.movies),
            ..._series(results.shows),
            ..._seasons(results.seasons),
            ..._episodes(results.episodes),
            ..._artists(results.artists),
            ..._albums(results.albums),
            ..._tracks(results.tracks),
            ..._collections(results.collections),
        ],
    );

    List<Widget> _movies(List<TautulliSearchResult> movies) => [
        LSHeader(text: 'movies'),
        if(movies.length == 0) LSGenericMessage(text: 'No Results Found'),
        ...movies.map((movie) => TautulliSearchResultTile(
            result: movie,
            mediaType: TautulliMediaType.MOVIE,
        )),
    ];

    List<Widget> _series(List<TautulliSearchResult> series) => [
        LSHeader(text: 'series'),
        if(series.length == 0) LSGenericMessage(text: 'No Results Found'),
        ...series.map((show) => TautulliSearchResultTile(
            result: show,
            mediaType: TautulliMediaType.SHOW,
        )),
    ];

    List<Widget> _seasons(List<TautulliSearchResult> seasons) => [
        LSHeader(text: 'seasons'),
        if(seasons.length == 0) LSGenericMessage(text: 'No Results Found'),
        ...seasons.map((show) => TautulliSearchResultTile(
            result: show,
            mediaType: TautulliMediaType.SEASON,
        )),
    ];

    List<Widget> _episodes(List<TautulliSearchResult> episodes) => [
        LSHeader(text: 'episodes'),
        if(episodes.length == 0) LSGenericMessage(text: 'No Results Found'),
        ...episodes.map((show) => TautulliSearchResultTile(
            result: show,
            mediaType: TautulliMediaType.EPISODE,
        )),
    ];

    List<Widget> _artists(List<TautulliSearchResult> artists) => [
        LSHeader(text: 'artists'),
        if(artists.length == 0) LSGenericMessage(text: 'No Results Found'),
        ...artists.map((show) => TautulliSearchResultTile(
            result: show,
            mediaType: TautulliMediaType.ARTIST,
        )),
    ];

    List<Widget> _albums(List<TautulliSearchResult> albums) => [
        LSHeader(text: 'albums'),
        if(albums.length == 0) LSGenericMessage(text: 'No Results Found'),
        ...albums.map((show) => TautulliSearchResultTile(
            result: show,
            mediaType: TautulliMediaType.ALBUM,
        )),
    ];

    List<Widget> _tracks(List<TautulliSearchResult> tracks) => [
        LSHeader(text: 'tracks'),
        if(tracks.length == 0) LSGenericMessage(text: 'No Results Found'),
        ...tracks.map((show) => TautulliSearchResultTile(
            result: show,
            mediaType: TautulliMediaType.TRACK,
        )),
    ];

    List<Widget> _collections(List<TautulliSearchResult> collections) => [
        LSHeader(text: 'collections'),
        if(collections.length == 0) LSGenericMessage(text: 'No Results Found'),
        ...collections.map((show) => TautulliSearchResultTile(
            result: show,
            mediaType: TautulliMediaType.COLLECTION,
        )),
    ];
}