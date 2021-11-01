import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrReleasesRouter extends SonarrPageRouter {
  SonarrReleasesRouter() : super('/sonarr/releases');

  @override
  Widget widget({
    int episodeId,
    int seriesId,
    int seasonNumber,
  }) =>
      _Widget(
        episodeId: episodeId,
        seriesId: seriesId,
        seasonNumber: seasonNumber,
      );

  @override
  Future<void> navigateTo(
    BuildContext context, {
    int episodeId,
    int seriesId,
    int seasonNumber,
  }) async =>
      LunaRouter.router.navigateTo(
        context,
        route(
            episodeId: episodeId,
            seriesId: seriesId,
            seasonNumber: seasonNumber),
      );

  @override
  String route({
    int episodeId,
    int seriesId,
    int seasonNumber,
  }) {
    if (episodeId != null) return '$fullRoute/episode/$episodeId';
    if (seriesId != null && seasonNumber != null)
      return '$fullRoute/series/$seriesId/season/$seasonNumber';
    return SonarrHomeRouter().route();
  }

  @override
  void defineRoute(FluroRouter router) {
    router.define(
      '$fullRoute/episode/:episodeid',
      handler: Handler(
        handlerFunc: (context, params) {
          if (!context.read<SonarrState>().enabled) {
            return LunaNotEnabledRoute(module: 'Sonarr');
          }
          int episodeId = (params['episodeid']?.isNotEmpty ?? false)
              ? (int.tryParse(params['episodeid'][0]) ?? -1)
              : -1;
          return _Widget(episodeId: episodeId);
        },
      ),
      transitionType: LunaRouter.transitionType,
    );
    router.define(
      '$fullRoute/series/:seriesid/season/:seasonnumber',
      handler: Handler(
        handlerFunc: (context, params) {
          if (!context.read<SonarrState>().enabled)
            return LunaNotEnabledRoute(module: 'Sonarr');
          int seriesId = (params['seriesid']?.isNotEmpty ?? false)
              ? (int.tryParse(params['seriesid'][0]) ?? -1)
              : -1;
          int seasonNumber = (params['seasonnumber']?.isNotEmpty ?? false)
              ? (int.tryParse(params['seasonnumber'][0]) ?? -1)
              : -1;
          return _Widget(
            seriesId: seriesId,
            seasonNumber: seasonNumber,
          );
        },
      ),
      transitionType: LunaRouter.transitionType,
    );
  }
}

class _Widget extends StatefulWidget {
  final int episodeId;
  final int seriesId;
  final int seasonNumber;

  const _Widget({
    Key key,
    this.episodeId,
    this.seriesId,
    this.seasonNumber,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<_Widget>
    with LunaLoadCallbackMixin, LunaScrollControllerMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();
  Future<List<SonarrRelease>> _future;

  @override
  Future<void> loadCallback() async {
    if (context.read<SonarrState>().api != null && mounted)
      setState(() {
        if (widget.episodeId != null) {
          _future = context
              .read<SonarrState>()
              .api
              .release
              .getReleases(episodeId: widget.episodeId);
        } else if (widget.seriesId != null && widget.seasonNumber != null) {
          _future = context
              .read<SonarrState>()
              .api
              .release
              .getSeasonReleases(
                  seriesId: widget.seriesId, seasonNumber: widget.seasonNumber)
              .then((data) =>
                  data = data.where((release) => release.fullSeason).toList());
        } else {
          LunaLogger().warning(
            '_Widget',
            '_refresh',
            'No valid episodeId or (seriesId & seasonNumber) found',
          );
        }
      });
    if (_future != null) await _future;
  }

  @override
  Widget build(BuildContext context) => LunaScaffold(
        scaffoldKey: _scaffoldKey,
        appBar: _appBar(),
        body: _body(),
      );

  Widget _appBar() {
    return SonarrReleasesAppBar(scrollController: scrollController);
  }

  Widget _body() {
    return LunaRefreshIndicator(
      context: context,
      key: _refreshKey,
      onRefresh: loadCallback,
      child: FutureBuilder(
        future: _future,
        builder: (context, AsyncSnapshot<List<SonarrRelease>> snapshot) {
          if (snapshot.hasError) {
            if (snapshot.connectionState != ConnectionState.waiting) {
              LunaLogger().error(
                  'Unable to fetch Sonarr releases: ${widget.episodeId}',
                  snapshot.error,
                  snapshot.stackTrace);
            }
            return LunaMessage.error(onTap: _refreshKey.currentState?.show);
          }
          if (snapshot.hasData) return _releases(snapshot.data);
          return const LunaLoader();
        },
      ),
    );
  }

  Widget _releases(List<SonarrRelease> releases) {
    if ((releases?.length ?? 0) == 0)
      return LunaMessage(
        text: 'No Releases Found',
        buttonText: 'Refresh',
        onTap: _refreshKey.currentState?.show,
      );
    return Consumer<SonarrState>(builder: (context, state, _) {
      List<SonarrRelease> _filtered = _filterAndSort(releases);
      if ((_filtered?.length ?? 0) == 0)
        return LunaListView(
          controller: scrollController,
          children: [
            LunaMessage.inList(text: 'No Releases Found'),
          ],
        );
      return LunaListViewBuilder(
        controller: scrollController,
        itemCount: _filtered.length,
        itemBuilder: (context, index) => SonarrReleasesReleaseTile(
          key: ObjectKey(_filtered[index].guid),
          release: _filtered[index],
          isSeasonRelease: widget.episodeId == null,
        ),
      );
    });
  }

  List<SonarrRelease> _filterAndSort(List<SonarrRelease> releases) {
    if (releases?.isEmpty ?? true) return releases;
    List<SonarrRelease> _filtered = List<SonarrRelease>.from(releases);
    SonarrState _state = context.read<SonarrState>();
    // Filter
    _filtered = _filtered.where((release) {
      if (_state.releasesSearchQuery != null &&
          _state.releasesSearchQuery.isNotEmpty)
        return release.title
            .toLowerCase()
            .contains(_state.releasesSearchQuery.toLowerCase());
      return release != null;
    }).toList();
    _filtered = _state.releasesFilterType.filter(_filtered);
    // Sort
    _filtered =
        _state.releasesSortType.sort(_filtered, _state.releasesSortAscending);
    return _filtered;
  }
}
