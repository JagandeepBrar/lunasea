import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SettingsConfigurationSonarrDefaultPagesRouter extends LunaPageRouter {
    SettingsConfigurationSonarrDefaultPagesRouter() : super('/settings/configuration/sonarr/pages');

    @override
    void defineRoute(FluroRouter router) => super.noParameterRouteDefinition(router, _SettingsConfigurationSonarrRoute());
}

class _SettingsConfigurationSonarrRoute extends StatefulWidget {
    @override
    State<_SettingsConfigurationSonarrRoute> createState() => _State();
}

class _State extends State<_SettingsConfigurationSonarrRoute> with LunaScrollControllerMixin {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            key: _scaffoldKey,
            appBar: _appBar(),
            body: _body(),
        );
    }

    Widget _appBar() {
        return LunaAppBar(
            title: 'Default Pages',
            scrollControllers: [scrollController],
        );
    }

    Widget _body() {
        return LunaListView(
            controller: scrollController,
            children: [
                _homePage(),
                _seriesDetailsPage(),
            ],
        );
    }

    Widget _homePage() {
        return SonarrDatabaseValue.NAVIGATION_INDEX.listen(
            builder: (context, box, _) => LunaListTile(
                context: context,
                title: LunaText.title(text: 'Home'),
                subtitle: LunaText.subtitle(text: SonarrNavigationBar.titles[SonarrDatabaseValue.NAVIGATION_INDEX.data]),
                trailing: LunaIconButton(icon: SonarrNavigationBar.icons[SonarrDatabaseValue.NAVIGATION_INDEX.data]),
                onTap: () async {
                    List values = await SonarrDialogs.setDefaultPage(context, titles: SonarrNavigationBar.titles, icons: SonarrNavigationBar.icons);
                    if(values[0]) SonarrDatabaseValue.NAVIGATION_INDEX.put(values[1]);
                },
            ),
        );
    }

    Widget _seriesDetailsPage() {
        return SonarrDatabaseValue.NAVIGATION_INDEX_SERIES_DETAILS.listen(
            builder: (context, box, _) => LunaListTile(
                context: context,
                title: LunaText.title(text: 'Series Details'),
                subtitle: LunaText.subtitle(text: SonarrSeriesDetailsNavigationBar.titles[SonarrDatabaseValue.NAVIGATION_INDEX_SERIES_DETAILS.data]),
                trailing: LunaIconButton(icon: SonarrSeriesDetailsNavigationBar.icons[SonarrDatabaseValue.NAVIGATION_INDEX_SERIES_DETAILS.data]),
                onTap: () async {
                    List values = await SonarrDialogs.setDefaultPage(context, titles: SonarrSeriesDetailsNavigationBar.titles, icons: SonarrSeriesDetailsNavigationBar.icons);
                    if(values[0]) SonarrDatabaseValue.NAVIGATION_INDEX_SERIES_DETAILS.put(values[1]);
                },
            ),
        );
    }
}
