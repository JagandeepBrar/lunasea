import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsAccountSignedInBody extends StatefulWidget {
    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<SettingsAccountSignedInBody> {
    @override
    Widget build(BuildContext context) => LunaListView(
        children: [
            SettingsAccountBackupConfigurationTile(),
            SettingsAccountRestoreConfigurationTile(),
            SettingsAccountDeleteConfigurationTile(),
            _signOutTile,
        ],
    );

    Widget get _signOutTile => LSButton(
        text: 'Sign Out',
        backgroundColor: LunaColours.red,
        onTap: () async {
            List values = await SettingsDialogs.confirmSignOut(context);
            if(values[0]) LunaFirebaseAuth().signOut()
                .then((_) => showLunaSuccessSnackBar(context: context, title: 'Signed Out', message: 'Signed out of your ${Constants.APPLICATION_NAME} account'))
                .catchError((error, stack) {
                    LunaLogger().error('Failed to sign out', error, stack);
                    showLunaErrorSnackBar(context: context, title: 'Failed to Sign Out', error: error);
                });
        },
    );
}
