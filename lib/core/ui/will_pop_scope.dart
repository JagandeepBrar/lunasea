import 'package:flutter/material.dart';

class LunaWillPopScope extends WillPopScope {
  LunaWillPopScope({
    @required GlobalKey<ScaffoldState> scaffoldKey,
    @required Widget child,
  }) : super(
          onWillPop: () async {
            if (scaffoldKey?.currentState?.hasDrawer ?? false) {
              if (scaffoldKey?.currentState?.isDrawerOpen ?? false) return true;
              scaffoldKey?.currentState?.openDrawer();
              return false;
            }
            return true;
          },
          child: child,
        );
}
