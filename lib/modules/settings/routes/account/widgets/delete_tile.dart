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
            List<LunaFirebaseBackupDocument> documents = await LunaFirebaseFirestore().getBackupEntries();
            List<dynamic> values = await SettingsDialogs.getBackupFromCloud(context, documents);
            if(values[0]) {
                LunaFirebaseBackupDocument selected = values[1];
                LunaFirebaseFirestore().deleteBackupEntry(selected.id)
                .then((_) => LunaFirebaseStorage().deleteBackup(selected.id))
                .then((_) => showLunaSuccessSnackBar(
                    title: 'Deleted Backup',
                    message: selected.title.replaceAll('\n', ' ${Constants.TEXT_EMDASH} '),
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
