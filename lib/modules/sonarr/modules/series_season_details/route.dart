import 'package:fluro_fork/fluro_fork.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrSeriesSeasonDetailsRouter {
    static const String ROUTE_NAME = '/sonarr/series/details/:seriesid/season/:seasonnumber';

    static Future<void> navigateTo(BuildContext context, {
        @required int seriesId,
        @required int seasonNumber,
    }) async => LunaRouter.router.navigateTo(
        context,
        route(seriesId: seriesId, seasonNumber: seasonNumber),
    );

    static String route({
        @required int seriesId,
        @required int seasonNumber,
    }) => ROUTE_NAME
        .replaceFirst(':seriesid', seriesId.toString())
        .replaceFirst(':seasonnumber', seasonNumber.toString());

    static void defineRoutes(Router router) {
        router.define(
            ROUTE_NAME,
            handler: Handler(handlerFunc: (context, params) => _SonarrSeriesSeasonDetailsRoute(
                seriesId: int.tryParse(params['seriesid'][0]) ?? -1,
                seasonNumber: int.tryParse(params['seasonnumber'][0]) ?? -1,
            )),
            transitionType: LunaRouter.transitionType,
        );
    }
}

class _SonarrSeriesSeasonDetailsRoute extends StatefulWidget {
    final int seriesId;
    final int seasonNumber;

    _SonarrSeriesSeasonDetailsRoute({
        Key key,
        @required this.seriesId,
        @required this.seasonNumber,
    }) : super(key: key);

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<_SonarrSeriesSeasonDetailsRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey<RefreshIndicatorState>();

    @override
    void initState() {
        super.initState();
        SchedulerBinding.instance.scheduleFrameCallback((_) {
            context.read<SonarrState>().selectedEpisodes = [];
            _refresh();
        });
    }

    Future<void> _refresh() async {
        if(context.read<SonarrState>().api != null)
            context.read<SonarrState>().fetchEpisodes(context, widget.seriesId);
        if(context.read<SonarrState>().episodes[widget.seriesId] != null)
            await context.read<SonarrState>().episodes[widget.seriesId];
    }

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        body: _body,
        floatingActionButton: _floatingActionButton,
    );

    Widget get _appBar =>  LunaAppBar(
        context: context,
        title: 'Season Details',
        popUntil: '/sonarr',
    );

    Widget get _floatingActionButton => context.watch<SonarrState>().selectedEpisodes.length == 0
        ? null
        : LSFloatingActionButtonExtended(
            label: context.watch<SonarrState>().selectedEpisodes.length == 1
                ? '1 Episode'
                : '${context.watch<SonarrState>().selectedEpisodes.length} Episodes',
            icon: Icons.search,
            onPressed: () => _searchSelected(),
        );

    Widget get _body => LSRefreshIndicator(
        refreshKey: _refreshKey,
        onRefresh: _refresh,
        child: FutureBuilder(
            future: context.watch<SonarrState>().episodes[widget.seriesId],
            builder: (context, AsyncSnapshot<List<SonarrEpisode>> snapshot) {
                if(snapshot.hasError) return LSErrorMessage(onTapHandler: () => _refresh());
                if(snapshot.hasData) {
                    if(widget.seasonNumber == -1) return SonarrSeriesSeasonDetailsAllSeasons(
                        episodes: snapshot.data,
                        seriesId: widget.seriesId,
                    );
                    List<SonarrEpisode> _episodes = snapshot.data.where(
                        (episode) => episode.seasonNumber == widget.seasonNumber,
                    ).toList();
                    if(_episodes != null && _episodes.length > 0) {
                        _episodes.sort((a,b) => (b.episodeNumber ?? 0).compareTo(a.episodeNumber ?? 0));
                        return SonarrSeriesSeasonDetailsSeason(
                            episodes: _episodes,
                            seriesId: widget.seriesId,
                            seasonNumber: widget.seasonNumber,
                        );
                    }
                    return _unknown;
                }
                return LSLoader();
            },
        ),
    );

    Widget get _unknown => LSGenericMessage(text: 'No Episodes Found');

    Future<void> _searchSelected() async {
        if(context.read<SonarrState>().api != null) context.read<SonarrState>().api.command.episodeSearch(
            episodeIds: context.read<SonarrState>().selectedEpisodes,
        ).then((_) {
            LSSnackBar(
                context: context,
                title: 'Searching for Episodes...',
                message: context.read<SonarrState>().selectedEpisodes.length == 1
                    ? '1 Episode'
                    : '${context.read<SonarrState>().selectedEpisodes.length} Episodes',
                type: SNACKBAR_TYPE.success,
            );
            context.read<SonarrState>().selectedEpisodes = [];
        })
        .catchError((error, stack) {
            LunaLogger.error(
                '',
                '_searchSelected',
                'Failed to search for episodes: ${context.read<SonarrState>().selectedEpisodes.join(', ')}',
                error,
                stack,
                uploadToSentry: !(error is DioError),
            );
            LSSnackBar(
                context: context,
                title: 'Failed to Search For Episodes',
                type: SNACKBAR_TYPE.failure,
            );
        });
    }
}
