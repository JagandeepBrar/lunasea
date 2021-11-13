import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return LunaScaffold(
      scaffoldKey: _scaffoldKey,
      appBar: _appBar(),
    );
  }

  Widget _appBar() {
    return LunaAppBar(
      title: 'sonarr.SeasonDetails'.tr(),
      scrollControllers: [scrollController],
    );
  }
}
