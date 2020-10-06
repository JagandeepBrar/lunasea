import 'package:fluro_fork/fluro_fork.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrReleasesRouter {
    static const String ROUTE_NAME = '/sonarr/releases/:episodeid';

    static Future<void> navigateTo(BuildContext context, {
        @required int episodeId,
    }) async => SonarrRouter.router.navigateTo(
        context,
        route(episodeId: episodeId),
    );

    static String route({
        @required int episodeId,
    }) => ROUTE_NAME.replaceFirst(':episodeid', episodeId?.toString() ?? -1);

    static void defineRoutes(Router router) {
        router.define(
            ROUTE_NAME,
            handler: Handler(handlerFunc: (context, params) => _SonarrReleasesRoute(
                episodeId: int.tryParse(params['episodeid'][0]) ?? -1,
            )),
            transitionType: LunaRouter.transitionType,
        );
    }
}

class _SonarrReleasesRoute extends StatefulWidget {
    final int episodeId;

    _SonarrReleasesRoute({
        Key key,
        @required this.episodeId,
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
            _future = context.read<SonarrState>().api.release.getReleases(episodeId: widget.episodeId);
        });
    }

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        body: _body,
    );

    Widget get _appBar => SonarrReleasesAppBar(context: context, scrollController: _scrollController);

    Widget get _body => LSRefreshIndicator(
        refreshKey: _refreshKey,
        onRefresh: _refresh,
        child: FutureBuilder(
            future: _future,
            builder: (context, AsyncSnapshot<List<SonarrRelease>> snapshot) {
                if(snapshot.hasError) {
                    if(snapshot.connectionState != ConnectionState.waiting) {
                        LunaLogger.error(
                            '_SonarrReleasesRoute',
                            '_body',
                            'Unable to fetch Sonarr releases: ${widget.episodeId}',
                            snapshot.error,
                            null,
                            uploadToSentry: !(snapshot.error is DioError),
                        );
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
        SonarrLocalState _state = context.read<SonarrLocalState>();
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

    Widget _releases(List<SonarrRelease> releases) => Consumer<SonarrLocalState>(
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
                        ),
                    ),
            );
        }
    );
}
