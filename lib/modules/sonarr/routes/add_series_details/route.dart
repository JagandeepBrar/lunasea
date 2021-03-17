import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class _SonarrAddSeriesDetailsArguments {
    SonarrSeriesLookup series;

    _SonarrAddSeriesDetailsArguments({
        @required this.series,
    }) {
        assert(series != null);
    }
}

class SonarrAddSeriesDetailsRouter extends SonarrPageRouter {
    SonarrAddSeriesDetailsRouter() : super('/sonarr/addseries/:tvdbid');

    @override
    Future<void> navigateTo(BuildContext context, {
        @required int tvdbId,
        @required SonarrSeriesLookup series,
    }) => LunaRouter.router.navigateTo(
        context,
        route(tvdbId: tvdbId),
        routeSettings: RouteSettings(arguments: _SonarrAddSeriesDetailsArguments(series: series)),
    );

    @override route({
        @required int tvdbId,
    }) => fullRoute.replaceFirst(':tvdbid', tvdbId.toString());

    @override
    void defineRoute(FluroRouter router) => super.withParameterRouteDefinition(router, (context, params) {
        int tvdbId = params['tvdbid'] == null || params['tvdbid'].length == 0 ? -1 : (int.tryParse(params['tvdbid'][0]) ?? -1);
        return _SonarrAddSeriesDetailsRoute(tvdbId: tvdbId);
    });
}

class _SonarrAddSeriesDetailsRoute extends StatefulWidget {
    final int tvdbId;

    _SonarrAddSeriesDetailsRoute({
        Key key,
        @required this.tvdbId,
    }): super(key: key);

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<_SonarrAddSeriesDetailsRoute> {
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
        title: 'Add Series',
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
