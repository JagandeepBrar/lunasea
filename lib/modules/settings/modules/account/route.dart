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
        context: context,
        title: 'Account',
        actions: [_actionButton],
    );

    Widget get _actionButton => StreamBuilder(
        stream: LunaFirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
            if(snapshot.data != null) return _signOutButton;
            return _helpMessageButton;
        }
    );
    
    Widget get _helpMessageButton => LSIconButton(
        icon: Icons.help_outline,
        onPressed: () async => SettingsDialogs.helpMessage(
            context,
            title: 'Account',
            message: '${Constants.APPLICATION_NAME} offers a free account to backup your configuration to the cloud, with additional features coming in the future!',
        ),
    );

    Widget get _signOutButton => LSIconButton(
        icon: Icons.exit_to_app,
        onPressed: () async {
            List values = await SettingsDialogs.confirmSignOut(context);
            if(values[0]) LunaFirebaseAuth().signOut()
                .then((_) => showLunaSuccessSnackBar(context: context, title: 'Signed Out', message: 'Signed out of your ${Constants.APPLICATION_NAME} account'))
                .catchError((error, stack) {
                    LunaLogger().error('Failed to sign out', error, stack);
                    showLunaErrorSnackBar(context: context, title: 'Failed to Sign Out', error: error);
                });
        },
    );

    Widget get _body => StreamBuilder(
        stream: LunaFirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
            if(snapshot.data != null) return SettingsAccountSignedInBody();
            return SettingsAccountSignedOutBody();
        },
    );
}
