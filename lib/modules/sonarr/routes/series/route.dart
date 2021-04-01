import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';
import 'package:tuple/tuple.dart';

class SonarrSeriesRoute extends StatefulWidget {
    @override
    State<SonarrSeriesRoute> createState() => _State();
}

class _State extends State<SonarrSeriesRoute> with AutomaticKeepAliveClientMixin {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey<RefreshIndicatorState>();
    
    @override
    bool get wantKeepAlive => true;

    @override
    void initState() {
        super.initState();
        SchedulerBinding.instance.scheduleFrameCallback((_) => _refresh());
    }

    Future<void> _refresh() async {
        SonarrState _state = Provider.of<SonarrState>(context, listen: false);
        _state.resetSeries();
        _state.resetQualityProfiles();
        _state.resetLanguageProfiles();
        _state.resetTags();
        await Future.wait([
            _state.series,
            _state.qualityProfiles,
            _state.tags,
            if(_state.enableVersion3) _state.languageProfiles,
        ]);
    }

    @override
    Widget build(BuildContext context) {
        super.build(context);
        return Scaffold(
            key: _scaffoldKey,
            body: _body(),
            appBar: _appBar(),
        );
    }

    Widget _appBar() {
        return LunaAppBar.empty(
            child: SonarrSeriesSearchBar(scrollController: SonarrNavigationBar.scrollControllers[0]),
            height: LunaTextInputBar.appBarHeight,
        );
    }

    Widget _body() {
        return LunaRefreshIndicator(
            context: context,
            key: _refreshKey,
            onRefresh: _refresh,
            child: Selector<SonarrState, Tuple4<
                Future<List<SonarrSeries>>,
                Future<List<SonarrQualityProfile>>,
                Future<List<SonarrLanguageProfile>>,
                bool
            >>(
                selector: (_, state) => Tuple4(
                    state.series,
                    state.qualityProfiles,
                    state.languageProfiles,
                    state.enableVersion3,
                ),
                builder: (context, tuple, _) => FutureBuilder(
                    future: Future.wait([
                        tuple.item1,
                        tuple.item2,
                        if(tuple.item4) tuple.item3,
                    ]),
                    builder: (context, AsyncSnapshot<List<Object>> snapshot) {
                        if(snapshot.hasError) {
                            if(snapshot.connectionState != ConnectionState.waiting) {
                                LunaLogger().error('Unable to fetch Sonarr series', snapshot.error, snapshot.stackTrace);
                            }
                            return LunaMessage.error(onTap: _refreshKey.currentState?.show);
                        }
                        if(snapshot.hasData) {
                            return snapshot.data.length > 2
                                ? _series(snapshot.data[0], snapshot.data[1], snapshot.data[2])
                                : _series(snapshot.data[0], snapshot.data[1], null);
                        }
                        return LunaLoader();
                    },
                ),
            ),
        );
    }
    
    List<SonarrSeries> _filterAndSort(List<SonarrSeries> series, List<SonarrQualityProfile> profiles, String query) {
        if(series == null || series.length == 0) return series;
        SonarrState _state = Provider.of<SonarrState>(context, listen: false);
        // Filter
        List<SonarrSeries> _filtered = series.where((show) {
            if(query != null && query.isNotEmpty) return show.title.toLowerCase().contains(query.toLowerCase());
            return show != null;
        }).toList();
        _filtered = _state.seriesHidingType.filter(_filtered);
        // Sort
        _filtered = _state.seriesSortType.sort(_filtered, _state.seriesSortAscending);
        return _filtered;
    }

    Widget _series(
        List<SonarrSeries> series,
        List<SonarrQualityProfile> qualities,
        List<SonarrLanguageProfile> languages,
    ) {
        if((series?.length ?? 0) == 0) return LunaMessage(
            text: 'No Series Found',
            buttonText: 'Refresh',
            onTap: _refreshKey.currentState?.show,
        );
        return Selector<SonarrState, String>(
            selector: (_, state) => state.seriesSearchQuery,
            builder: (context, query, _) {
                List<SonarrSeries> _filtered = _filterAndSort(series, qualities, query);
                if((_filtered?.length ?? 0) == 0) return LunaListView(
                    controller: SonarrNavigationBar.scrollControllers[0],
                    children: [
                        LunaMessage.inList(text: 'No Series Found'),
                        LunaButtonContainer(
                            children: [
                                LunaButton.text(
                                    text: query.length > 20
                                        ? 'Search for "${query.substring(0, min(20, query.length))}${LunaUI.TEXT_ELLIPSIS}"'
                                        : 'Search for "$query"',
                                    backgroundColor: LunaColours.accent,
                                    onTap: () async => SonarrAddSeriesRouter().navigateTo(context, query: query ?? ''),
                                ),
                            ],
                        ),
                    ],
                );
                return LunaListViewBuilder(
                    controller: SonarrNavigationBar.scrollControllers[0],
                    itemCount: _filtered.length,
                    itemBuilder: (context, index) => SonarrSeriesTile(
                        series: _filtered[index],
                        profile: qualities.firstWhere((element) => element.id == _filtered[index].profileId, orElse: null),
                    ),
                );
            },
        );
    }
}
