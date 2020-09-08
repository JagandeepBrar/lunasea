import 'package:flutter/material.dart';
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
    final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

    @override
    Widget build(BuildContext context) => Navigator(
        key: _navigatorKey,
        initialRoute: SettingsRoute.route(),
        onGenerateRoute: SettingsRouter.router.generator,
    );
}
