import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsNotificationsRouter extends SettingsPageRouter {
    SettingsNotificationsRouter() : super('/settings/notifications');

    @override
    void defineRoute(FluroRouter router) => super.noParameterRouteDefinition(router, _SettingsNotificationsRoute());
}

class _SettingsNotificationsRoute extends StatefulWidget {
    @override
    State<_SettingsNotificationsRoute> createState() => _State();
}

class _State extends State<_SettingsNotificationsRoute> with LunaScrollControllerMixin {
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
            title: 'Notifications',
            scrollControllers: [scrollController],
        );
    }

    Widget _body() {
        return LunaListView(
            controller: scrollController,
            children: [
                SettingsBanners.NOTIFICATIONS_MODULE_SUPPORT.banner(),
            ],
        );
    }
}
