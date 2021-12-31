import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrSeriesDetailsState extends ChangeNotifier {
  final SonarrSeries series;

  SonarrSeriesDetailsState({
    required BuildContext context,
    required this.series,
  }) {
    fetchHistory(context);
  }

  Future<void> fetchHistory(BuildContext context) async {
    SonarrState state = context.read<SonarrState>();
    if (state.enabled) {
      _history = state.api!.history.getBySeries(
        seriesId: series.id!,
        includeEpisode: true,
      );
    }
    notifyListeners();
    await _history;
  }

  Future<List<SonarrHistoryRecord>>? _history;
  Future<List<SonarrHistoryRecord>>? get history => _history;
}
