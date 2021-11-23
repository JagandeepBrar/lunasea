import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsAccountDeleteConfigurationTile extends StatelessWidget {
  const SettingsAccountDeleteConfigurationTile({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LunaListTile(
      context: context,
      title: LunaText.title(text: 'settings.DeleteCloudBackup'.tr()),
      subtitle:
          LunaText.subtitle(text: 'settings.DeleteCloudBackupDescription'.tr()),
      trailing: LunaIconButton(icon: Icons.cloud_off_rounded),
      onTap: () async => _delete(context),
    );
  }

  Future<void> _delete(BuildContext context) async {
    try {
      List<LunaFirebaseBackupDocument> documents =
          await LunaFirebaseFirestore().getBackupEntries();
      Tuple2<bool, LunaFirebaseBackupDocument> result =
          await SettingsDialogs().getBackupFromCloud(context, documents);
      if (result.item1) {
        LunaFirebaseFirestore()
            .deleteBackupEntry(result.item2.id)
            .then((_) => LunaFirebaseStorage().deleteBackup(result.item2.id))
            .then((_) => showLunaSuccessSnackBar(
                  title: 'settings.DeleteCloudBackupSuccess'.tr(),
                  message: result.item2.title
                      .replaceAll('\n', ' ${LunaUI.TEXT_EMDASH} '),
                ))
            .catchError((error, stack) {
          LunaLogger().error('Firebase Backup Deletion Failed', error, stack);
          showLunaErrorSnackBar(
            title: 'settings.DeleteCloudBackupFailure'.tr(),
            error: error,
          );
        });
      }
    } catch (error, stack) {
      LunaLogger().error('Firebase Backup Deletion Failed', error, stack);
      showLunaErrorSnackBar(
        title: 'settings.DeleteCloudBackupFailure'.tr(),
        error: error,
      );
    }
  }
}
