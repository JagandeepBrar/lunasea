
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

void showLunaSuccessSnackBar({
    @required String title,
    @required String message,
    bool showButton = false,
    String buttonText = 'view',
    Function buttonOnPressed,
}) async {
    unawaited(showLunaSnackBar(
        title: title,
        message: message,
        type: LunaSnackbarType.SUCCESS,
        showButton: showButton,
        buttonText: buttonText,
        buttonOnPressed: buttonOnPressed,
    ));
}
