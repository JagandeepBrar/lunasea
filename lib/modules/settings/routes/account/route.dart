import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/firebase/auth.dart';
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
      appBar: _appBar() as PreferredSizeWidget?,
      body: _body(),
    );
  }

  Widget _appBar() {
    return LunaAppBar(
      title: 'settings.Account'.tr(),
      scrollControllers: [scrollController],
      actions: [
        StreamBuilder(
          stream: LunaFirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return LunaIconButton(
                icon: Icons.help_outline_rounded,
                onPressed: () async {
                  SettingsDialogs().accountHelpMessage(context);
                },
              );
            }
            return LunaIconButton(
              icon: Icons.settings_rounded,
              onPressed: () async {
                SettingsAccountSettingsRouter().navigateTo(context);
              },
            );
          },
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
