import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrSeasonDetailsRouter extends SonarrPageRouter {
  SonarrSeasonDetailsRouter()
      : super('/sonarr/series/details/:seriesid/season/:seasonnumber');

  @override
  _Widget widget({
    @required int seriesId,
    @required int seasonNumber,
  }) =>
      _Widget(seriesId: seriesId, seasonNumber: seasonNumber);

  @override
  Future<void> navigateTo(
    BuildContext context, {
    @required int seriesId,
    @required int seasonNumber,
  }) async =>
      LunaRouter.router.navigateTo(
          context, route(seriesId: seriesId, seasonNumber: seasonNumber));

  @override
  String route({
    @required int seriesId,
    @required int seasonNumber,
  }) =>
      fullRoute
          .replaceFirst(':seriesid', seriesId.toString())
          .replaceFirst(':seasonnumber', seasonNumber.toString());

  @override
  void defineRoute(FluroRouter router) =>
      super.withParameterRouteDefinition(router, (context, params) {
        int seriesId = (params['seriesid']?.isNotEmpty ?? false)
            ? (int.tryParse(params['seriesid'][0]) ?? -1)
            : -1;
        int seasonNumber = (params['seasonnumber']?.isNotEmpty ?? false)
            ? (int.tryParse(params['seasonnumber'][0]) ?? -1)
            : -1;
        return _Widget(seriesId: seriesId, seasonNumber: seasonNumber);
      });
}

class _Widget extends StatefulWidget {
  final int seriesId;
  final int seasonNumber;

  const _Widget({
    Key key,
    @required this.seriesId,
    @required this.seasonNumber,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<_Widget> with LunaScrollControllerMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.scheduleFrameCallback((_) {
      context.read<SonarrState>().selectedEpisodes = [];
      _refresh();
    });
  }

  Future<void> _refresh() async {
    if (widget.seriesId > 0) {
      if (context.read<SonarrState>().api != null)
        context.read<SonarrState>().fetchEpisodes(widget.seriesId);
      if (context.read<SonarrState>().episodes[widget.seriesId] != null)
        await context.read<SonarrState>().episodes[widget.seriesId];
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.seriesId <= 0)
      return LunaInvalidRoute(
          title: 'Season Details', message: 'Series Not Found');
    return LunaScaffold(
      scaffoldKey: _scaffoldKey,
      appBar: _appBar(),
      body: _body(),
      floatingActionButton: _floatingActionButton(),
    );
  }

  Widget _appBar() {
    return LunaAppBar(
      title: 'Season Details',
      scrollControllers: [scrollController],
    );
  }

  Widget _floatingActionButton() {
    int _episodes = context.watch<SonarrState>().selectedEpisodes?.length ?? 0;
    if (_episodes == 0) return null;
    return LunaFloatingActionButtonExtended(
      label: _episodes == 1 ? '1 Episode' : '$_episodes Episodes',
      icon: Icons.search,
      onPressed: _searchSelected,
    );
  }

  Widget _body() {
    return LunaRefreshIndicator(
      context: context,
      key: _refreshKey,
      onRefresh: _refresh,
      child: FutureBuilder(
        future: context.watch<SonarrState>().episodes[widget.seriesId],
        builder: (context, AsyncSnapshot<List<SonarrEpisode>> snapshot) {
          if (snapshot.hasError)
            return LunaMessage.error(onTap: _refreshKey.currentState?.show);
          if (snapshot.hasData) {
            if (widget.seasonNumber == -1)
              return SonarrSeasonDetailsAllSeasons(
                episodes: snapshot.data,
                seriesId: widget.seriesId,
                scrollController: scrollController,
              );
            List<SonarrEpisode> _episodes = snapshot.data
                .where(
                  (episode) => episode.seasonNumber == widget.seasonNumber,
                )
                .toList();
            if (_episodes?.isNotEmpty ?? false) {
              _episodes.sort((a, b) =>
                  (b.episodeNumber ?? 0).compareTo(a.episodeNumber ?? 0));
              return SonarrSeasonDetailsSeason(
                episodes: _episodes,
                seriesId: widget.seriesId,
                seasonNumber: widget.seasonNumber,
                scrollController: scrollController,
              );
            }
            return _unknown();
          }
          return const LunaLoader();
        },
      ),
    );
  }

  Widget _unknown() {
    return LunaMessage(text: 'No Episodes Found');
  }

  Future<void> _searchSelected() async {
    if (context.read<SonarrState>().api != null)
      context
          .read<SonarrState>()
          .api
          .command
          .episodeSearch(
            episodeIds: context.read<SonarrState>().selectedEpisodes,
          )
          .then((_) {
        showLunaSuccessSnackBar(
          title: 'Searching for Episodes...',
          message: context.read<SonarrState>().selectedEpisodes.length == 1
              ? '1 Episode'
              : '${context.read<SonarrState>().selectedEpisodes.length} Episodes',
        );
        context.read<SonarrState>().selectedEpisodes = [];
      }).catchError((error, stack) {
        LunaLogger().error(
            'Failed to search for episodes: ${context.read<SonarrState>().selectedEpisodes.join(', ')}',
            error,
            stack);
        showLunaErrorSnackBar(
            title: 'Failed to Search For Episodes', error: error);
      });
  }
}
