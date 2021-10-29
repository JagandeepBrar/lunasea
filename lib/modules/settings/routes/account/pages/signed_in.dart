import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsAccountSignedInPage extends StatefulWidget {
  final ScrollController scrollController;

  const SettingsAccountSignedInPage({
    Key key,
    @required this.scrollController,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<SettingsAccountSignedInPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return LunaScaffold(
      scaffoldKey: _scaffoldKey,
      body: _body(),
      bottomNavigationBar: _bottomActionBar(),
    );
  }

  Widget _bottomActionBar() {
    return LunaBottomActionBar(
      actions: [
        LunaButton.text(
          text: 'settings.SignOut'.tr(),
          icon: Icons.logout,
          color: LunaColours.red,
          onTap: () async {
            bool result =
                await SettingsDialogs().confirmAccountSignOut(context);
            if (result)
              LunaFirebaseAuth()
                  .signOut()
                  .then((_) => showLunaSuccessSnackBar(
                        title: 'settings.SignedOutSuccess'.tr(),
                        message: 'settings.SignedOutSuccessMessage'.tr(),
                      ))
                  .catchError((error, stack) {
                LunaLogger().error('Failed to sign out', error, stack);
                showLunaErrorSnackBar(
                  title: 'settings.SignedOutFailure'.tr(),
                  error: error,
                );
              });
          },
        ),
      ],
    );
  }

  Widget _body() {
    return LunaListView(
      controller: widget.scrollController,
      children: [
        SettingsAccountBackupConfigurationTile(),
        SettingsAccountRestoreConfigurationTile(),
        SettingsAccountDeleteConfigurationTile(),
      ],
    );
  }
}
