import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrAppBarGlobalSettingsAction extends StatelessWidget {
    @override
    Widget build(BuildContext context) => LunaIconButton(
        icon: Icons.more_vert,
        onPressed: () async => _handler(context),
    );

    Future<void> _handler(BuildContext context) async {
        List values = await SonarrDialogs.globalSettings(context);
        if(values[0]) switch(values[1] as SonarrGlobalSettingsType) {
            case SonarrGlobalSettingsType.WEB_GUI: _webGUI(context); break;
            case SonarrGlobalSettingsType.VIEW_QUEUE: _viewQueue(context); break;
            case SonarrGlobalSettingsType.MANAGE_TAGS: _manageTags(context); break;
            case SonarrGlobalSettingsType.UPDATE_LIBRARY: _updateLibrary(context); break;
            case SonarrGlobalSettingsType.RUN_RSS_SYNC: _runRSSSync(context); break;
            case SonarrGlobalSettingsType.SEARCH_ALL_MISSING: _searchAllMissing(context); break;
            case SonarrGlobalSettingsType.BACKUP_DATABASE: _backupDatabase(context); break;
        }
    }

    Future<void> _webGUI(BuildContext context) async => Provider.of<SonarrState>(context, listen: false).host.lunaOpenGenericLink();

    Future<void> _viewQueue(BuildContext context) async => SonarrQueueRouter().navigateTo(context);

    Future<void> _manageTags(BuildContext context) async => SonarrTagsRouter().navigateTo(context);

    Future<void> _updateLibrary(BuildContext context) async {
        Sonarr _sonarr = Provider.of<SonarrState>(context, listen: false).api;
        if(_sonarr != null) _sonarr.command.refreshSeries()
        .then((_) {
            showLunaInfoSnackBar(
                title: 'Updating Library${LunaUI.TEXT_ELLIPSIS}',
                message: 'Updating library in the background',
            );
        })
        .catchError((error, stack) {
            LunaLogger().error('Unable to update library', error, stack);
            showLunaErrorSnackBar(
                title: 'Failed to Update Library',
                error: error,
            );
        });
    }

    Future<void> _runRSSSync(BuildContext context) async {
        Sonarr _sonarr = Provider.of<SonarrState>(context, listen: false).api;
        if(_sonarr != null) _sonarr.command.rssSync()
        .then((_) {
            showLunaInfoSnackBar(
                title: 'Running RSS Sync${LunaUI.TEXT_ELLIPSIS}',
                message: 'Running RSS sync in the background',
            );
        })
        .catchError((error, stack) {
            LunaLogger().error('Unable to run RSS sync', error, stack);
            showLunaErrorSnackBar(
                title: 'Failed to Run RSS Sync',
                error: error,
            );
        });
    }

    Future<void> _searchAllMissing(BuildContext context) async {
        Sonarr _sonarr = Provider.of<SonarrState>(context, listen: false).api;
        if(_sonarr != null) {
            List _values = await SonarrDialogs.searchAllMissingEpisodes(context);
            if(_values[0]) _sonarr.command.missingEpisodeSearch()
            .then((_) {
                showLunaInfoSnackBar(
                    title: 'Searching${LunaUI.TEXT_ELLIPSIS}',
                    message: 'Searching for all missing episodes',
                );
            })
            .catchError((error, stack) {
                LunaLogger().error('Unable to search for all missing episodes', error, stack);
                showLunaErrorSnackBar(
                    title: 'Failed to Search',
                    error: error,
                );
            });
        }
    }

    Future<void> _backupDatabase(BuildContext context) async {
        Sonarr _sonarr = Provider.of<SonarrState>(context, listen: false).api;
        if(_sonarr != null) _sonarr.command.backup()
        .then((_) {
            showLunaInfoSnackBar(
                title: 'Backing Up Database${LunaUI.TEXT_ELLIPSIS}',
                message: 'Backing up the database in the background',
            );
        })
        .catchError((error, stack) {
            LunaLogger().error('Unable to backup database', error, stack);
            showLunaErrorSnackBar(
                title: 'Failed to Backup Database',
                error: error,
            );
        });
    }
}
