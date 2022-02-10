import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/readarr.dart';

class ReadarrAddSeriesState extends ChangeNotifier {
  ReadarrAddSeriesState(BuildContext context, String query) {
    _searchQuery = query;
    fetchExclusions(context);
  }

  late String _searchQuery;
  String get searchQuery => _searchQuery;
  set searchQuery(String searchQuery) {
    _searchQuery = searchQuery;
    notifyListeners();
  }

  Future<List<ReadarrAuthor>>? _lookup;
  Future<List<ReadarrAuthor>>? get lookup => _lookup;
  void fetchLookup(BuildContext context) {
    if (context.read<ReadarrState>().enabled) {
      _lookup = context
          .read<ReadarrState>()
          .api!
          .authorLookup
          .get(term: _searchQuery);
    }
    notifyListeners();
  }

  Future<List<ReadarrExclusion>>? _exclusions;
  Future<List<ReadarrExclusion>>? get exclusions => _exclusions;
  void fetchExclusions(BuildContext context) {
    if ((context.read<ReadarrState>().enabled)) {
      _exclusions = context.read<ReadarrState>().api!.importList.get();
    }
    notifyListeners();
  }
}
