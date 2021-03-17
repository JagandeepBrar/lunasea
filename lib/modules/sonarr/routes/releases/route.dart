import 'package:fluro/fluro.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrReleasesRouter extends SonarrPageRouter {
    SonarrReleasesRouter() : super('/sonarr/releases');

    @override
    Future<void> navigateTo(BuildContext context, {
        int episodeId,
        int seriesId,
        int seasonNumber,
    }) async => LunaRouter.router.navigateTo(
        context,
        route(episodeId: episodeId, seriesId: seriesId, seasonNumber: seasonNumber),
    );

    @override
    String route({
        int episodeId,
        int seriesId,
        int seasonNumber,
    }) {
        if(episodeId != null) return fullRoute+'/episode/$episodeId';
        if(seriesId != null && seasonNumber != null) return fullRoute+'/series/$seriesId/season/$seasonNumber';
        return SonarrHomeRouter().route();
    }

    @override
    void defineRoute(FluroRouter router) {
        router.define(
            fullRoute+'/episode/:episodeid',
            handler: Handler(handlerFunc: (context, params) {
                if(!context.read<SonarrState>().enabled) return LunaNotEnabledRoute(module: 'Sonarr');
                int episodeId = params['episodeid'] == null || params['episodeid'].length == 0 ? -1 : (int.tryParse(params['episodeid'][0]) ?? -1);
                return _SonarrReleasesRoute(episodeId: episodeId);
            }),
            transitionType: LunaRouter.transitionType,
        );
        router.define(
            fullRoute+'/series/:seriesid/season/:seasonnumber',
            handler: Handler(handlerFunc: (context, params) {
                if(!context.read<SonarrState>().enabled) return LunaNotEnabledRoute(module: 'Sonarr');
                int seriesId = params['seriesid'] == null || params['seriesid'].length == 0 ? -1 : (int.tryParse(params['seriesid'][0]) ?? -1);
                int seasonNumber = params['seasonnumber'] == null || params['seasonnumber'].length == 0 ? -1 : (int.tryParse(params['seasonnumber'][0]) ?? -1);
                return _SonarrReleasesRoute(
                    seriesId: seriesId,
                    seasonNumber: seasonNumber,
                );
            }),
            transitionType: LunaRouter.transitionType,
        );
    }
}

class _SonarrReleasesRoute extends StatefulWidget {
    final int episodeId;
    final int seriesId;
    final int seasonNumber;

    _SonarrReleasesRoute({
        Key key,
        this.episodeId,
        this.seriesId,
        this.seasonNumber,
    }) : super(key: key);

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<_SonarrReleasesRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey<RefreshIndicatorState>();
    final ScrollController _scrollController = ScrollController();
    Future<List<SonarrRelease>> _future;

    @override
    void initState() {
        super.initState();
        SchedulerBinding.instance.scheduleFrameCallback((_) => _refresh());
    }

    Future<void> _refresh() async {
        if(context.read<SonarrState>().api != null && mounted) setState(() {
            if(widget.episodeId != null) {
                _future = context.read<SonarrState>().api.release.getReleases(episodeId: widget.episodeId);
            } else if(widget.seriesId != null && widget.seasonNumber != null) {
                _future = context.read<SonarrState>().api.release.getSeasonReleases(seriesId: widget.seriesId, seasonNumber: widget.seasonNumber)
                .then((data) => data = data.where((release) => release.fullSeason).toList());
            } else {
                LunaLogger().warning(
                    '_SonarrReleasesRoute',
                    '_refresh',
                    'No valid episodeId or (seriesId & seasonNumber) found',
                );
            }
        });
    }

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        body: _body,
    );

    Widget get _appBar => SonarrReleasesAppBar(scrollController: _scrollController);

    Widget get _body => LSRefreshIndicator(
        refreshKey: _refreshKey,
        onRefresh: _refresh,
        child: FutureBuilder(
            future: _future,
            builder: (context, AsyncSnapshot<List<SonarrRelease>> snapshot) {
                if(snapshot.hasError) {
                    if(snapshot.connectionState != ConnectionState.waiting) {
                        LunaLogger().error('Unable to fetch Sonarr releases: ${widget.episodeId}', snapshot.error, StackTrace.current);
                    }
                    return LSErrorMessage(onTapHandler: () async => _refreshKey.currentState.show());
                }
                if(snapshot.connectionState == ConnectionState.done && snapshot.hasData) return snapshot.data.length == 0
                    ? _noReleases()
                    : _releases(snapshot.data);
                return LSLoader();
            },
        ),
    );

    List<SonarrRelease> _filterAndSort(List<SonarrRelease> releases) {
        if(releases == null || releases.length == 0) return releases;
        List<SonarrRelease> _filtered = new List<SonarrRelease>.from(releases);
        SonarrState _state = context.read<SonarrState>();
        // Filter
        _filtered = _filtered.where((release) {
            if(_state.releasesSearchQuery != null && _state.releasesSearchQuery.isNotEmpty)
                return release.title.toLowerCase().contains(_state.releasesSearchQuery.toLowerCase());
            return release != null;
        }).toList();
        _filtered = _state.releasesHidingType.filter(_filtered);
        // Sort
        _filtered = _state.releasesSortType.sort(_filtered, _state.releasesSortAscending);
        return _filtered;
    }

    Widget _noReleases({ bool showButton = true }) => LSGenericMessage(
        text: 'No Releases Found',
        showButton: showButton,
        buttonText: 'Refresh',
        onTapHandler: _refresh,
    );

    Widget _releases(List<SonarrRelease> releases) => Consumer<SonarrState>(
        builder: (context, state, _) {
            List<SonarrRelease> _filtered = _filterAndSort(releases);
            return LSListView(
                controller: _scrollController,
                children: _filtered.length ==0
                    ? [_noReleases(showButton: false)]
                    : List.generate(
                        _filtered.length,
                        (index) => SonarrReleasesReleaseTile(
                            key: ObjectKey(_filtered[index].guid),
                            release: _filtered[index],
                            isSeasonRelease: widget.episodeId == null,
                        ),
                    ),
            );
        }
    );
}
