import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sabnzbd.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsConfigurationSABnzbdDefaultPagesRouter extends SettingsPageRouter {
    SettingsConfigurationSABnzbdDefaultPagesRouter() : super('/settings/configuration/sabnzbd/pages');

    @override
    void defineRoute(FluroRouter router) => super.noParameterRouteDefinition(router, _SettingsConfigurationSABnzbdRoute());
}

class _SettingsConfigurationSABnzbdRoute extends StatefulWidget {
    @override
    State<_SettingsConfigurationSABnzbdRoute> createState() => _State();
}

class _State extends State<_SettingsConfigurationSABnzbdRoute> with LunaScrollControllerMixin {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    @override
    Widget build(BuildContext context) {
        return  LunaScaffold(
            scaffoldKey: _scaffoldKey,
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
            ],
        );
    }

    Widget _homePage() {
        return SABnzbdDatabaseValue.NAVIGATION_INDEX.listen(
            builder: (context, box, _) => LunaListTile(
                context: context,
                title: LunaText.title(text: 'Home'),
                subtitle: LunaText.subtitle(text: SABnzbdNavigationBar.titles[SABnzbdDatabaseValue.NAVIGATION_INDEX.data]),
                trailing: LunaIconButton(icon: SABnzbdNavigationBar.icons[SABnzbdDatabaseValue.NAVIGATION_INDEX.data]),
                onTap: () async {
                    List values = await SABnzbdDialogs.defaultPage(context);
                    if(values[0]) SABnzbdDatabaseValue.NAVIGATION_INDEX.put(values[1]);
                },
            ),
        );
    }
}
