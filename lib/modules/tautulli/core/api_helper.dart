import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliAPIHelper {
    /// Backup Tautulli's configuration.
    Future<bool> backupConfiguration({
        @required BuildContext context,
        bool showSnackbar = true,
    }) async {
        if(context.read<TautulliState>().enabled) {
            return await context.read<TautulliState>().api.system.backupConfig()
            .then((_) {
                if(showSnackbar) showLunaSuccessSnackBar(title: 'Backing Up Configuration${Constants.TEXT_ELLIPSIS}', message: 'Backing up your configuration in the background');
                return true;
            })
            .catchError((error, trace) {
                LunaLogger().error('Failed to backup configuration', error, trace);
                if(showSnackbar) showLunaErrorSnackBar(title: 'Failed to Backup Configuration', error: error);
                return false;
            });
        }
        return false;
    }

    /// Backup Tautulli's database.
    Future<bool> backupDatabase({
        @required BuildContext context,
        bool showSnackbar = true,
    }) async {
        if(context.read<TautulliState>().enabled) {
            return await context.read<TautulliState>().api.system.backupDB()
            .then((_) {
                if(showSnackbar) showLunaSuccessSnackBar(title: 'Backing Up Database${Constants.TEXT_ELLIPSIS}', message: 'Backing up your database in the background');
                return true;
            })
            .catchError((error, trace) {
                LunaLogger().error('Failed to backup database', error, trace);
                if(showSnackbar) showLunaErrorSnackBar(title: 'Failed to Backup Database', error: error);
                return false;
            });
        }
        return false;
    }

    /// Delete cache.
    Future<bool> deleteCache({
        @required BuildContext context,
        bool showSnackbar = true,
    }) async {
        if(context.read<TautulliState>().enabled) {
            return await context.read<TautulliState>().api.system.deleteCache()
            .then((_) {
                if(showSnackbar) showLunaSuccessSnackBar(title: 'Deleting Cache${Constants.TEXT_ELLIPSIS}', message: 'Tautulli cache is being deleted');
                return true;
            })
            .catchError((error, trace) {
                LunaLogger().error('Failed to delete cache', error, trace);
                if(showSnackbar) showLunaErrorSnackBar(title: 'Failed to Delete Cache', error: error);
                return false;
            });
        }
        return false;
    }

    /// Delete image cache.
    Future<bool> deleteImageCache({
        @required BuildContext context,
        bool showSnackbar = true,
    }) async {
        if(context.read<TautulliState>().enabled) {
            return await context.read<TautulliState>().api.system.deleteImageCache()
            .then((_) {
                if(showSnackbar) showLunaSuccessSnackBar(title: 'Deleting Image Cache${Constants.TEXT_ELLIPSIS}', message: 'Tautulli image cache is being deleted');
                return true;
            })
            .catchError((error, trace) {
                LunaLogger().error('Failed to delete image cache', error, trace);
                if(showSnackbar) showLunaErrorSnackBar(title: 'Failed to Delete Image Cache', error: error);
                return false;
            });
        }
        return false;
    }

    /// Delete temporary sessions.
    Future<bool> deleteTemporarySessions({
        @required BuildContext context,
        bool showSnackbar = true,
    }) async {
        if(context.read<TautulliState>().enabled) {
            return await context.read<TautulliState>().api.activity.deleteTempSessions()
            .then((_) {
                if(showSnackbar) showLunaSuccessSnackBar(title: 'Deleting Temporary Sessions${Constants.TEXT_ELLIPSIS}', message: 'Temporary sessions are being deleted');
                return true;
            })
            .catchError((error, trace) {
                LunaLogger().error('Failed to delete temporary sessions', error, trace);
                if(showSnackbar) showLunaErrorSnackBar(title: 'Failed to Delete Temporary Sessions', error: error);
                return false;
            });
        }
        return false;
    }
}
