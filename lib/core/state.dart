import 'package:flutter/foundation.dart';

class LunaSeaState extends ChangeNotifier {
    LunaSeaState() {
        reset();
    }

    /// Reset the entire state of LunaSea back to the default
    void reset() {
        notifyListeners();
    }
}
