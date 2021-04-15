import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsDebugMenuRouter extends SettingsPageRouter {
    SettingsDebugMenuRouter() : super('/settings/debugmenu');

    @override
    void defineRoute(FluroRouter router) => super.noParameterRouteDefinition(router, _SettingsDebugMenuRoute());
}

class _SettingsDebugMenuRoute extends StatefulWidget {
    @override
    State<_SettingsDebugMenuRoute> createState() => _State();
}

class _State extends State<_SettingsDebugMenuRoute> with LunaScrollControllerMixin {
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
            title: 'Debug Menu',
            scrollControllers: [scrollController],
        );
    }

    Widget _body() {
        return LunaListView(
            controller: scrollController,
            children: [
                LunaListTile(
                    context: context,
                    title: LunaText.title(text: 'Clear Alerts Box'),
                    onTap: () async {
                        Database().clearAlertsBox();
                        showLunaSuccessSnackBar(title: 'Cleared', message: 'Cleared Alerts Box');
                    }
                ),
            ],
        );
    }
}
