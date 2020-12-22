
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

Future<void> showLunaErrorSnackBar({
    @required BuildContext context,
    @required String title,
    dynamic error,
    String message = LunaLogger.CHECK_LOGS_MESSAGE,
}) async => showLunaSnackBar(
    context: context,
    title: title,
    message: message,
    type: LunaSnackbarType.ERROR,
    showButton: error != null,
    buttonOnPressed: () async => LunaDialogs().textPreview(context, 'Error', error.toString()),
);
