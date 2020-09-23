import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrModule extends StatefulWidget {
    static const String ROUTE_NAME = '/sonarr';
    final String profile;

    SonarrModule({
        Key key,
        this.profile,
    }) : super(key: key);

    @override
    State<SonarrModule> createState() => _State();
}

class _State extends State<SonarrModule> {
    @override
    Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (_) => SonarrLocalState(),
        child: WillPopScope(
            onWillPop: _onWillPop,
            child: Navigator(
                key: Provider.of<SonarrState>(context, listen: false).rootNavigatorKey,
                initialRoute: SonarrHomeRouter.route(profile: widget.profile),
                onGenerateRoute: SonarrRouter.router.generator,
            ),
        ),
    );

    Future<bool> _onWillPop() async {
        SonarrState _state = Provider.of<SonarrState>(context, listen: false);
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
