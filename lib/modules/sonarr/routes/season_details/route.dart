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
  }) {
    return _Widget(
      seriesId: seriesId,
      seasonNumber: seasonNumber,
    );
  }

  @override
  Future<void> navigateTo(
    BuildContext context, {
    @required int seriesId,
    @required int seasonNumber,
  }) async {
    LunaRouter.router.navigateTo(
      context,
      route(seriesId: seriesId, seasonNumber: seasonNumber),
    );
  }

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

class _State extends State<_Widget>
    with LunaScrollControllerMixin, LunaLoadCallbackMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: SonarrDatabaseValue.NAVIGATION_INDEX_SEASON_DETAILS.data,
    );
  }

  @override
  Future<void> loadCallback() async {
    context.read<SonarrState>().fetchEpisodeFiles(widget.seriesId);
  }

  @override
  Widget build(BuildContext context) {
    return LunaScaffold(
      scaffoldKey: _scaffoldKey,
      appBar: _appBar(),
      bottomNavigationBar:
          context.watch<SonarrState>().enabled ? _bottomNavigationBar() : null,
      body: _body(),
    );
  }

  Widget _appBar() {
    String _season;
    switch (widget.seasonNumber) {
      case -1:
        _season = 'sonarr.AllSeasons'.tr();
        break;
      case 0:
        _season = 'sonarr.Specials'.tr();
        break;
      default:
        _season = 'sonarr.SeasonNumber'.tr(
            args: [widget.seasonNumber?.toString() ?? 'lunasea.Unknown'.tr()]);
        break;
    }
    return LunaAppBar(
      title: _season,
      scrollControllers: SonarrSeasonDetailsNavigationBar.scrollControllers,
      pageController: _pageController,
    );
  }

  Widget _bottomNavigationBar() {
    if (widget.seasonNumber < 0) return null;
    return SonarrSeasonDetailsNavigationBar(
      pageController: _pageController,
      seriesId: widget.seriesId,
      seasonNumber: widget.seasonNumber,
    );
  }

  Widget _body() {
    return ChangeNotifierProvider(
      create: (context) => SonarrSeasonDetailsState(
        context: context,
        seriesId: widget.seriesId,
        seasonNumber: widget.seasonNumber != -1 ? widget.seasonNumber : null,
      ),
      builder: (context, _) {
        return PageView(
          controller: _pageController,
          children: [
            const SonarrSeasonDetailsEpisodesPage(),
            if (widget.seasonNumber >= 0)
              const SonarrSeasonDetailsHistoryPage(),
          ],
        );
      },
    );
  }
}
