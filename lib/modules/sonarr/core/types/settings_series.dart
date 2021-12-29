import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

enum SonarrSeriesSettingsType {
  EDIT,
  REFRESH,
  DELETE,
  MONITORED,
}

extension SonarrSeriesSettingsTypeExtension on SonarrSeriesSettingsType? {
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
    }
    throw Exception('Invalid SonarrSeriesSettingsType');
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
    }
    throw Exception('Invalid SonarrSeriesSettingsType');
  }

  Future<void> execute(BuildContext context, SonarrSeries series) async {
    switch (this) {
      case SonarrSeriesSettingsType.EDIT:
        return SonarrEditSeriesRouter()
            .navigateTo(context, seriesId: series.id);
      case SonarrSeriesSettingsType.REFRESH:
        return SonarrAPIController()
            .refreshSeries(context: context, series: series);
      case SonarrSeriesSettingsType.DELETE:
        bool result = await SonarrDialogs().removeSeries(context);
        if (result) {
          SonarrAPIController()
              .removeSeries(context: context, series: series)
              .then((_) => Navigator.of(context).lunaSafetyPop());
        }
        return;
      case SonarrSeriesSettingsType.MONITORED:
        return SonarrAPIController().toggleSeriesMonitored(
          context: context,
          series: series,
        );
    }
    throw Exception('Invalid SonarrSeriesSettingsType');
  }
}
