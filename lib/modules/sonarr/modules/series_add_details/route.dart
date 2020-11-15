import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
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

    static void defineRoutes(FluroRouter router) {
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
    bool _initialLoad = false;

    @override
    void initState() {
        super.initState();
        SchedulerBinding.instance.scheduleFrameCallback((_) => _refresh());
    }

    Future<void> _refresh() async {
        context.read<SonarrState>().fetchRootFolders();
        context.read<SonarrState>().resetTags();
        context.read<SonarrState>().resetQualityProfiles();
        context.read<SonarrState>().resetLanguageProfiles();
        setState(() => _initialLoad = true);
    }

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        body: _initialLoad ? _body : LSLoader(),
    );

    Widget get _appBar => LunaAppBar(
        context: context,
        title: 'Add Series',
        popUntil: '/sonarr',
        actions: [
            SonarrSeriesAddDetailsAppbarLinkAction(tvdbId: widget.tvdbId),
        ],
    );

    Widget get _body => FutureBuilder(
        future: Future.wait([
            context.watch<SonarrState>().seriesLookup,
            context.watch<SonarrState>().rootFolders,
            context.watch<SonarrState>().tags,
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
                    tags: snapshot.data[2],
                    qualityProfiles: snapshot.data[3],
                    languageProfiles: snapshot.data.length == 4 ? null : snapshot.data[4],
                );
                return _unknown;
            }
            return LSLoader();
        },
    );

    Widget _list({
        @required SonarrSeriesLookup series,
        @required List<SonarrRootFolder> rootFolders,
        @required List<SonarrQualityProfile> qualityProfiles,
        @required List<SonarrLanguageProfile> languageProfiles,
        @required List<SonarrTag> tags,
    }) => ChangeNotifierProvider(
        create: (_) => SonarrSeriesAddDetailsState(
            series: series,
            rootFolders: rootFolders,
            qualityProfiles: qualityProfiles,
            languageProfiles: languageProfiles,
            tags: tags,
        ),
        builder: (context, _) {
            if(context.watch<SonarrSeriesAddDetailsState>().state == LunaLoadingState.ERROR)
                return LSGenericMessage(text: 'An Error Has Occurred');
            return LSListView(
                children: [
                    SonarrSeriesAddSearchResultTile(series: series, onTapShowOverview: true, exists: false),
                    SonarrSeriesAddDetailsMonitoredTile(),
                    SonarrSeriesAddDetailsUseSeasonFoldersTile(),
                    SonarrSeriesAddDetailsSeriesTypeTile(),
                    SonarrSeriesAddDetailsMonitorStatusTile(),
                    SonarrSeriesAddDetailsRootFolderTile(),
                    SonarrSeriesAddDetailsQualityProfileTile(),
                    if(context.watch<SonarrState>().enableVersion3)
                        SonarrSeriesAddDetailsLanguageProfileTile(),
                    SonarrSeriesAddDetailsTagsTile(),
                    SonarrSeriesAddDetailsAddSeriesButton(),
                ],
            );
        },
    );

    Widget get _unknown => LSGenericMessage(text: 'Series Not Found');
}
