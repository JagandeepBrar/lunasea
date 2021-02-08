import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsAccountRouter extends LunaPageRouter {
    SettingsAccountRouter() : super('/settings/account');

    @override
    void defineRoute(FluroRouter router) => super.noParameterRouteDefinition(router, _SettingsAccountRoute());
}

class _SettingsAccountRoute extends StatefulWidget {
    @override
    State<_SettingsAccountRoute> createState() => _State();
}

class _State extends State<_SettingsAccountRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        body: _body,
    );

    Widget get _appBar => LunaAppBar(
        title: 'Account',
        actions: [_helpMessageButton],
    );
    
    Widget get _helpMessageButton => LSIconButton(
        icon: Icons.help_outline,
        onPressed: () async => SettingsDialogs.accountHelpMessage(context),
    );

    Widget get _body => StreamBuilder(
        stream: LunaFirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
            if(snapshot.data != null) return SettingsAccountSignedInBody();
            return SettingsAccountSignedOutBody();
        },
    );
}
