import 'package:fluro_fork/fluro_fork.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';
import 'package:tuple/tuple.dart';

class SonarrSeriesDetailsRouter {
    static const String ROUTE_NAME = '/sonarr/series/details/:seriesid';

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
            handler: Handler(handlerFunc: (context, params) => _SonarrSeriesDetailsRoute(
                seriesId: int.tryParse(params['seriesid'][0]) ?? -1,
            )),
            transitionType: LunaRouter.transitionType,
        );
    }
}

class _SonarrSeriesDetailsRoute extends StatefulWidget {
    final int seriesId;

    _SonarrSeriesDetailsRoute({
        Key key,
        @required this.seriesId,
    }): super(key: key);

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<_SonarrSeriesDetailsRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    PageController _pageController;

    @override
    void initState() {
        super.initState();
        _pageController = PageController(initialPage: SonarrDatabaseValue.NAVIGATION_INDEX_SERIES_DETAILS.data);
        SchedulerBinding.instance.scheduleFrameCallback((_) => _refresh());
    }

    Future<void> _refresh() async {
        SonarrState _state = Provider.of<SonarrState>(context, listen: false);
        SonarrSeries _series = await _state.api.series.getSeries(seriesId: widget.seriesId);
        List<SonarrSeries> allSeries = await _state.series;
        int _index = allSeries?.indexWhere((element) => element.id == widget.seriesId) ?? -1;
        if(_index >= 0) allSeries[_index] = _series;
        _state.notify();
        if(mounted) setState(() {});
    }

    SonarrSeries _findSeries(List<SonarrSeries> series) {
        return series.firstWhere(
            (series) => series.id == widget.seriesId,
            orElse: () => null,
        );
    }

    SonarrQualityProfile _findProfile(int profileId, List<SonarrQualityProfile> profiles) {
        return profiles.firstWhere(
            (profile) => profile.id == profileId,
            orElse: () => null,
        );
    }

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        bottomNavigationBar: _bottomNavigationBar,
        body: _body,
    );

    Widget get _appBar => LunaAppBar(
        context: context,
        title: 'Series Details',
        popUntil: '/sonarr',
        actions: [
            SonarrAppBarSeriesSettingsAction(seriesId: widget.seriesId),
        ],
    );

    Widget get _bottomNavigationBar => SonarrSeriesDetailsNavigationBar(pageController: _pageController);

    Widget get _body => Selector<SonarrState, Tuple2<Future<List<SonarrSeries>>, Future<List<SonarrQualityProfile>>>>(
        selector: (_, state) => Tuple2(state.series, state.qualityProfiles),
        builder: (context, tuple, _) => FutureBuilder(
            future: Future.wait([
                tuple.item1,
                tuple.item2,
            ]),
            builder: (context, AsyncSnapshot<List<Object>> snapshot) {
                if(snapshot.hasError) {
                    if(snapshot.connectionState != ConnectionState.waiting) {
                        LunaLogger.error(
                            '_TautulliUserDetailsRoute',
                            '_body',
                            'Unable to pull Tautulli user table',
                            snapshot.error,
                            null,
                            uploadToSentry: !(snapshot.error is DioError),
                        );
                    }
                    return LSErrorMessage(onTapHandler: () => _refresh());
                }
                if(snapshot.hasData) {
                    SonarrSeries series = _findSeries(snapshot.data[0]);
                    if(series != null) {
                        SonarrQualityProfile profile = _findProfile(series.profileId, snapshot.data[1]);
                        return series == null
                            ? _unknown
                            : PageView(
                                controller: _pageController,
                                children: _tabs(series, profile),
                            );
                    }
                }
                return LSLoader();
            },
        ),
    );

    List<Widget> _tabs(SonarrSeries series, SonarrQualityProfile profile) => [
        SonarrSeriesDetailsOverview(series: series, profile: profile),
        SonarrSeriesDetailsSeasonList(series: series),
    ];

    Widget get _unknown => LSGenericMessage(text: 'Series Not Found');
}
