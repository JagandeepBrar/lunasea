import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/firebase/auth.dart';
import 'package:lunasea/modules/settings.dart';
import 'package:lunasea/modules/settings/routes/account/pages.dart';
import 'package:lunasea/router/routes/settings.dart';

class AccountRoute extends StatefulWidget {
  const AccountRoute({
    Key? key,
  }) : super(key: key);

  @override
  State<AccountRoute> createState() => _State();
}

class _State extends State<AccountRoute> with LunaScrollControllerMixin {
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
              onPressed: SettingsRoutes.ACCOUNT_SETTINGS.go,
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
