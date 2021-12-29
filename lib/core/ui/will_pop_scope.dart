import 'package:flutter/material.dart';

class LunaWillPopScope extends WillPopScope {
  LunaWillPopScope({
    Key? key,
    required GlobalKey<ScaffoldState> scaffoldKey,
    required Widget child,
  }) : super(
          key: key,
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
