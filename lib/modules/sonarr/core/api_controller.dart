import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrAPIController {
  Future<bool> toggleMonitored({
    @required BuildContext context,
    @required SonarrSeries series,
    bool showSnackbar = true,
  }) async {
    assert(SerialTapGestureRecognizer != null);
    if (context.read<SonarrState>().enabled) {
      SonarrSeries seriesCopy = series.clone();
      seriesCopy.monitored = !series.monitored;
      return await context
          .read<SonarrState>()
          .api
          .series
          .update(series: seriesCopy)
          .then((data) async {
        return await context
            .read<SonarrState>()
            .setSingleSeries(seriesCopy)
            .then((_) {
          if (showSnackbar) {
            showLunaSuccessSnackBar(
              title: seriesCopy.monitored
                  ? 'sonarr.Monitoring'.tr()
                  : 'sonarr.NoLongerMonitoring'.tr(),
              message: seriesCopy.title,
            );
          }
          return true;
        });
      }).catchError((error, stack) {
        LunaLogger().error(
          'Unable to toggle monitored state: ${series.monitored.toString()} to ${seriesCopy.monitored.toString()}',
          error,
          stack,
        );
        if (showSnackbar)
          showLunaErrorSnackBar(
            title: series.monitored
                ? 'sonarr.FailedToUnmonitorSeries'.tr()
                : 'sonarr.FailedToMonitorSeries'.tr(),
            error: error,
          );
        return false;
      });
    }
    return false;
  }

  Future<bool> addTag({
    @required BuildContext context,
    @required String label,
    bool showSnackbar = true,
  }) async {
    assert(label != null);
    if (context.read<SonarrState>().enabled) {
      return await context
          .read<SonarrState>()
          .api
          .tag
          .create(label: label)
          .then((tag) {
        showLunaSuccessSnackBar(
          title: 'sonarr.AddedTag'.tr(),
          message: tag.label,
        );
        return true;
      }).catchError((error, stack) {
        LunaLogger().error('Failed to add tag: $label', error, stack);
        if (showSnackbar)
          showLunaErrorSnackBar(
            title: 'sonarr.FailedToAddTag'.tr(),
            error: error,
          );
        return false;
      });
    }
    return false;
  }

  Future<bool> updateSeries({
    @required BuildContext context,
    @required SonarrSeries series,
    bool showSnackbar = true,
  }) async {
    assert(series != null);
    if (context.read<SonarrState>().enabled) {
      return await context
          .read<SonarrState>()
          .api
          .series
          .update(series: series)
          .then((_) async {
        return await context
            .read<SonarrState>()
            .setSingleSeries(series)
            .then((_) {
          if (showSnackbar) {
            showLunaSuccessSnackBar(
              title: 'sonarr.UpdatedSeries'.tr(),
              message: series.title,
            );
          }
          return true;
        });
      }).catchError((error, stack) {
        LunaLogger().error(
          'Failed to update series: ${series.id}',
          error,
          stack,
        );
        showLunaErrorSnackBar(
          title: 'sonarr.FailedToUpdateSeries'.tr(),
          error: error,
        );
        return false;
      });
    }
    return true;
  }

  Future<bool> backupDatabase({
    @required BuildContext context,
    bool showSnackbar = true,
  }) async {
    if (context.read<SonarrState>().enabled) {
      return await context.read<SonarrState>().api.command.backup().then((_) {
        if (showSnackbar) {
          showLunaSuccessSnackBar(
            title: 'sonarr.BackingUpDatabase'.tr(args: [LunaUI.TEXT_ELLIPSIS]),
            message: 'sonarr.BackingUpDatabaseDescription'.tr(),
          );
        }
        return true;
      }).catchError((error, stack) {
        LunaLogger().error(
          'Sonarr: Unable to backup database',
          error,
          stack,
        );
        if (showSnackbar)
          showLunaErrorSnackBar(
            title: 'sonarr.FailedToBackupDatabase'.tr(),
            error: error,
          );
        return false;
      });
    }
    return false;
  }

  Future<bool> runRSSSync({
    @required BuildContext context,
    bool showSnackbar = true,
  }) async {
    if (context.read<SonarrState>().enabled) {
      return await context.read<SonarrState>().api.command.rssSync().then((_) {
        if (showSnackbar)
          showLunaSuccessSnackBar(
            title: 'sonarr.RunningRSSSync'.tr(args: [LunaUI.TEXT_ELLIPSIS]),
            message: 'sonarr.RunningRSSSyncDescription'.tr(),
          );
        return true;
      }).catchError((error, stack) {
        LunaLogger().error(
          'Unable to run RSS sync',
          error,
          stack,
        );
        if (showSnackbar)
          showLunaErrorSnackBar(
            title: 'sonarr.FailedToRunRSSSync'.tr(),
            error: error,
          );
        return false;
      });
    }
    return false;
  }

  Future<bool> updateLibrary({
    @required BuildContext context,
    bool showSnackbar = true,
  }) async {
    if (context.read<SonarrState>().enabled) {
      return await context
          .read<SonarrState>()
          .api
          .command
          .refreshSeries()
          .then((_) {
        if (showSnackbar)
          showLunaSuccessSnackBar(
            title: 'sonarr.UpdatingLibrary'.tr(args: [LunaUI.TEXT_ELLIPSIS]),
            message: 'sonarr.UpdatingLibraryDescription'.tr(),
          );
        return true;
      }).catchError((error, stack) {
        LunaLogger().error(
          'Unable to update library',
          error,
          stack,
        );
        if (showSnackbar)
          showLunaErrorSnackBar(
            title: 'sonarr.FailedToUpdateLibrary'.tr(),
            error: error,
          );
        return false;
      });
    }
    return false;
  }

  Future<bool> missingEpisodesSearch({
    @required BuildContext context,
    bool showSnackbar = true,
  }) async {
    if (context.read<SonarrState>().enabled) {
      return await context
          .read<SonarrState>()
          .api
          .command
          .missingEpisodeSearch()
          .then((_) {
        if (showSnackbar)
          showLunaSuccessSnackBar(
            title: 'sonarr.Searching'.tr(args: [LunaUI.TEXT_ELLIPSIS]),
            message: 'sonarr.SearchingDescription'.tr(),
          );
        return true;
      }).catchError((error, stack) {
        LunaLogger().error(
          'Sonarr: Unable to search for all missing episodes',
          error,
          stack,
        );
        if (showSnackbar)
          showLunaErrorSnackBar(
            title: 'sonarr.FailedToSearch'.tr(),
            error: error,
          );
        return false;
      });
    }
    return false;
  }
}
