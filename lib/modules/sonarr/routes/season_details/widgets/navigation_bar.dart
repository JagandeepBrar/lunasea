import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class SonarrSeasonDetailsNavigationBar extends StatefulWidget {
  static const List<IconData> icons = [
    LunaIcons.television,
    LunaIcons.history,
  ];

  static final List<String> titles = [
    'sonarr.Episodes'.tr(),
    'sonarr.History'.tr(),
  ];

  static List<ScrollController> scrollControllers =
      List.generate(icons.length, (_) => ScrollController());
  final PageController pageController;
  final int seasonNumber;

  const SonarrSeasonDetailsNavigationBar({
    Key key,
    @required this.pageController,
    @required this.seasonNumber,
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
        if (widget.seasonNumber >= 0)
          LunaButton(
            type: LunaButtonType.TEXT,
            text: 'sonarr.Automatic'.tr(),
            icon: Icons.search_rounded,
            onTap: _automatic,
            loadingState: _automaticLoadingState,
          ),
        if (widget.seasonNumber >= 0)
          LunaButton.text(
            text: 'sonarr.Interactive'.tr(),
            icon: Icons.person_rounded,
            onTap: _manual,
          ),
      ],
    );
  }

  Future<void> _automatic() async {
    setState(() => _automaticLoadingState = LunaLoadingState.ACTIVE);
    // TODO
  }

  Future<void> _manual() async {}
}
