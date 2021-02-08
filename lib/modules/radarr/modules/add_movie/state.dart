import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrAddMovieState extends ChangeNotifier {
    RadarrAddMovieState(BuildContext context) {
        context.read<RadarrState>().lookup = null;
    }

    String _searchQuery = '';
    String get searchQuery => _searchQuery;
    set searchQuery(String searchQuery) {
        assert(searchQuery != null);
        _searchQuery = searchQuery;
        notifyListeners();
    }

    Future<List<RadarrExclusion>> exclusions;

    void executeSearch(BuildContext context) {
        fetchLookup(context, notify: false);
        fetchExclusions(context, notify: false);
        notifyListeners();
    }

    void fetchLookup(BuildContext context, { bool notify = true }) {
        if((context?.read<RadarrState>()?.enabled ?? false)) context.read<RadarrState>().fetchLookup(_searchQuery ?? '');
        if(notify) notifyListeners();
    }

    void fetchExclusions(BuildContext context, { bool notify = true }) {
        if((context?.read<RadarrState>()?.enabled ?? false)) exclusions = context.read<RadarrState>().api.exclusions.getAll();
        if(notify) notifyListeners();
    }
}
