import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsAccountRestoreConfigurationTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LunaListTile(
      context: context,
      title: LunaText.title(text: 'Restore from Cloud'),
      subtitle: LunaText.subtitle(text: 'Restore Configuration Data'),
      trailing: LunaIconButton(icon: Icons.cloud_download_rounded),
      onTap: () async => _restore(context),
    );
  }

  Future<void> _restore(BuildContext context) async {
    try {
      List<LunaFirebaseBackupDocument> documents =
          await LunaFirebaseFirestore().getBackupEntries();
      Tuple2<bool, LunaFirebaseBackupDocument> result =
          await SettingsDialogs().getBackupFromCloud(context, documents);
      if (result.item1) {
        String encrypted =
            await LunaFirebaseStorage().downloadBackup(result.item2.id);
        Tuple2<bool, String> key =
            await SettingsDialogs().decryptBackup(context);
        if (key.item1) {
          String decrypted = LunaEncryption().decrypt(key.item2, encrypted);
          if (decrypted != LunaEncryption.ENCRYPTION_FAILURE) {
            LunaConfiguration().import(context, decrypted).then(
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
