import 'package:flutter/foundation.dart';

class SettingsModel extends ChangeNotifier {
    int _navigationIndex = 0;
    int get navigationIndex => _navigationIndex;
    set navigationIndex(int navigationIndex) {
        assert(navigationIndex != null);
        _navigationIndex = navigationIndex;
        notifyListeners();
    }
}
