import 'package:flutter/material.dart';

class LunaWillPopScope extends WillPopScope {
    LunaWillPopScope({
        @required GlobalKey<ScaffoldState> scaffoldKey,
        @required Widget child,
    }) : super(
        onWillPop: () async {
            bool state;
            if(scaffoldKey?.currentState?.isDrawerOpen ?? false) {
                state = true;
            } else {
                state = false;
                scaffoldKey?.currentState?.openDrawer();
            }
            FocusManager.instance.primaryFocus?.unfocus();
            return state;
        },
        child: child,
    );
}
