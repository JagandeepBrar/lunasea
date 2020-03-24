import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class Notifications {
    Notifications._();
    
    static void showSnackBar(GlobalKey<ScaffoldState> key, String message, {int duration = 1500}) {
        Duration snackBarDuration = Duration(milliseconds: duration);
        key?.currentState?.showSnackBar(
            SnackBar(
                content: Text(
                    message,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        letterSpacing: Constants.UI_LETTER_SPACING,
                    ),
                ),
                backgroundColor: Color(Constants.SECONDARY_COLOR),
                duration: snackBarDuration,
                elevation: 2.0,
            )
        );
    }
}