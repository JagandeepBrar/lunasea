
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

void showLunaErrorSnackBar({
    @required String title,
    dynamic error,
    String message,
}) {
    unawaited(showLunaSnackBar(
        title: title,
        message: message ?? LunaLogger.checkLogsMessage,
        type: LunaSnackbarType.ERROR,
        showButton: error != null,
        buttonOnPressed: () async => LunaDialogs().textPreview(LunaState.navigatorKey.currentContext, 'Error', error.toString()),
    ));
}
