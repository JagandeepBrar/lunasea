import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliGlobalSettings extends StatelessWidget {
    @override
    Widget build(BuildContext context) => LSIconButton(
        icon: Icons.more_vert,
        onPressed: () async => _handler(context),
    );

    Future<void> _handler(BuildContext context) async {
        List values = await TautulliDialogs.globalSettings(context);
        if(values[0]) switch(values[1] as TautulliGlobalSettingsType) {
            case TautulliGlobalSettingsType.WEB_GUI: _webGUI(context); break;
            case TautulliGlobalSettingsType.BACKUP_CONFIG: _backupConfig(context); break;
            case TautulliGlobalSettingsType.BACKUP_DB: _backupDB(context); break;
            default: Logger.warning('TautulliGlobalSettings', '_handler', 'Unknown case: ${(values[1] as TautulliGlobalSettings)}');
        }
    }

    Future<void> _webGUI(BuildContext context) async => Provider.of<TautulliState>(context, listen: false).host.lsLinks_OpenLink();

    Future<void> _backupConfig(BuildContext context) async {
        Provider.of<TautulliState>(context, listen: false).api.system.backupConfig()
        .then((_) => LSSnackBar(
            context: context,
            title: 'Backing Up Configuration...',
            message: 'Backing up your configuration in the background',
        ))
        .catchError((error, trace) {
            Logger.error(
                'Tautulli',
                '_backupConfig',
                'Failed to backup configuration',
                error,
                trace,
                uploadToSentry: !(error is DioError),
            );
            LSSnackBar(
                context: context,
                title: 'Failed to Backup Configuration',
                type: SNACKBAR_TYPE.failure,
            );
        });
    }

    Future<void> _backupDB(BuildContext context) async {
        Provider.of<TautulliState>(context, listen: false).api.system.backupDB()
        .then((_) => LSSnackBar(
            context: context,
            title: 'Backing Up Database...',
            message: 'Backing up your database in the background',
        ))
        .catchError((error, trace) {
            Logger.error(
                'Tautulli',
                '_backupDB',
                'Failed to backup database',
                error,
                trace,
                uploadToSentry: !(error is DioError),
            );
            LSSnackBar(
                context: context,
                title: 'Failed to Backup Database',
                type: SNACKBAR_TYPE.failure,
            );
        });
    }
}