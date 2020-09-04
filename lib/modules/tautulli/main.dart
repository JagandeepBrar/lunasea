import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliModule extends StatefulWidget {
    static const String ROUTE_NAME = '/tautulli';
    final String profile;

    TautulliModule({
        Key key,
        this.profile,
    }) : super(key: key);

    @override
    State<TautulliModule> createState() => _State();
}

class _State extends State<TautulliModule> {
    final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

    @override
    Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (_) => TautulliLocalState(),
        child: Navigator(
            key: _navigatorKey,
            initialRoute: TautulliRoute.route(profile: widget.profile),
            onGenerateRoute: TautulliRouter.router.generator,
        ),
    );
}
