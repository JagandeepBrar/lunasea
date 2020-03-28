import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

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
                title: LSTitle(text: 'Clear'),
                subtitle: LSSubtitle(text: 'Clear your configuration'),
                trailing: LSIconButton(icon: Icons.cloud_off),
                onTap: _clear,
            ),
            LSDivider(),
            LSCardTile(
                title: LSTitle(text: 'Restore'),
                subtitle: LSSubtitle(text: 'Restore configuration data'),
                trailing: LSIconButton(icon: Icons.cloud_download),
                onTap: _restore,
            ),
            LSCardTile(
                title: LSTitle(text: 'Backup'),
                subtitle: LSSubtitle(text: 'Backup configuration data'),
                trailing: LSIconButton(icon: Icons.cloud_upload),
                onTap: _backup,
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
                    await Filesystem.exportConfigToFilesystem(encrypted);
                    LSSnackBar(
                        context: context,
                        title: 'Backed Up',
                        message: 'Backups are located in the application directory',
                        type: SNACKBAR_TYPE.success,
                    );
                }
            }
        } catch (error) {
            Logger.error('SettingsGeneralConfiguration', '_backup', 'Backup Failed', error, StackTrace.current);
            LSSnackBar(
                context: context,
                title: 'Back Up Failed',
                message: Constants.CHECK_LOGS_MESSAGE,
                type: SNACKBAR_TYPE.failure,
            );
        }
    }

    Future<void> _restore() async {
        try {
            File file = await FilePicker.getFile(type: FileType.any);
            if(file != null && file.path.endsWith('json')) {
                String data = await file.readAsString();
                List values = await SystemDialogs.showEncryptionKeyPrompt(context);
                if(values[0]) {
                    String _decrypted = Encryption.decrypt(values[1], data);
                    if(_decrypted != Constants.ENCRYPTION_FAILURE) {
                        await Import.import(_decrypted)
                            ? LSSnackBar(
                                context: context,
                                title: 'Restored',
                                message: 'Your configuration has been restored',
                                type: SNACKBAR_TYPE.success,
                            )
                            : LSSnackBar(
                                context: context,
                                title: 'Failed to Restore',
                                message: 'This is not a valid LunaSea v2.x configuration backup',
                                type: SNACKBAR_TYPE.failure,
                            );
                    } else {
                        LSSnackBar(
                            context: context,
                            title: 'Failed to Resture',
                            message: 'An incorrect encryption key was supplied',
                            type: SNACKBAR_TYPE.failure,
                        );
                    }
                }
            } else {
                LSSnackBar(
                    context: context,
                    title: 'Failed to Resture',
                    message: 'Please select a valid backup file',
                    type: SNACKBAR_TYPE.failure,
                );
            }
        } catch (error) {
            Logger.error('SettingsGeneralConfiguration', '_restore', 'Restore Failed', error, StackTrace.current);
            LSSnackBar(
                context: context,
                title: 'Failed to Restore',
                message: Constants.CHECK_LOGS_MESSAGE,
                type: SNACKBAR_TYPE.failure,
            );
        }
    }

    Future<void> _clear() async {
        List values = await SystemDialogs.showClearConfigurationPrompt(context);
        if(values[0]) {
            Database.setDefaults();
            LSSnackBar(
                context: context,
                title: 'Configuration Cleared',
                message: 'Your configuration has been cleared',
                type: SNACKBAR_TYPE.success,
            );
        }
    }
}
