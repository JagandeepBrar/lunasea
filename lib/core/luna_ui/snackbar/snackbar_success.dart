
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

Future<void> showLunaSuccessSnackBar({
    // Not needed anymore, but keeping it to prevent breaking all instances for now
    BuildContext context,
    @required String title,
    @required String message,
    bool showButton = false,
    String buttonText = 'view',
    Function buttonOnPressed,
}) async => showLunaSnackBar(
    title: title,
    message: message,
    type: LunaSnackbarType.SUCCESS,
    showButton: showButton,
    buttonText: buttonText,
    buttonOnPressed: buttonOnPressed,
);
