import 'package:fluro_fork/fluro_fork.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrSeriesEditRouter {
    static const String ROUTE_NAME = '/sonarr/series/edit/:seriesid';

    static Future<void> navigateTo(BuildContext context, {
        @required int seriesId,
    }) async => SonarrRouter.router.navigateTo(
        context,
        route(seriesId: seriesId),
    );

    static String route({ @required int seriesId }) => ROUTE_NAME
        .replaceFirst(':seriesid', seriesId?.toString() ?? '-1');

    static void defineRoutes(Router router) {
        router.define(
            ROUTE_NAME,
            handler: Handler(handlerFunc: (context, params) => _SonarrSeriesEditRoute(
                seriesId: int.tryParse(params['seriesid'][0]) ?? -1,
            )),
            transitionType: LunaRouter.transitionType,
        );
    }
}

class _SonarrSeriesEditRoute extends StatefulWidget {
    final int seriesId;

    _SonarrSeriesEditRoute({
        Key key,
        @required this.seriesId,
    }) : super(key: key);

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<_SonarrSeriesEditRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    bool _initialLoad = false;

    @override
    void initState() {
        super.initState();
        SchedulerBinding.instance.scheduleFrameCallback((_) => _refresh());
    }
    
    Future<void> _refresh() async {
        SonarrState _globalState = context.read<SonarrState>();
        SonarrLocalState _localState = context.read<SonarrLocalState>();
        _localState.fetchRootFolders(context);
        _globalState.resetQualityProfiles();
        _globalState.resetLanguageProfiles();
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
        title: 'Edit Series',
        popUntil: '/sonarr',
    );

    Widget get _body => FutureBuilder(
        future: Future.wait([
            Provider.of<SonarrState>(context).series,               // 0
            Provider.of<SonarrState>(context).qualityProfiles,      // 1
            if(Provider.of<SonarrState>(context).enableVersion3)    // 2.?
                Provider.of<SonarrState>(context).languageProfiles,
        ]),
        builder: (context, AsyncSnapshot<List<Object>> snapshot) {
            if(snapshot.hasError) return LSErrorMessage(onTapHandler: () => _refresh());
            if(snapshot.hasData) {
                SonarrSeries series = (snapshot.data[0] as List<SonarrSeries>).firstWhere(
                    (series) => series?.id == widget.seriesId,
                    orElse: () => null,
                );
                if(series != null) return _list(
                    series: series,
                    qualityProfiles: snapshot.data[1],
                    languageProfiles: snapshot.data.length == 2 ? null : snapshot.data[2],
                );
                return _unknown;
            }
            return LSLoader();
        },
    );

    Widget _list({
        @required SonarrSeries series,
        @required List<SonarrQualityProfile> qualityProfiles,
        @required List<SonarrLanguageProfile> languageProfiles,
    }) => ChangeNotifierProvider(
        create: (_) => SonarrSeriesEditState(
            series: series,
            qualityProfiles: qualityProfiles ?? [],
            languageProfiles: languageProfiles ?? [],
        ),
        builder: (context, _) {
            if(context.watch<SonarrSeriesEditState>().state == LunaLoadingState.ERROR)
                return LSGenericMessage(text: 'An Error Has Occurred');
            return LSListView(
                children: [
                    SonarrSeriesEditMonitoredTile(),
                    SonarrSeriesEditSeasonFoldersTile(),
                    SonarrSeriesEditSeriesPathTile(),
                    SonarrSeriesEditQualityProfileTile(profiles: qualityProfiles),
                    context.watch<SonarrState>().enableVersion3
                        ? SonarrSeriesEditLanguageProfileTile(profiles: languageProfiles)
                        : Container(),
                    SonarrSeriesEditSeriesTypeTile(),
                    SonarrSeriesEditUpdateSeriesButton(series: series),
                ],
            );
        },
    );

    Widget get _unknown => LSGenericMessage(text: 'Series Not Found');
}
