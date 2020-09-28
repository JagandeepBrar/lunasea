import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class SettingsState extends LunaGlobalState {
    @override
    void reset() {}
    
    GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();
    GlobalKey<ScaffoldState> rootScaffoldKey = GlobalKey<ScaffoldState>();
}
