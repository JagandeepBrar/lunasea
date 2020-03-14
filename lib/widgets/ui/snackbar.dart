import 'package:flutter/material.dart';
import 'package:flushbar/flushbar.dart';
import 'package:lunasea/widgets/ui.dart';

enum SNACKBAR_TYPE {
    success,
    failure,
    info,
}

// ignore: non_constant_identifier_names
Future<void> LSSnackBar({
    @required BuildContext context,
    @required String message,
    String title,
    Duration duration = const Duration(seconds: 3),
    SNACKBAR_TYPE type = SNACKBAR_TYPE.info,
}) async {
    Color color;
    IconData icon;
    switch(type) {
        case SNACKBAR_TYPE.failure: color = LSColors.red; icon = Icons.error_outline; break;
        case SNACKBAR_TYPE.success: color = LSColors.accent; icon = Icons.check_circle_outline; break;
        case SNACKBAR_TYPE.info: color = LSColors.blue; icon = Icons.info_outline; break;
    }
    Flushbar(
        title: title,
        message: message,
        duration: duration,
        flushbarStyle: FlushbarStyle.FLOATING,
        margin: EdgeInsets.all(8),
        borderRadius: 8,
        icon: LSIconButton(
            icon: icon,
            color: color,
        ),
        animationDuration: Duration(milliseconds: 375),
        backgroundColor: LSColors.secondary,
    )..show(context);
}
