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
        Sonarr _sonarr = Provider.of<SonarrState>(context, listen: false).api;
        if(_sonarr != null) _sonarr.command.refreshSeries()
        .then((_) {
            LSSnackBar(
                context: context,
                title: 'Updating Library${Constants.TEXT_ELLIPSIS}',
                message: 'Updating library in the background',
            );
        })
        .catchError((error, stack) {
            LunaLogger.error(
                'SonarrAppBarGlobalSettingsAction',
                '_updateLibrary',
                'Unable to update library',
                error,
                stack,
                uploadToSentry: !(error is DioError),
            );
            LSSnackBar(
                context: context,
                title: 'Failed to Update Library',
                type: SNACKBAR_TYPE.failure,
            );
        });
    }

    Future<void> _runRSSSync(BuildContext context) async {
        Sonarr _sonarr = Provider.of<SonarrState>(context, listen: false).api;
        if(_sonarr != null) _sonarr.command.rssSync()
        .then((_) {
            LSSnackBar(
                context: context,
                title: 'Running RSS Sync${Constants.TEXT_ELLIPSIS}',
                message: 'Running RSS sync in the background',
            );
        })
        .catchError((error, stack) {
            LunaLogger.error(
                'SonarrAppBarGlobalSettingsAction',
                '_runRSSSync',
                'Unable to run RSS sync',
                error,
                stack,
                uploadToSentry: !(error is DioError),
            );
            LSSnackBar(
                context: context,
                title: 'Failed to Run RSS Sync',
                type: SNACKBAR_TYPE.failure,
            );
        });
    }

    Future<void> _searchAllMissing(BuildContext context) async {
        Sonarr _sonarr = Provider.of<SonarrState>(context, listen: false).api;
        if(_sonarr != null) {
            List _values = await SonarrDialogs.searchAllMissingEpisodes(context);
            if(_values[0]) _sonarr.command.missingEpisodeSearch()
            .then((_) {
                LSSnackBar(
                    context: context,
                    title: 'Searching${Constants.TEXT_ELLIPSIS}',
                    message: 'Searching for all missing episodes',
                );
            })
            .catchError((error, stack) {
                LunaLogger.error(
                    'SonarrAppBarGlobalSettingsAction',
                    '_searchAllMissing',
                    'Unable to search for all missing episodes',
                    error,
                    stack,
                    uploadToSentry: !(error is DioError),
                );
                LSSnackBar(
                    context: context,
                    title: 'Failed to Search',
                    type: SNACKBAR_TYPE.failure,
                );
            });
        }
    }

    Future<void> _backupDatabase(BuildContext context) async {
        Sonarr _sonarr = Provider.of<SonarrState>(context, listen: false).api;
        if(_sonarr != null) _sonarr.command.backup()
        .then((_) {
            LSSnackBar(
                context: context,
                title: 'Backing Up Database${Constants.TEXT_ELLIPSIS}',
                message: 'Backing up the database in the background',
            );
        })
        .catchError((error, stack) {
            LunaLogger.error(
                'SonarrAppBarGlobalSettingsAction',
                '_backupDatabase',
                'Unable to backup database',
                error,
                stack,
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
