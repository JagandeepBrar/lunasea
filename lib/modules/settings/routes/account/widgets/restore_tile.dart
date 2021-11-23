import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsAccountRestoreConfigurationTile extends StatelessWidget {
  const SettingsAccountRestoreConfigurationTile({Key key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LunaListTile(
      context: context,
      title: LunaText.title(text: 'settings.RestoreFromCloud'.tr()),
      subtitle:
          LunaText.subtitle(text: 'settings.RestoreFromCloudDescription'.tr()),
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
            LunaConfiguration()
                .import(context, decrypted)
                .then((_) => showLunaSuccessSnackBar(
                      title: 'settings.RestoreFromCloudSuccess'.tr(),
                      message: 'settings.RestoreFromCloudSuccessMessage'.tr(),
                    ));
          } else {
            showLunaErrorSnackBar(
              title: 'settings.RestoreFromCloudFailure'.tr(),
              message: 'lunasea.IncorrectEncryptionKey'.tr(),
            );
          }
        }
      }
    } catch (error, stack) {
      LunaLogger().error('Restore Failed', error, stack);
      showLunaErrorSnackBar(
        title: 'settings.RestoreFromCloudFailure'.tr(),
        error: error,
      );
    }
  }
}
