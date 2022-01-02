import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrReleasesRouter extends SonarrPageRouter {
  SonarrReleasesRouter() : super('/sonarr/releases');

  @override
  Widget widget({
    int? episodeId,
    int? seriesId,
    int? seasonNumber,
  }) =>
      _Widget(
        episodeId: episodeId,
        seriesId: seriesId,
        seasonNumber: seasonNumber,
      );

  @override
  Future<void> navigateTo(
    BuildContext context, {
    int? episodeId,
    int? seriesId,
    int? seasonNumber,
  }) async =>
      LunaRouter.router.navigateTo(
        context,
        route(
          episodeId: episodeId,
          seriesId: seriesId,
          seasonNumber: seasonNumber,
        ),
      );

  @override
  String route({
    int? episodeId,
    int? seriesId,
    int? seasonNumber,
  }) {
    if (episodeId != null) {
      return '$fullRoute/episode/$episodeId';
    } else if (seriesId != null && seasonNumber != null) {
      return '$fullRoute/series/$seriesId/season/$seasonNumber';
    } else {
      throw Exception('episodeId or seriesId must be passed to this route');
    }
  }

  @override
  void defineRoute(FluroRouter router) {
    router.define(
      '$fullRoute/episode/:episodeid',
      handler: Handler(
        handlerFunc: (context, params) {
          if (!context!.read<SonarrState>().enabled) {
            return LunaNotEnabledRoute(module: LunaModule.SONARR.name);
          }
          int episodeId = int.tryParse(params['episodeid']![0]) ?? -1;
          return _Widget(
            episodeId: episodeId,
          );
        },
      ),
      transitionType: LunaRouter.transitionType,
    );
    router.define(
      '$fullRoute/series/:seriesid/season/:seasonnumber',
      handler: Handler(
        handlerFunc: (context, params) {
          if (!context!.read<SonarrState>().enabled) {
            return LunaNotEnabledRoute(module: LunaModule.SONARR.name);
          }
          int seriesId = int.tryParse(params['seriesid']![0]) ?? -1;
          int seasonNumber = int.tryParse(params['seasonnumber']![0]) ?? -1;
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
  final int? episodeId;
  final int? seriesId;
  final int? seasonNumber;

  const _Widget({
    Key? key,
    this.episodeId,
    this.seriesId,
    this.seasonNumber,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<_Widget> with LunaScrollControllerMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SonarrReleasesState(
        context: context,
        episodeId: widget.episodeId,
        seriesId: widget.seriesId,
        seasonNumber: widget.seasonNumber,
      ),
      builder: (context, _) => LunaScaffold(
        scaffoldKey: _scaffoldKey,
        appBar: _appBar(context) as PreferredSizeWidget?,
        body: _body(context),
      ),
    );
  }

  Widget _appBar(BuildContext context) {
    return LunaAppBar(
      title: 'sonarr.Releases'.tr(),
      scrollControllers: [scrollController],
      bottom: SonarrReleasesSearchBar(scrollController: scrollController),
    );
  }

  Widget _body(BuildContext context) {
    return LunaRefreshIndicator(
      context: context,
      key: _refreshKey,
      onRefresh: () async {
        context.read<SonarrReleasesState>().refreshReleases(context);
        await context.read<SonarrReleasesState>().releases;
      },
      child: FutureBuilder(
        future: context.read<SonarrReleasesState>().releases,
        builder: (context, AsyncSnapshot<List<SonarrRelease>> snapshot) {
          if (snapshot.hasError) {
            if (snapshot.connectionState != ConnectionState.waiting) {
              LunaLogger().error(
                'Unable to fetch Sonarr releases',
                snapshot.error,
                snapshot.stackTrace,
              );
            }
            return LunaMessage.error(
              onTap: () => _refreshKey.currentState!.show,
            );
          }
          if (snapshot.hasData) return _list(context, snapshot.data);
          return const LunaLoader();
        },
      ),
    );
  }

  Widget _list(BuildContext context, List<SonarrRelease>? releases) {
    return Consumer<SonarrReleasesState>(
      builder: (context, state, _) {
        if (releases?.isEmpty ?? true) {
          return LunaMessage(
            text: 'sonarr.NoReleasesFound'.tr(),
            buttonText: 'lunasea.Refresh'.tr(),
            onTap: _refreshKey.currentState!.show,
          );
        }
        List<SonarrRelease> _processed = _filterAndSortReleases(
          releases ?? [],
          state,
        );
        return LunaListViewBuilder(
          controller: scrollController,
          itemCount: _processed.isEmpty ? 1 : _processed.length,
          itemBuilder: (context, index) {
            if (_processed.isEmpty) {
              return LunaMessage.inList(text: 'sonarr.NoReleasesFound'.tr());
            }
            return SonarrReleasesTile(release: _processed[index]);
          },
        );
      },
    );
  }

  List<SonarrRelease> _filterAndSortReleases(
    List<SonarrRelease> releases,
    SonarrReleasesState state,
  ) {
    if (releases.isEmpty) return releases;
    List<SonarrRelease> filtered = releases.where(
      (release) {
        String _query = state.searchQuery;
        if (_query.isNotEmpty) {
          return release.title!.toLowerCase().contains(_query.toLowerCase());
        }
        return true;
      },
    ).toList();
    filtered = state.filterType.filter(filtered);
    filtered = state.sortType.sort(filtered, state.sortAscending);
    return filtered;
  }
}
