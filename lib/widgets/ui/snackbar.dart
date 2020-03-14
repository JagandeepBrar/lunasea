import 'package:flutter/material.dart';
import 'package:flushbar/flushbar.dart';
import 'package:lunasea/widgets/ui.dart';

// ignore: non_constant_identifier_names
Future<void> LSSnackBar({
    @required BuildContext context,
    @required String message,
    String title,
    Duration duration = const Duration(seconds: 3),
    bool failure = false,
}) async {
    Flushbar(
        title: title,
        message: message,
        duration: duration,
        flushbarStyle: FlushbarStyle.FLOATING,
        margin: EdgeInsets.all(8),
        borderRadius: 8,
        icon: LSIcon(
            icon: failure
                ? Icons.close
                : Icons.check,
            color: failure
                ? LSColors.red
                : LSColors.accent,
        ),
        animationDuration: Duration(milliseconds: 375),
        backgroundColor: LSColors.secondary,
    )..show(context);
}
