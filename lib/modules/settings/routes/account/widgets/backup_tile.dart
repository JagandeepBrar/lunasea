import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsAccountBackupConfigurationTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LunaListTile(
      context: context,
      title: LunaText.title(text: 'settings.BackupToCloud'.tr()),
      subtitle:
          LunaText.subtitle(text: 'settings.BackupToCloudDescription'.tr()),
      trailing: LunaIconButton(icon: Icons.cloud_upload_rounded),
      onTap: () async => _backup(context),
    );
  }

  Future<void> _backup(BuildContext context) async {
    try {
      Tuple2<bool, String> _values =
          await SettingsDialogs().backupConfiguration(context);
      if (_values.item1) {
        String decrypted = LunaConfiguration().export();
        String encrypted = LunaEncryption().encrypt(_values.item2, decrypted);
        int timestamp = DateTime.now().millisecondsSinceEpoch;
        String title =
            DateFormat('MMMM dd, yyyy\nhh:mm:ss a').format(DateTime.now());
        String id = LunaUUID().uuid;
        if (encrypted != LunaEncryption.ENCRYPTION_FAILURE)
          LunaFirebaseFirestore()
              .addBackupEntry(id, timestamp, title: title)
              .then((_) => LunaFirebaseStorage().uploadBackup(encrypted, id))
              .then((_) => showLunaSuccessSnackBar(
                    title: 'settings.BackupToCloudSuccess'.tr(),
                    message: title.replaceAll('\n', ' ${LunaUI.TEXT_EMDASH} '),
                  ))
              .catchError((error, stack) {
            LunaLogger().error(
              'Failed to backup configuration to the cloud',
              error,
              stack,
            );
            showLunaErrorSnackBar(
              title: 'settings.BackupToCloudFailure'.tr(),
              error: error,
            );
          });
      }
    } catch (error, stack) {
      LunaLogger().error('Backup Failed', error, stack);
      showLunaErrorSnackBar(
        title: 'settings.BackupToCloudFailure'.tr(),
        error: error,
      );
    }
  }
}
