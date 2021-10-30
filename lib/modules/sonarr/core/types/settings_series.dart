import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

enum SonarrSeriesSettingsType {
  EDIT,
  REFRESH,
  DELETE,
  MONITORED,
}

extension SonarrSeriesSettingsTypeExtension on SonarrSeriesSettingsType {
  IconData icon(SonarrSeries series) {
    switch (this) {
      case SonarrSeriesSettingsType.MONITORED:
        return series.monitored ? Icons.turned_in_not : Icons.turned_in;
      case SonarrSeriesSettingsType.EDIT:
        return Icons.edit;
      case SonarrSeriesSettingsType.REFRESH:
        return Icons.refresh;
      case SonarrSeriesSettingsType.DELETE:
        return Icons.delete;
    }
    throw Exception('Invalid SonarrSeriesSettingsType');
  }

  String name(SonarrSeries series) {
    switch (this) {
      case SonarrSeriesSettingsType.MONITORED:
        return series.monitored
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
        return _edit(context, series);
      case SonarrSeriesSettingsType.REFRESH:
      case SonarrSeriesSettingsType.DELETE:
      case SonarrSeriesSettingsType.MONITORED:
        return _monitored(context, series);
    }
    throw Exception('Invalid SonarrSeriesSettingsType');
  }

  Future<void> _edit(BuildContext context, SonarrSeries series) async =>
      SonarrEditSeriesRouter().navigateTo(context, seriesId: series.id);
  Future<void> _monitored(BuildContext context, SonarrSeries series) =>
      SonarrAPIController().toggleMonitored(context: context, series: series);
}
