import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/widgets/ui.dart';

class Notifications {
    Notifications._();
    
    static Widget centeredMessage(String message, {bool showBtn = false, String btnMessage = '', Function onTapHandler}) {
        return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
                Card(
                    child: Row(
                        children: <Widget>[
                            Expanded(
                                child: Container(
                                    child: Text(
                                        message,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18.0,
                                        ),
                                    ),
                                    margin: EdgeInsets.symmetric(vertical: 24.0),
                                ),
                            ),
                        ],
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                    elevation: 4.0,
                ),
                showBtn
                    ? LSButton(text: btnMessage, onTap: onTapHandler)
                    : Container()
            ],
        );
    }
    
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
                elevation: 4.0,
            )
        );
    }
}