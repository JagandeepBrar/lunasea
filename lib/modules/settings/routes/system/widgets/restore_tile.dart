import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsSystemBackupRestoreRestoreTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return LunaListTile(
            context: context,
            title: LunaText.title(text: 'Restore from Device'),
            subtitle: LunaText.subtitle(text: 'Restore Configuration Data'),
            trailing: LunaIconButton(icon: Icons.download_rounded),
            onTap: () async => _restore(context),
        );
    }

    Future<void> _restore(BuildContext context) async {
        try {
            FilePickerResult _file = await FilePicker.platform.pickFiles(
                type: FileType.any,
                allowMultiple: false,
                allowCompression: false,
                withData: true,
            );
            if(_file == null) return;
            if(
                _file.files[0].extension == 'json' ||
                _file.files[0].extension == 'lunasea'
            ) {
                String _data = String.fromCharCodes(_file.files[0].bytes);
                List _key = await SettingsDialogs.enterEncryptionKey(context);
                if(_key[0]) {
                    String _decrypted = LunaEncryption().decrypt(_key[1], _data);
                    if(_decrypted != LunaEncryption.ENCRYPTION_FAILURE) {
                        LunaConfiguration().import(context, _decrypted).then((_) => showLunaSuccessSnackBar(
                            context: context,
                            title: 'Restored',
                            message: 'Your configuration has been restored',
                        ));
                    } else {
                        showLunaErrorSnackBar(
                            context: context,
                            title: 'Failed to Restore',
                            message: 'An incorrect encryption key was supplied',
                        );
                    }
                }
            } else {
                showLunaErrorSnackBar(
                    context: context,
                    title: 'Failed to Restore',
                    message: 'Please select a valid backup file',
                );
            }
        } catch (error, stack) {
            LunaLogger().error('Restore Failed', error, stack);
            showLunaErrorSnackBar(
                context: context,
                title: 'Failed to Restore',
                error: error,
            );
        }
    }
}
