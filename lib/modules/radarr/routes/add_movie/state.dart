import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrAddMovieState extends ChangeNotifier {
  RadarrAddMovieState(BuildContext context, String query) {
    _searchQuery = query;
    fetchDiscovery(context);
    fetchExclusions(context);
  }

  late String _searchQuery;
  String get searchQuery => _searchQuery;
  set searchQuery(String searchQuery) {
    _searchQuery = searchQuery;
    notifyListeners();
  }

  Future<List<RadarrMovie>>? _lookup;
  Future<List<RadarrMovie>>? get lookup => _lookup;
  void fetchLookup(BuildContext context) {
    if ((context.read<RadarrState>().enabled)) {
      _lookup =
          context.read<RadarrState>().api!.movieLookup.get(term: _searchQuery);
    }
    notifyListeners();
  }

  Future<List<RadarrExclusion>>? _exclusions;
  Future<List<RadarrExclusion>>? get exclusions => _exclusions;
  void fetchExclusions(BuildContext context) {
    if ((context.read<RadarrState>().enabled)) {
      _exclusions = context.read<RadarrState>().api!.exclusions.getAll();
    }
    notifyListeners();
  }

  Future<List<RadarrMovie>>? _discovery;
  Future<List<RadarrMovie>>? get discovery => _discovery;
  void fetchDiscovery(BuildContext context) {
    if ((context.read<RadarrState>().enabled)) {
      _discovery = context.read<RadarrState>().api!.importList.getMovies(
          includeRecommendations:
              RadarrDatabase.ADD_DISCOVER_USE_SUGGESTIONS.read());
    }
    notifyListeners();
  }
}
