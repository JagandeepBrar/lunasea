import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsAccountDeleteConfigurationTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LunaListTile(
      context: context,
      title: LunaText.title(text: 'Delete Cloud Backup'),
      subtitle: LunaText.subtitle(text: 'Delete a Configuration File'),
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
                  title: 'Deleted Backup',
                  message: result.item2.title
                      .replaceAll('\n', ' ${LunaUI.TEXT_EMDASH} '),
                ))
            .catchError((error, stack) {
          LunaLogger().error('Failed to delete backup entry', error, stack);
          showLunaErrorSnackBar(title: 'Failed to Delete Backup', error: error);
        });
      }
    } catch (error, stack) {
      LunaLogger().error('Deletion Failed', error, stack);
      showLunaErrorSnackBar(title: 'Failed to Delete', error: error);
    }
  }
}
