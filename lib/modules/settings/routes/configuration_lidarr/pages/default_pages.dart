import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/lidarr.dart';

class SettingsConfigurationLidarrDefaultPagesRouter extends LunaPageRouter {
    SettingsConfigurationLidarrDefaultPagesRouter() : super('/settings/configuration/lidarr/pages');

    @override
    void defineRoute(FluroRouter router) => super.noParameterRouteDefinition(router, _SettingsConfigurationLidarrRoute());
}

class _SettingsConfigurationLidarrRoute extends StatefulWidget {
    @override
    State<_SettingsConfigurationLidarrRoute> createState() => _State();
}

class _State extends State<_SettingsConfigurationLidarrRoute> with LunaScrollControllerMixin {
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
        return LunaAppBar(title: 'Default Pages', scrollControllers: [scrollController]);
    }

    Widget _body() {
        return LunaListView(
            controller: scrollController,
            children: [
                _homePage(),
            ],
        );
    }

    Widget _homePage() {
        return LidarrDatabaseValue.NAVIGATION_INDEX.listen(
            builder: (context, box, _) => LunaListTile(
                context: context,
                title: LunaText.title(text: 'Home'),
                subtitle: LunaText.subtitle(text: LidarrNavigationBar.titles[LidarrDatabaseValue.NAVIGATION_INDEX.data]),
                trailing: LunaIconButton(icon: LidarrNavigationBar.icons[LidarrDatabaseValue.NAVIGATION_INDEX.data]),
                onTap: () async {
                    List values = await LidarrDialogs.defaultPage(context);
                    if(values[0]) LidarrDatabaseValue.NAVIGATION_INDEX.put(values[1]);
                },
            ),
        );
    }
}
