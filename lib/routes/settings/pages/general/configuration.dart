//import 'dart:io';
//import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
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
    Widget build(BuildContext context) {
        return Scaffold(
            key: _scaffoldKey,
            body: LSGenericMessage(text: 'Temporarily Disabled')
            //body: _build(),
        );
    }

    // Widget _build() {
    //     return LSListView(
    //         children: <Widget>[
    //             LSCard(
    //                 title: LSTitle(text: 'Backup'),
    //                 subtitle: LSSubtitle(text: 'Backup configuration data'),
    //                 trailing: LSIconButton(icon: Icons.backup),
    //                 onTap: _backup,
    //             ),
    //             LSCard(
    //                 title: LSTitle(text: 'Restore'),
    //                 subtitle: LSSubtitle(text: 'Restore configuration data'),
    //                 trailing: LSIconButton(icon: Icons.cloud_download),
    //                 onTap: _restore,
    //             ),
    //         ],
    //     );
    // }

    // Future<void> _backup() async {
    //     try {
    //         List<dynamic> _values = await SystemDialogs.showBackupConfigurationPrompt(context);
    //         if(_values[0]) {
    //             String config = await Configuration.exportConfig();
    //             String encrypted = Encryption.encryptData(_values[1], config);
    //             if(encrypted != Constants.ENCRYPTION_FAILURE) {
    //                 if(await Filesystem.exportConfigToFilesystem(encrypted)) {
    //                     Notifications.showSnackBar(_scaffoldKey, 'Backed up configuration');
    //                 } else {
    //                     Notifications.showSnackBar(_scaffoldKey, 'Failed to write configuration to filesystem');
    //                 }
    //             } else {
    //                 Notifications.showSnackBar(_scaffoldKey, 'Failed to encrypt backup');
    //             }
    //         }
    //     } catch (e) {
    //         Notifications.showSnackBar(_scaffoldKey, 'Some error has occurred, please try again');
    //     }
    // }

    // Future<void> _restore() async {
    //     try {
    //         File file = await FilePicker.getFile(type: FileType.ANY);
    //         if(file != null) {
    //             if(file.path.endsWith('json')) {
    //                 String data = await file.readAsString();
    //                 List<dynamic> _values = await SystemDialogs.showEncryptionKeyPrompt(context);
    //                 if(_values[0]) {
    //                     String decrypted = Encryption.decryptData(_values[1], data);
    //                     if(decrypted != Constants.ENCRYPTION_FAILURE) {
    //                         if(await Configuration.importConfig(decrypted)) {
    //                             await Configuration.pullAndSanitizeValues();
    //                             Notifications.showSnackBar(_scaffoldKey, 'Restored configuration');
    //                         } else {
    //                             Notifications.showSnackBar(_scaffoldKey, 'The backup file supplied is invalid');
    //                         }
    //                     } else {
    //                         Notifications.showSnackBar(_scaffoldKey, 'Incorrect encryption key');
    //                     }
    //                 }
    //             } else {
    //                 Notifications.showSnackBar(_scaffoldKey, 'Please select a valid backup file');
    //             }
    //         }
    //     } catch (e) {
    //         Notifications.showSnackBar(_scaffoldKey, 'Failed to open file');
    //     }
    // }
}
