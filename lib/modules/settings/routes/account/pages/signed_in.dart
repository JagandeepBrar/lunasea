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
    @override
    Widget build(BuildContext context) {
        return LunaListView(
            controller: widget.scrollController,
            children: [
                SettingsAccountBackupConfigurationTile(),
                SettingsAccountRestoreConfigurationTile(),
                SettingsAccountDeleteConfigurationTile(),
                _signOutButton(),
            ],
        );
    }

    Widget _signOutButton() {
        return LunaButtonContainer(
            children: [
                LunaButton(
                    text: 'Sign Out',
                    backgroundColor: LunaColours.red,
                    onTap: () async {
                        bool result = await SettingsDialogs().confirmAccountSignOut(context);
                        if(result) LunaFirebaseAuth().signOut()
                        .then((_) => showLunaSuccessSnackBar(context: context, title: 'Signed Out', message: 'Signed out of your LunaSea account'))
                        .catchError((error, stack) {
                            LunaLogger().error('Failed to sign out', error, stack);
                            showLunaErrorSnackBar(context: context, title: 'Failed to Sign Out', error: error);
                        });
                    },
                ),
            ],
        );
    }
}
