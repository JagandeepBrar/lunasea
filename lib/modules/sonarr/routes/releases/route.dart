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
          seasonNumber: seasonNumber,
        ),
      );

  @override
  String route({
    int episodeId,
    int seriesId,
    int seasonNumber,
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
          if (!context.read<SonarrState>().enabled) {
            return LunaNotEnabledRoute(module: LunaModule.SONARR.name);
          }
          int episodeId = int.tryParse(params['episodeid'][0]) ?? -1;
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
          if (!context.read<SonarrState>().enabled) {
            return LunaNotEnabledRoute(module: LunaModule.SONARR.name);
          }
          int seriesId = int.tryParse(params['seriesid'][0]) ?? -1;
          int seasonNumber = int.tryParse(params['seasonnumber'][0]) ?? -1;
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

class _State extends State<_Widget> with LunaScrollControllerMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return LunaScaffold(
      scaffoldKey: _scaffoldKey,
      appBar: LunaAppBar(title: 'Releases'),
    );
  }
}
