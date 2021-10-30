import 'package:flutter/material.dart';
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
        return series.monitored ? 'Unmonitor Series' : 'Monitor Series';
      case SonarrSeriesSettingsType.EDIT:
        return 'Edit Series';
      case SonarrSeriesSettingsType.REFRESH:
        return 'Refresh Series';
      case SonarrSeriesSettingsType.DELETE:
        return 'Remove Series';
    }
    throw Exception('Invalid SonarrSeriesSettingsType');
  }

  Future<void> execute(BuildContext context, SonarrSeries series) async {
    switch (this) {
      case SonarrSeriesSettingsType.EDIT:
      case SonarrSeriesSettingsType.REFRESH:
      case SonarrSeriesSettingsType.DELETE:
      case SonarrSeriesSettingsType.MONITORED:
        // TODO
        return;
    }
    throw Exception('Invalid SonarrSeriesSettingsType');
  }
}
