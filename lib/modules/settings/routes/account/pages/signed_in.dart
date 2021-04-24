import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsAccountSignedInPage extends StatefulWidget {
  final ScrollController scrollController;

  SettingsAccountSignedInPage({
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
          text: 'Sign Out',
          icon: Icons.logout,
          color: LunaColours.red,
          onTap: () async {
            bool result =
                await SettingsDialogs().confirmAccountSignOut(context);
            if (result)
              LunaFirebaseAuth()
                  .signOut()
                  .then((_) => showLunaSuccessSnackBar(
                      title: 'Signed Out',
                      message: 'Signed out of your LunaSea account'))
                  .catchError((error, stack) {
                LunaLogger().error('Failed to sign out', error, stack);
                showLunaErrorSnackBar(
                    title: 'Failed to Sign Out', error: error);
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
