import 'dart:io';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsSystemBackupRestoreRestoreTile extends StatelessWidget {
  const SettingsSystemBackupRestoreRestoreTile({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LunaBlock(
      title: 'Restore from Device',
      body: const [TextSpan(text: 'Restore Configuration Data')],
      trailing: const LunaIconButton(icon: Icons.download_rounded),
      onTap: () async => _restore(context),
    );
  }

  Future<void> _restore(BuildContext context) async {
    try {
      File file = await LunaFileSystem().import(context, ['lunasea']);
      if (file != null) {
        String _data = file.readAsStringSync();
        Tuple2<bool, String> _key =
            await SettingsDialogs().decryptBackup(context);
        if (_key.item1) {
          String _decrypted = LunaEncryption().decrypt(_key.item2, _data);
          if (_decrypted != LunaEncryption.ENCRYPTION_FAILURE) {
            LunaConfiguration().import(context, _decrypted).then(
                  (_) => showLunaSuccessSnackBar(
                    title: 'Restored',
                    message: 'Your configuration has been restored',
                  ),
                );
          } else {
            showLunaErrorSnackBar(
              title: 'Failed to Restore',
              message: 'An incorrect encryption key was supplied',
            );
          }
        }
      } else {
        showLunaErrorSnackBar(
          title: 'Failed to Restore',
          message: 'Please select a valid file type',
        );
      }
    } catch (error, stack) {
      LunaLogger().error('Restore Failed', error, stack);
      showLunaErrorSnackBar(
        title: 'Failed to Restore',
        error: error,
      );
    }
  }
}
