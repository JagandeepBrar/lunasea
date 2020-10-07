import 'package:fluro_fork/fluro_fork.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrSeriesAddDetailsRouter {
    static const String ROUTE_NAME = '/sonarr/series/add/details/:tvdbid';

    static Future<void> navigateTo(BuildContext context, {
        @required int tvdbId,
    }) async => LunaRouter.router.navigateTo(
        context,
        route(tvdbId: tvdbId),
    );

    static String route({ @required int tvdbId }) => ROUTE_NAME
        .replaceFirst(':tvdbid', tvdbId?.toString() ?? '-1');

    static void defineRoutes(Router router) {
        router.define(
            ROUTE_NAME,
            handler: Handler(handlerFunc: (context, params) => _SonarrSeriesAddDetailsRoute(
                tvdbId: int.tryParse(params['tvdbid'][0]) ?? -1,
            )),
            transitionType: LunaRouter.transitionType,
        );
    }
}

class _SonarrSeriesAddDetailsRoute extends StatefulWidget {
    final int tvdbId;

    _SonarrSeriesAddDetailsRoute({
        Key key,
        @required this.tvdbId,
    }): super(key: key);

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<_SonarrSeriesAddDetailsRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey<RefreshIndicatorState>();
    bool _loaded = false;

    @override
    void initState() {
        super.initState();
        SchedulerBinding.instance.scheduleFrameCallback((_) => _setDefaults());
    }

    Future<void> _setDefaults() async {
        // Get the state, wait for the futures
        SonarrState _state = Provider.of<SonarrState>(context, listen: false);
        await Future.wait([
            _state.rootFolders,
            _state.seriesLookup,
            _state.qualityProfiles,
            if(_state.enableVersion3) _state.languageProfiles,
        ]);
        SonarrSeriesLookup series = (await _state.seriesLookup).firstWhere(
            (series) => series?.tvdbId == widget.tvdbId,
            orElse: () => null,
        );
        if(series != null) {
            series.monitored = SonarrDatabaseValue.ADD_SERIES_DEFAULT_MONITORED.data;
            series.seasonFolder = SonarrDatabaseValue.ADD_SERIES_DEFAULT_USE_SEASON_FOLDERS.data;
            await _setDefaultRootFolder(series);
            await _setDefaultQualityProfile(series);
            await _setDefaultMonitorStatus(series);
            if(_state.enableVersion3) await _setDefaultLanguageProfile(series);
        }
        // Set the defaults
        setState(() => _loaded = true);
    }

    Future<void> _setDefaultMonitorStatus(SonarrSeriesLookup series) async {
        SonarrMonitorStatus _status = SonarrDatabaseValue.ADD_SERIES_DEFAULT_MONITOR_STATUS.data;
        _status.process(series.seasons);
    }

    Future<void> _setDefaultRootFolder(SonarrSeriesLookup series) async {
        List<SonarrRootFolder> _rootFolders = await Provider.of<SonarrState>(context, listen: false).rootFolders;
        SonarrRootFolder _rootFolder = _rootFolders.firstWhere(
            (element) => element.id == SonarrDatabaseValue.ADD_SERIES_DEFAULT_ROOT_FOLDER.data,
            orElse: () => null,
        );
        series.rootFolderPath = (_rootFolder?.path ?? _rootFolders[0].path);
        SonarrDatabaseValue.ADD_SERIES_DEFAULT_ROOT_FOLDER.put((_rootFolder?.id ?? _rootFolders[0].id));
    }

    Future<void> _setDefaultQualityProfile(SonarrSeriesLookup series) async {
        List<SonarrQualityProfile> _profiles = await Provider.of<SonarrState>(context, listen: false).qualityProfiles;
        SonarrQualityProfile _profile = _profiles.firstWhere(
            (element) => element.id == SonarrDatabaseValue.ADD_SERIES_DEFAULT_QUALITY_PROFILE.data,
            orElse: () => null,
        );
        series.qualityProfileId = (_profile?.id ?? _profiles[0].id);
        series.profileId = (_profile?.id ?? _profiles[0].id);
        SonarrDatabaseValue.ADD_SERIES_DEFAULT_QUALITY_PROFILE.put((_profile?.id ?? _profiles[0].id));
    }

