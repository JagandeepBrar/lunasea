import 'package:flutter/material.dart';

class OmbiState extends ChangeNotifier {
    OmbiState() {
        reset(initialize: true);
    }

    /// Reset the state of Ombi back to the default
    /// 
    /// If `initialize` is true, resets everything, else it resets the profile + data.
    /// If false, the navigation index, etc. are not reset.
    void reset({ bool initialize = false }) {
        if(initialize) {}
        notifyListeners();
    }

    GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();
    GlobalKey<ScaffoldState> rootScaffoldKey = GlobalKey<ScaffoldState>();
}
