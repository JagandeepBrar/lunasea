import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsModule extends StatefulWidget {
    static const String ROUTE_NAME = '/settings';

    SettingsModule({
        Key key,
    }) : super(key: key);

    @override
    State<SettingsModule> createState() => _State();
}

class _State extends State<SettingsModule> {
    @override
    Widget build(BuildContext context) => WillPopScope(
        onWillPop: _onWillPop,
        child: Navigator(
            key: Provider.of<SettingsState>(context).rootNavigatorKey,
            initialRoute: SettingsRoute.route(),
            onGenerateRoute: SettingsRouter.router.generator,
        ),
    );

    Future<bool> _onWillPop() async {
        SettingsState _state = Provider.of<SettingsState>(context, listen: false);
        if(_state.rootNavigatorKey.currentState.canPop()) {
            _state.rootNavigatorKey.currentState.pop();
        } else if(_state.rootScaffoldKey.currentState.hasDrawer) {
            _state.rootScaffoldKey.currentState.isDrawerOpen
                ? _state.rootNavigatorKey.currentState.pop()
                : _state.rootScaffoldKey.currentState.openDrawer();
        }
        return false;
    }
}
