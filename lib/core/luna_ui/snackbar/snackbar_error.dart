
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

Future<void> showLunaErrorSnackBar({
    // Not needed anymore, but keeping it to prevent breaking all instances for now
    BuildContext context,
    @required String title,
    dynamic error,
    String message = LunaLogger.CHECK_LOGS_MESSAGE,
}) async => showLunaSnackBar(
    title: title,
    message: message,
    type: LunaSnackbarType.ERROR,
    showButton: error != null,
    buttonOnPressed: () async => LunaDialogs().textPreview(LunaState.navigatorKey.currentContext, 'Error', error.toString()),
);
