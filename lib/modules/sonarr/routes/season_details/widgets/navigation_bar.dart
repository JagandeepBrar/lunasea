import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';
import 'package:lunasea/router/routes/sonarr.dart';

class SonarrSeasonDetailsNavigationBar extends StatefulWidget {
  static const List<IconData> icons = [
    Icons.live_tv_rounded,
    Icons.history_rounded,
  ];

  static final List<String> titles = [
    'sonarr.Episodes'.tr(),
    'sonarr.History'.tr(),
  ];

  static List<ScrollController> scrollControllers =
      List.generate(icons.length, (_) => ScrollController());
  final PageController? pageController;
  final int seriesId;
  final int seasonNumber;

  const SonarrSeasonDetailsNavigationBar({
    Key? key,
    required this.pageController,
    required this.seriesId,
    required this.seasonNumber,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<SonarrSeasonDetailsNavigationBar> {
  LunaLoadingState _automaticLoadingState = LunaLoadingState.INACTIVE;

  @override
  Widget build(BuildContext context) {
    return LunaBottomNavigationBar(
      pageController: widget.pageController,
      scrollControllers: SonarrSeasonDetailsNavigationBar.scrollControllers,
      icons: SonarrSeasonDetailsNavigationBar.icons,
      titles: SonarrSeasonDetailsNavigationBar.titles,
      topActions: [
        LunaButton(
          type: LunaButtonType.TEXT,
          text: 'sonarr.Automatic'.tr(),
          icon: Icons.search_rounded,
          onTap: _automatic,
          loadingState: _automaticLoadingState,
        ),
        LunaButton.text(
          text: 'sonarr.Interactive'.tr(),
          icon: Icons.person_rounded,
          onTap: _manual,
        ),
      ],
    );
  }

  Future<void> _automatic() async {
    Future<void> setLoadingState(LunaLoadingState state) async {
      if (this.mounted) setState(() => _automaticLoadingState = state);
    }

    setLoadingState(LunaLoadingState.ACTIVE);
    SonarrAPIController()
        .automaticSeasonSearch(
          context: context,
          seriesId: widget.seriesId,
          seasonNumber: widget.seasonNumber,
        )
        .whenComplete(() => setLoadingState(LunaLoadingState.INACTIVE));
  }

  Future<void> _manual() async {
    return SonarrRoutes.RELEASES.go(queryParams: {
      'series': widget.seriesId.toString(),
      'season': widget.seasonNumber.toString(),
    });
  }
}
