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
            List<LunaFirebaseBackupDocument> documents = await LunaFirebaseFirestore().getBackupEntries();
            List<dynamic> values = await SettingsDialogs.getBackupFromCloud(context, documents);
            if(values[0]) {
                LunaFirebaseBackupDocument document = values[1];
                String encrypted = await LunaFirebaseStorage().downloadBackup(document.id);
                List key = await SettingsDialogs.enterEncryptionKey(context);
                if(key[0]) {
                    String decrypted = LunaEncryption().decrypt(key[1], encrypted);
                    if(decrypted != LunaEncryption.ENCRYPTION_FAILURE) {
                        LunaConfiguration().import(context, decrypted).then((_) => showLunaSuccessSnackBar(
                            title: 'Restored',
                            message: 'Your configuration has been restored',
                        ));
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
