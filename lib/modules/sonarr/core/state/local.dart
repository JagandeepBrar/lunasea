import 'package:flutter/material.dart';

class SonarrLocalState extends ChangeNotifier {
    String _homeSearchQuery = '';
    String get homeSearchQuery => _homeSearchQuery;
    set homeSearchQuery(String homeSearchQuery) {
        assert(homeSearchQuery != null);
        _homeSearchQuery = homeSearchQuery;
        notifyListeners();
    }
}
