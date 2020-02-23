import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core/configuration.dart';
import 'package:lunasea/core/constants.dart';
//import 'package:lunasea/core.dart';
//import 'package:lunasea/system.dart';
import 'package:lunasea/widgets/ui.dart';

class SettingsGeneralConfiguration extends StatefulWidget {
    @override
    State<SettingsGeneralConfiguration> createState() => _State();
}

class _State extends State<SettingsGeneralConfiguration> {
    final _scaffoldKey = GlobalKey<ScaffoldState>();

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        body: _body,
    );

    Widget get _body => LSListView(
        children: <Widget>[
            LSCardTile(
                title: LSTitle(text: 'Backup'),
                subtitle: LSSubtitle(text: 'Backup configuration data'),
                trailing: LSIconButton(icon: Icons.backup),
                onTap: _backup,
            ),
            LSCardTile(
                title: LSTitle(text: 'Restore'),
                subtitle: LSSubtitle(text: 'Restore configuration data'),
                trailing: LSIconButton(icon: Icons.cloud_download),
                onTap: _restore,
            ),
        ],
    );

    Future<void> _backup() async {
        try {
            List<dynamic> _values = await SystemDialogs.showBackupConfigurationPrompt(context);
            if(_values[0]) {
                String data = Export.export();
                String encrypted = Encryption.encrypt(_values[1], data);
                if(encrypted != Constants.ENCRYPTION_FAILURE) {
                    await Filesystem.exportToFilesystem(encrypted);
                    Notifications.showSnackBar(_scaffoldKey, 'Backed up configuration');
                }
            }
        } catch (e) {
            Notifications.showSnackBar(_scaffoldKey, 'Some error has occurred, please try again');
        }
    }

    Future<void> _restore() async {
        try {
            File file = await FilePicker.getFile(type: FileType.ANY);
            if(file != null && file.path.endsWith('json')) {
                String data = await file.readAsString();
                List values = await SystemDialogs.showEncryptionKeyPrompt(context);
                if(values[0]) {
                    String _decrypted = Encryption.decrypt(values[1], data);
                    if(_decrypted != Constants.ENCRYPTION_FAILURE) {
                        await Import.import(_decrypted);
                        Notifications.showSnackBar(_scaffoldKey, 'Configuration restored');
                    } else {
                        Notifications.showSnackBar(_scaffoldKey, 'Incorrect encryption key');
                    }
                }
            } else {
                Notifications.showSnackBar(_scaffoldKey, 'Please select a valid backup file');
            }
        } catch (e) {
            Notifications.showSnackBar(_scaffoldKey, 'Some error has occurred, please try again');
        }
    }
}
