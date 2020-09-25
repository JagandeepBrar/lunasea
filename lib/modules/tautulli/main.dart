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
    @override
    Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (_) => TautulliLocalState(),
        child: WillPopScope(
            onWillPop: _onWillPop,
            child: Navigator(
                key: Provider.of<TautulliState>(context, listen: false).rootNavigatorKey,
                initialRoute: TautulliHomeRouter.route(),
                onGenerateRoute: TautulliRouter.router.generator,
            ),
        ),
    );

    Future<bool> _onWillPop() async {
        TautulliState _state = Provider.of<TautulliState>(context, listen: false);
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
