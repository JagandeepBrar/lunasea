import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';
import 'package:tuple/tuple.dart';

class SonarrSeriesDetailsRouter {
    static const String ROUTE_NAME = '/sonarr/series/details/:seriesid';

    static Future<void> navigateTo(BuildContext context, {
        @required int seriesId,
    }) async => LunaRouter.router.navigateTo(
        context,
        route(seriesId: seriesId),
    );

    static String route({ @required int seriesId }) => ROUTE_NAME
        .replaceFirst(':seriesid', seriesId?.toString() ?? '-1');

    static void defineRoutes(FluroRouter router) {
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

    List<SonarrTag> _findTags(List<int> tagIds, List<SonarrTag> tags) {
        return tags.where((tag) => tagIds.contains(tag.id)).toList();
    }

    SonarrQualityProfile _findQualityProfile(int profileId, List<SonarrQualityProfile> profiles) {
        return profiles.firstWhere(
            (profile) => profile.id == profileId,
            orElse: () => null,
        );
    }

    SonarrLanguageProfile _findLanguageProfile(int languageProfileId, List<SonarrLanguageProfile> profiles) {
        if(!Provider.of<SonarrState>(context, listen: false).enableVersion3) return null;
        return profiles.firstWhere(
            (profile) => profile.id == languageProfileId,
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

    Widget get _body => Selector<SonarrState, Tuple5<
        Future<List<SonarrSeries>>,
        Future<List<SonarrTag>>,
        Future<List<SonarrQualityProfile>>,
        Future<List<SonarrLanguageProfile>>,
        bool
    >>(
        selector: (_, state) => Tuple5(
            state.series,
            state.tags,
            state.qualityProfiles,
            state.languageProfiles,
            state.enableVersion3,
        ),
        builder: (context, tuple, _) => FutureBuilder(
            future: Future.wait([
                tuple.item1,
                tuple.item2,
                tuple.item3,
                if(tuple.item5) tuple.item4,
            ]),
            builder: (context, AsyncSnapshot<List<Object>> snapshot) {
                if(snapshot.hasError) {
                    if(snapshot.connectionState != ConnectionState.waiting) {
                        LunaLogger.error(
                            '_SonarrSeriesDetailsRoute',
                            '_body',
                            'Unable to pull Sonarr series details',
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
                        SonarrQualityProfile quality = _findQualityProfile(series.profileId, snapshot.data[2]);
                        SonarrLanguageProfile language = Provider.of<SonarrState>(context, listen: false).enableVersion3
                            ? _findLanguageProfile(series.languageProfileId, snapshot.data[3])
                            : null;
                        List<SonarrTag> tags = _findTags(series.tags, snapshot.data[1]);
                        return series == null
                            ? _unknown
                            : PageView(
                                controller: _pageController,
                                children: _tabs(
                                    series: series,
                                    quality: quality,
                                    language: language,
                                    tags: tags,
                                ),
                            );
                    }
                }
                return LSLoader();
            },
        ),
    );

    List<Widget> _tabs({
        @required SonarrSeries series,
        @required SonarrQualityProfile quality,
        @required SonarrLanguageProfile language,
        @required List<SonarrTag> tags,
    }) => [
        SonarrSeriesDetailsOverview(series: series, quality: quality, language: language, tags: tags),
        SonarrSeriesDetailsSeasonList(series: series),
    ];

    Widget get _unknown => LSGenericMessage(text: 'Series Not Found');
}
