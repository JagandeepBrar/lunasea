import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class ConfigurationSonarrDefaultPagesRoute extends StatefulWidget {
  const ConfigurationSonarrDefaultPagesRoute({
    Key? key,
  }) : super(key: key);

  @override
  State<ConfigurationSonarrDefaultPagesRoute> createState() => _State();
}

class _State extends State<ConfigurationSonarrDefaultPagesRoute>
    with LunaScrollControllerMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return LunaScaffold(
      scaffoldKey: _scaffoldKey,
      appBar: _appBar(),
      body: _body(),
    );
  }

  PreferredSizeWidget _appBar() {
    return LunaAppBar(
      title: 'settings.DefaultPages'.tr(),
      scrollControllers: [scrollController],
    );
  }

  Widget _body() {
    return LunaListView(
      controller: scrollController,
      children: [
        _homePage(),
        _seriesDetailsPage(),
        _seasonDetailsPage(),
      ],
    );
  }

  Widget _homePage() {
    const _db = SonarrDatabase.NAVIGATION_INDEX;
    return _db.listenableBuilder(
      builder: (context, _) {
        return LunaBlock(
          title: 'lunasea.Home'.tr(),
          body: [TextSpan(text: SonarrNavigationBar.titles[_db.read()])],
          trailing: LunaIconButton(icon: SonarrNavigationBar.icons[_db.read()]),
          onTap: () async {
            List values = await SonarrDialogs.setDefaultPage(
              context,
              titles: SonarrNavigationBar.titles,
              icons: SonarrNavigationBar.icons,
            );
            if (values[0]) _db.update(values[1]);
          },
        );
      },
    );
  }

  Widget _seriesDetailsPage() {
    const _db = SonarrDatabase.NAVIGATION_INDEX_SERIES_DETAILS;
    return _db.listenableBuilder(
      builder: (context, _) {
        return LunaBlock(
          title: 'sonarr.SeriesDetails'.tr(),
          body: [
            TextSpan(text: SonarrSeriesDetailsNavigationBar.titles[_db.read()])
          ],
          trailing: LunaIconButton(
              icon: SonarrSeriesDetailsNavigationBar.icons[_db.read()]),
          onTap: () async {
            List values = await SonarrDialogs.setDefaultPage(
              context,
              titles: SonarrSeriesDetailsNavigationBar.titles,
              icons: SonarrSeriesDetailsNavigationBar.icons,
            );
            if (values[0]) _db.update(values[1]);
          },
        );
      },
    );
  }

  Widget _seasonDetailsPage() {
    const _db = SonarrDatabase.NAVIGATION_INDEX_SEASON_DETAILS;
    return _db.listenableBuilder(
      builder: (context, _) {
        return LunaBlock(
          title: 'sonarr.SeasonDetails'.tr(),
          body: [
            TextSpan(text: SonarrSeasonDetailsNavigationBar.titles[_db.read()])
          ],
          trailing: LunaIconButton(
              icon: SonarrSeasonDetailsNavigationBar.icons[_db.read()]),
          onTap: () async {
            List values = await SonarrDialogs.setDefaultPage(
              context,
              titles: SonarrSeasonDetailsNavigationBar.titles,
              icons: SonarrSeasonDetailsNavigationBar.icons,
            );
            if (values[0]) _db.update(values[1]);
          },
        );
      },
    );
  }
}
