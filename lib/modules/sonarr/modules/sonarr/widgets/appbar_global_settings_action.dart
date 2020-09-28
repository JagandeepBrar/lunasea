import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrAppBarGlobalSettingsAction extends StatelessWidget {
    @override
    Widget build(BuildContext context) => LSIconButton(
        icon: Icons.more_vert,
        onPressed: () async => _handler(context),
    );

    Future<void> _handler(BuildContext context) async {
        List values = await SonarrDialogs.globalSettings(context);
        if(values[0]) switch(values[1] as SonarrGlobalSettingsType) {
            case SonarrGlobalSettingsType.WEB_GUI: _webGUI(context); break;
            case SonarrGlobalSettingsType.VIEW_QUEUE: _viewQueue(context); break;
            case SonarrGlobalSettingsType.UPDATE_LIBRARY: _updateLibrary(context); break;
            case SonarrGlobalSettingsType.RUN_RSS_SYNC: _runRSSSync(context); break;
            case SonarrGlobalSettingsType.SEARCH_ALL_MISSING: _searchAllMissing(context); break;
            case SonarrGlobalSettingsType.BACKUP_DATABASE: _backupDatabase(context); break;
            default: LunaLogger.warning('SonarrGlobalSettings', '_handler', 'Unknown case: ${(values[1] as SonarrGlobalSettingsType)}');
        }
    }

    Future<void> _webGUI(BuildContext context) async => Provider.of<SonarrState>(context, listen: false).host.lsLinks_OpenLink();

    Future<void> _viewQueue(BuildContext context) async => SonarrQueueRouter.navigateTo(context);

    Future<void> _updateLibrary(BuildContext context) async {
        //TODO
        LSSnackBar(
            context: context,
            title: 'Updating Library...',
            message: 'Updating library in the background',
            type: SNACKBAR_TYPE.info,
        );
    }

    Future<void> _runRSSSync(BuildContext context) async {
        //TODO
        LSSnackBar(
            context: context,
            title: 'Running RSS Sync...',
            message: 'Running RSS sync in the background',
            type: SNACKBAR_TYPE.info,
        );
    }

    Future<void> _searchAllMissing(BuildContext context) async {
        //TODO
    }

    Future<void> _backupDatabase(BuildContext context) async {
        //TODO
        LSSnackBar(
            context: context,
            title: 'Backing Up Database...',
            message: 'Backing up the database in the background',
            type: SNACKBAR_TYPE.info,
        );
    }
}
