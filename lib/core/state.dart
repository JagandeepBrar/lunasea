import 'package:flutter/foundation.dart';

class LunaState extends ChangeNotifier {
    LunaState() {
        reset(initialize: true);
    }

    /// Reset the state of LunaSea back to the default
    void reset({ bool initialize = false }) {
        if(initialize) {}
        notifyListeners();
    }
}
