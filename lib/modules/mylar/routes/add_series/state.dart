import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/mylar.dart';

class MylarAddSeriesState extends ChangeNotifier {
  MylarAddSeriesState(BuildContext context, String query) {
    _searchQuery = query;
    fetchExclusions(context);
  }

  late String _searchQuery;
  String get searchQuery => _searchQuery;
  set searchQuery(String searchQuery) {
    _searchQuery = searchQuery;
    notifyListeners();
  }

  Future<List<MylarSeries>>? _lookup;
  Future<List<MylarSeries>>? get lookup => _lookup;
  void fetchLookup(BuildContext context) {
    if (context.read<MylarState>().enabled) {
      _lookup =
          context.read<MylarState>().api!.seriesLookup.get(term: _searchQuery);
    }
    notifyListeners();
  }

  Future<List<MylarExclusion>>? _exclusions;
  Future<List<MylarExclusion>>? get exclusions => _exclusions;
  void fetchExclusions(BuildContext context) {
    if ((context.read<MylarState>().enabled)) {
      _exclusions = context.read<MylarState>().api!.importList.get();
    }
    notifyListeners();
  }
}
