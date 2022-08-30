import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SeriesSeasonDetailsRoute extends StatefulWidget {
  final int seriesId;
  final int seasonNumber;

  const SeriesSeasonDetailsRoute({
    Key? key,
    required this.seriesId,
    required this.seasonNumber,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<SeriesSeasonDetailsRoute>
    with LunaScrollControllerMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  PageController? _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: SonarrDatabase.NAVIGATION_INDEX_SEASON_DETAILS.read(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LunaScaffold(
      scaffoldKey: _scaffoldKey,
      appBar: _appBar() as PreferredSizeWidget?,
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
        _season =
            'sonarr.SeasonNumber'.tr(args: [widget.seasonNumber.toString()]);
        break;
    }
    return LunaAppBar(
      title: _season,
      scrollControllers: SonarrSeasonDetailsNavigationBar.scrollControllers,
      pageController: _pageController,
    );
  }

  Widget? _bottomNavigationBar() {
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
        return LunaPageView(
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
