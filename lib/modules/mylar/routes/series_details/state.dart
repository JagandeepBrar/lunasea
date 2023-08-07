import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/mylar.dart';

class MylarSeriesDetailsState extends ChangeNotifier {
  final MylarSeries series;

  MylarSeriesDetailsState({
    required BuildContext context,
    required this.series,
  }) {
    fetchHistory(context);
  }

  Future<void> fetchHistory(BuildContext context) async {
    MylarState state = context.read<MylarState>();
    if (state.enabled) {
      _history = state.api!.history.getBySeries(
        seriesId: series.id!,
        includeEpisode: true,
      );
    }
    notifyListeners();
    await _history;
  }

  Future<List<MylarHistoryRecord>>? _history;
  Future<List<MylarHistoryRecord>>? get history => _history;
}
