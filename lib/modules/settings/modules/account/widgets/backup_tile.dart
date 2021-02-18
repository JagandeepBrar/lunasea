import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsAccountBackupConfigurationTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return LunaListTile(
            context: context,
            title: LunaText.title(text: 'Backup to Cloud'),
            subtitle: LunaText.subtitle(text: 'Backup Configuration Data'),
            trailing: LunaIconButton(icon: Icons.cloud_upload_rounded),
            onTap: () async => _backup(context),
        );
    }

    Future<void> _backup(BuildContext context) async {
        try {
            List<dynamic> _values = await SettingsDialogs.backupConfiguration(context);
            if(_values[0]) {
                String decrypted = LunaConfiguration().export();
                String encrypted = LunaEncryption().encrypt(_values[1], decrypted);
                int timestamp = DateTime.now().millisecondsSinceEpoch;
                String title = DateFormat('MMMM dd, yyyy\nhh:mm:ss a').format(DateTime.now());
                String id = LunaUUID().uuid;
                if(encrypted != LunaEncryption.ENCRYPTION_FAILURE) LunaFirebaseFirestore().addBackupEntry(id, timestamp, title: title)
                .then((_) => LunaFirebaseStorage().uploadBackup(encrypted, id))
                .then((_) => showLunaSuccessSnackBar(context: context, title: 'Successfully Backed Up', message: title.replaceAll('\n', ' ${Constants.TEXT_EMDASH} ')))
                .catchError((error, stack) {
                    LunaLogger().error('Failed to backup configuration to the cloud', error, stack);
                    showLunaErrorSnackBar(context: context, title: 'Failed to Backup', error: error);
                });
            }
        } catch (error, stack) {
            LunaLogger().error('Backup Failed', error, stack);
            showLunaErrorSnackBar(
                context: context,
                title: 'Failed to Backup',
                error: error,
            );
        }
    }
}
