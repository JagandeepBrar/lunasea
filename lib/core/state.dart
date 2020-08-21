import 'package:flutter/foundation.dart';

class LunaSeaState extends ChangeNotifier {
    LunaSeaState() {
        reset(initialize: true);
    }

    /// Reset the state of LunaSea back to the default
    void reset({ bool initialize = false }) {
        if(initialize) {}
        notifyListeners();
    }
}
