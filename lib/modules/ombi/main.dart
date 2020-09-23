import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/ombi.dart';

class OmbiModule extends StatefulWidget {
    static const String ROUTE_NAME = '/ombi';
    final String profile;

    OmbiModule({
        Key key,
        this.profile,
    }) : super(key: key);

    @override
    State<OmbiModule> createState() => _State();
}

class _State extends State<OmbiModule> {
    @override
    Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (_) => OmbiLocalState(),
        child: WillPopScope(
            onWillPop: _onWillPop,
            child: Navigator(
                key: Provider.of<OmbiState>(context, listen: false).rootNavigatorKey,
                initialRoute: OmbiHomeRouter.route(profile: widget.profile),
                onGenerateRoute: OmbiRouter.router.generator,
            ),
        ),
    );

    Future<bool> _onWillPop() async {
        OmbiState _state = Provider.of<OmbiState>(context, listen: false);
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
