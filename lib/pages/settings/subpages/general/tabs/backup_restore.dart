import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/configuration/configuration.dart';
import 'package:lunasea/configuration/encryption.dart';
import 'package:lunasea/configuration/filesystem.dart';
import 'package:lunasea/system/constants.dart';
import 'package:lunasea/system/ui.dart';

class BackupRestore extends StatefulWidget {
    @override
    State<BackupRestore> createState() {
        return _State();
    }
}

class _State extends State<BackupRestore> {
    final _scaffoldKey = GlobalKey<ScaffoldState>();

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            key: _scaffoldKey,
            body: _backupRestoreSettings(),
        );
    }

    
    Widget _backupRestoreSettings() {
        return Scrollbar(
            child: ListView(
                children: <Widget>[
                    Card(
                        child: ListTile(
                            title: Elements.getTitle('Backup'),
                            subtitle: Elements.getSubtitle('Backup configuration data'),
                            trailing: IconButton(
                                icon: Elements.getIcon(Icons.backup),
                                onPressed: null,
                            ),
                            onTap: _handleBackup,
                        ),
                        margin: Elements.getCardMargin(),
                        elevation: 4.0,
                    ),
                    Card(
                        child: ListTile(
                            title: Elements.getTitle('Restore'),
                            subtitle: Elements.getSubtitle('Restore configuration data'),
                            trailing: IconButton(
                                icon: Elements.getIcon(Icons.cloud_download),
                                onPressed: null,
                            ),
                            onTap: _handleRestore,
                        ),
                        margin: Elements.getCardMargin(),
                        elevation: 4.0,
                    ),
                ],
                padding: Elements.getListViewPadding(),
            ),
        );
    }

    Future<void> _handleBackup() async {
        try {
            List<dynamic> _values = await SystemDialogs.showBackupConfigurationPrompt(context);
            if(_values[0]) {
                String config = await Configuration.exportConfig();
                String encrypted = Encryption.encryptData(_values[1], config);
                if(encrypted != Constants.ENCRYPTION_FAILURE) {
                    if(await Filesystem.exportConfigToFilesystem(encrypted)) {
                        Notifications.showSnackBar(_scaffoldKey, 'Backed up configuration');
                    } else {
                        Notifications.showSnackBar(_scaffoldKey, 'Failed to write configuration to filesystem');
                    }
                } else {
                    Notifications.showSnackBar(_scaffoldKey, 'Failed to encrypt backup');
                }
            }
        } catch (e) {
            Notifications.showSnackBar(_scaffoldKey, 'Some error has occurred, please try again');
        }
    }

    Future<void> _handleRestore() async {
        try {
            File file = await FilePicker.getFile(type: FileType.ANY);
            if(file != null) {
                if(file.path.endsWith('json')) {
                    String data = await file.readAsString();
                    List<dynamic> _values = await SystemDialogs.showEncryptionKeyPrompt(context);
                    if(_values[0]) {
                        String decrypted = Encryption.decryptData(_values[1], data);
                        if(decrypted != Constants.ENCRYPTION_FAILURE) {
                            if(await Configuration.importConfig(decrypted)) {
                                await Configuration.pullAndSanitizeValues();
                                Notifications.showSnackBar(_scaffoldKey, 'Restored configuration');
                            } else {
                                Notifications.showSnackBar(_scaffoldKey, 'The backup file supplied is invalid');
                            }
                        } else {
                            Notifications.showSnackBar(_scaffoldKey, 'Incorrect encryption key');
                        }
                    }
                } else {
                    Notifications.showSnackBar(_scaffoldKey, 'Please select a valid backup file');
                }
            }
        } catch (e) {
            Notifications.showSnackBar(_scaffoldKey, 'Failed to open file');
        }
    }
}
