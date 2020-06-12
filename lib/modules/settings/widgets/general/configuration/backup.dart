import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsGeneralConfigurationBackupTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(text: 'Backup'),
        subtitle: LSSubtitle(text: 'Backup Configuration Data'),
        trailing: LSIconButton(icon: Icons.cloud_upload),
        onTap: () async => _backup(context),
    );

    Future<void> _backup(BuildContext context) async {
        try {
            List<dynamic> _values = await SettingsDialogs.backupConfiguration(context);
            if(_values[0]) {
                String data = Export.export();
                String encrypted = Encryption.encrypt(_values[1], data);
                if(encrypted != Constants.ENCRYPTION_FAILURE) {
                    await Filesystem.exportConfigToFilesystem(encrypted);
                    LSSnackBar(
                        context: context,
                        title: 'Backed Up',
                        message: 'Backups are located in the application directory',
                        type: SNACKBAR_TYPE.success,
                    );
                }
            }
        } catch (error) {
            Logger.error('SettingsGeneralConfiguration', '_backup', 'Backup Failed', error, StackTrace.current);
            LSSnackBar(
                context: context,
                title: 'Back Up Failed',
                message: Constants.CHECK_LOGS_MESSAGE,
                type: SNACKBAR_TYPE.failure,
            );
        }
    }
}
