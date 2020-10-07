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
    }) async => SonarrRouter.router.navigateTo(
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
            context.read<SonarrLocalState>().selectedEpisodes = [];
            _refresh();
        });
    }

    Future<void> _refresh() async {
        if(context.read<SonarrState>().api != null)
            context.read<SonarrLocalState>().fetchEpisodes(context, widget.seriesId);
        if(context.read<SonarrLocalState>().episodes[widget.seriesId] != null)
            await context.read<SonarrLocalState>().episodes[widget.seriesId];
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
        title: widget.seasonNumber == -1
            ? 'All Seasons'
            : widget.seasonNumber == 0
                ? 'Specials'
                : 'Season ${widget.seasonNumber}',
        popUntil: '/sonarr',
    );

    Widget get _floatingActionButton => context.watch<SonarrLocalState>().selectedEpisodes.length == 0
        ? null
        : LSFloatingActionButtonExtended(
            label: context.watch<SonarrLocalState>().selectedEpisodes.length == 1
                ? '1 Episode'
                : '${context.watch<SonarrLocalState>().selectedEpisodes.length} Episodes',
            icon: Icons.search,
            onPressed: () => _searchSelected(),
        );

    Widget get _body => LSRefreshIndicator(
        refreshKey: _refreshKey,
        onRefresh: _refresh,
        child: FutureBuilder(
            future: context.watch<SonarrLocalState>().episodes[widget.seriesId],
            builder: (context, AsyncSnapshot<List<SonarrEpisode>> snapshot) {
                if(snapshot.hasError) return LSErrorMessage(onTapHandler: () => _refresh());
                if(snapshot.hasData) {
                    if(widget.seasonNumber == -1) return SonarrSeriesSeasonDetailsAllSeasons(episodes: snapshot.data);
                    List<SonarrEpisode> _episodes = snapshot.data.where(
                        (episode) => episode.seasonNumber == widget.seasonNumber,
                    ).toList();
                    if(_episodes != null && _episodes.length > 0) {
                        _episodes.sort((a,b) => (b.episodeNumber ?? 0).compareTo(a.episodeNumber ?? 0));
                        return SonarrSeriesSeasonDetailsSeason(episodes: _episodes, seasonNumber: widget.seasonNumber);
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
            episodeIds: context.read<SonarrLocalState>().selectedEpisodes,
        ).then((_) {
            LSSnackBar(
                context: context,
                title: 'Searching for Episodes...',
                message: context.read<SonarrLocalState>().selectedEpisodes.length == 1
                    ? '1 Episode'
                    : '${context.read<SonarrLocalState>().selectedEpisodes.length} Episodes',
                type: SNACKBAR_TYPE.success,
            );
            context.read<SonarrLocalState>().selectedEpisodes = [];
        })
        .catchError((error, stack) {
            LunaLogger.error(
                '',
                '_searchSelected',
                'Failed to search for episodes: ${context.read<SonarrLocalState>().selectedEpisodes.join(', ')}',
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
