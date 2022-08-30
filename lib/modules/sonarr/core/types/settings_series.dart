import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';
import 'package:lunasea/router/router.dart';
import 'package:lunasea/router/routes/sonarr.dart';

enum SonarrSeriesSettingsType {
  SEARCH,
  EDIT,
  REFRESH,
  DELETE,
  MONITORED,
}

extension SonarrSeriesSettingsTypeExtension on SonarrSeriesSettingsType {
  IconData icon(SonarrSeries series) {
    switch (this) {
      case SonarrSeriesSettingsType.MONITORED:
        return series.monitored!
            ? Icons.turned_in_not_rounded
            : Icons.turned_in_rounded;
      case SonarrSeriesSettingsType.EDIT:
        return Icons.edit_rounded;
      case SonarrSeriesSettingsType.REFRESH:
        return Icons.refresh_rounded;
      case SonarrSeriesSettingsType.DELETE:
        return Icons.delete_rounded;
      case SonarrSeriesSettingsType.SEARCH:
        return LunaIcons.SEARCH;
    }
  }

  String name(SonarrSeries series) {
    switch (this) {
      case SonarrSeriesSettingsType.MONITORED:
        return series.monitored!
            ? 'sonarr.UnmonitorSeries'.tr()
            : 'sonarr.MonitorSeries'.tr();
      case SonarrSeriesSettingsType.EDIT:
        return 'sonarr.EditSeries'.tr();
      case SonarrSeriesSettingsType.REFRESH:
        return 'sonarr.RefreshSeries'.tr();
      case SonarrSeriesSettingsType.DELETE:
        return 'sonarr.RemoveSeries'.tr();
      case SonarrSeriesSettingsType.SEARCH:
        return 'sonarr.SearchMonitored'.tr();
    }
  }

  Future<void> execute(BuildContext context, SonarrSeries series) async {
    switch (this) {
      case SonarrSeriesSettingsType.EDIT:
        SonarrRoutes.SERIES_EDIT.go(params: {'series': series.id!.toString()});
        break;
      case SonarrSeriesSettingsType.REFRESH:
        await SonarrAPIController().refreshSeries(
          context: context,
          series: series,
        );
        break;
      case SonarrSeriesSettingsType.DELETE:
        bool result = await SonarrDialogs().removeSeries(context);
        if (result) {
          await SonarrAPIController()
              .removeSeries(context: context, series: series)
              .then((_) => LunaRouter().popSafely());
        }
        break;
      case SonarrSeriesSettingsType.MONITORED:
        await SonarrAPIController().toggleSeriesMonitored(
          context: context,
          series: series,
        );
        break;
      case SonarrSeriesSettingsType.SEARCH:
        await SonarrAPIController()
            .seriesSearch(context: context, series: series);
        break;
    }
  }
}