    Future<void> _setDefaultLanguageProfile(SonarrSeriesLookup series) async {
        List<SonarrLanguageProfile> _profiles = await Provider.of<SonarrState>(context, listen: false).languageProfiles;
        SonarrLanguageProfile _profile = _profiles.firstWhere(
            (element) => element.id == SonarrDatabaseValue.ADD_SERIES_DEFAULT_LANGUAGE_PROFILE.data,
            orElse: () => null,
        );
        series.languageProfileId = (_profile?.id ?? _profiles[0].id);
        SonarrDatabaseValue.ADD_SERIES_DEFAULT_LANGUAGE_PROFILE.put((_profile?.id ?? _profiles[0].id));
    }

    Future<void> _refresh() async {
        // Get the state
        SonarrState _state = Provider.of<SonarrState>(context, listen: false);
        // Refresh the necessary data
        _state.fetchRootFolders(context);
        _state.resetQualityProfiles();
        _state.resetLanguageProfiles();
        // Wait for the data to load
        await Future.wait([
            _state.rootFolders,
            _state.qualityProfiles,
            if(_state.enableVersion3) _state.languageProfiles,
        ]);
        setState(() {});
    }

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        body: _loaded ? _body : LSLoader(),
    );

    Widget get _appBar => LunaAppBar(
        context: context,
        title: 'Add Series',
        popUntil: '/sonarr',
        actions: [
            SonarrSeriesAddDetailsAppbarLinkAction(tvdbId: widget.tvdbId),
        ],
    );

    Widget get _body => LSRefreshIndicator(
        refreshKey: _refreshKey,
        onRefresh: _refresh,
        child: FutureBuilder(
            future: Future.wait([
                context.watch<SonarrState>().seriesLookup,
                context.watch<SonarrState>().rootFolders,
                context.watch<SonarrState>().qualityProfiles,
                if(context.watch<SonarrState>().enableVersion3)
                    context.watch<SonarrState>().languageProfiles,
            ]),
            builder: (context, AsyncSnapshot<List<Object>> snapshot) {
                if(snapshot.hasError) return LSErrorMessage(onTapHandler: () => _refresh());
                if(snapshot.hasData) {
                    SonarrSeriesLookup series = (snapshot.data[0] as List<SonarrSeriesLookup>).firstWhere(
                        (series) => series?.tvdbId == widget.tvdbId,
                        orElse: () => null,
                    );
                    if(series != null) return _list(
                        series: series,
                        rootFolders: snapshot.data[1],
                        qualityProfiles: snapshot.data[2],
                        languageProfiles: snapshot.data.length == 3 ? null : snapshot.data[3],
                    );
                    return _unknown;
                }
                return LSLoader();
            },
        ),
    );

    Widget _list({
        @required SonarrSeriesLookup series,
        @required List<SonarrRootFolder> rootFolders,
        @required List<SonarrQualityProfile> qualityProfiles,
        @required List<SonarrLanguageProfile> languageProfiles,
    }) => LSListView(
        children: [
            SonarrSeriesAddSearchResultTile(series: series, onTapShowOverview: true, exists: false),
            SonarrSeriesAddDetailsMonitoredTile(series: series),
            SonarrSeriesAddDetailsUseSeasonFoldersTile(series: series),
            SonarrSeriesAddDetailsSeriesTypeTile(series: series),
            SonarrSeriesAddDetailsMonitorStatusTile(series: series),
            SonarrSeriesAddDetailsRootFolderTile(series: series, rootFolder: rootFolders),
            SonarrSeriesAddDetailsQualityProfileTile(series: series, profiles: qualityProfiles),
            if(Provider.of<SonarrState>(context).enableVersion3)
                SonarrSeriesAddDetailsLanguageProfileTile(series: series, profiles: languageProfiles),
            SonarrSeriesAddDetailsAddSeriesButton(series: series, rootFolders: rootFolders),
        ],
    );

    Widget get _unknown => LSGenericMessage(text: 'Series Not Found');
}
