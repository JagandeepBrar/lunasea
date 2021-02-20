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

class _State extends State<_SettingsAccountRoute> with LunaScrollControllerMixin {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            key: _scaffoldKey,
            appBar: _appBar(),
            body: _body(),
        );
    }

    Widget _appBar() {
        return LunaAppBar(
            title: 'Account',
            scrollControllers: [scrollController],
            actions: [
                LunaIconButton(
                    icon: Icons.help_outline,
                    onPressed: () async => SettingsDialogs().accountHelpMessage(context),
                ),
            ],
        );
    }

    Widget _body() {
        return StreamBuilder(
            stream: LunaFirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
                if(snapshot.data == null) return SettingsAccountSignedOutPage(scrollController: scrollController);
                return SettingsAccountSignedInPage(scrollController: scrollController);                
            },
        );
    }
}
