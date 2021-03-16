import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrSeasonDetailsRouter extends SonarrPageRouter {
    SonarrSeasonDetailsRouter() : super('/sonarr/series/details/:seriesid/season/:seasonnumber');

    @override
    Future<void> navigateTo(BuildContext context, {
        @required int seriesId,
        @required int seasonNumber,
    }) async => LunaRouter.router.navigateTo(context, route(seriesId: seriesId, seasonNumber: seasonNumber));

    @override
    String route({
        @required int seriesId,
        @required int seasonNumber,
    }) => fullRoute.replaceFirst(':seriesid', seriesId.toString()).replaceFirst(':seasonnumber', seasonNumber.toString());

    @override
    void defineRoute(FluroRouter router) => super.withParameterRouteDefinition(router, (context, params) {
        int seriesId = params['seriesid'] == null || params['seriesid'].length == 0 ? -1 : (int.tryParse(params['seriesid'][0]) ?? -1);
        int seasonNumber = params['seasonnumber'] == null || params['seasonnumber'].length == 0 ? -1 : (int.tryParse(params['seasonnumber'][0]) ?? -1); 
        return _SonarrSeasonDetailsRoute(seriesId: seriesId, seasonNumber: seasonNumber);
    });
}

class _SonarrSeasonDetailsRoute extends StatefulWidget {
    final int seriesId;
    final int seasonNumber;

    _SonarrSeasonDetailsRoute({
        Key key,
        @required this.seriesId,
        @required this.seasonNumber,
    }) : super(key: key);

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<_SonarrSeasonDetailsRoute> {
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
        if(widget.seriesId > 0) {
            if(context.read<SonarrState>().api != null)
                context.read<SonarrState>().fetchEpisodes(widget.seriesId);
            if(context.read<SonarrState>().episodes[widget.seriesId] != null)
                await context.read<SonarrState>().episodes[widget.seriesId];
        }
    }

    @override
    Widget build(BuildContext context) {
        if(widget.seriesId <= 0) return LunaInvalidRoute(title: 'Season Details', message: 'Series Not Found');
        return Scaffold(
            key: _scaffoldKey,
            appBar: _appBar,
            body: _body,
            floatingActionButton: _floatingActionButton,
        );
    }

    Widget get _appBar =>  LunaAppBar(title: 'Season Details');

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
                    if(widget.seasonNumber == -1) return SonarrSeasonDetailsAllSeasons(
                        episodes: snapshot.data,
                        seriesId: widget.seriesId,
                    );
                    List<SonarrEpisode> _episodes = snapshot.data.where(
                        (episode) => episode.seasonNumber == widget.seasonNumber,
                    ).toList();
                    if(_episodes != null && _episodes.length > 0) {
                        _episodes.sort((a,b) => (b.episodeNumber ?? 0).compareTo(a.episodeNumber ?? 0));
                        return SonarrSeasonDetailsSeason(
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
            LunaLogger().error('Failed to search for episodes: ${context.read<SonarrState>().selectedEpisodes.join(', ')}', error, stack);
            LSSnackBar(
                context: context,
                title: 'Failed to Search For Episodes',
                type: SNACKBAR_TYPE.failure,
            );
        });
    }
}
