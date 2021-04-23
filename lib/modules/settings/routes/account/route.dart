import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsAccountRouter extends SettingsPageRouter {
  SettingsAccountRouter() : super('/settings/account');

  @override
  _Widget widget() => _Widget();

  @override
  void defineRoute(FluroRouter router) {
    super.noParameterRouteDefinition(router);
  }
}

class _Widget extends StatefulWidget {
  @override
  State<_Widget> createState() => _State();
}

class _State extends State<_Widget> with LunaScrollControllerMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return LunaScaffold(
      scaffoldKey: _scaffoldKey,
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
        if (snapshot.data == null) {
          return SettingsAccountSignedOutPage(
            scrollController: scrollController,
          );
        }
        return SettingsAccountSignedInPage(
          scrollController: scrollController,
        );
      },
    );
  }
}
