import 'package:lunasea/core.dart';

Future<void> showLunaErrorSnackBar({
  required String title,
  dynamic error,
  String? message,
  bool showButton = false,
  String buttonText = 'view',
  Function? buttonOnPressed,
}) async =>
    showLunaSnackBar(
      title: title,
      message: message ?? LunaLogger.checkLogsMessage,
      type: LunaSnackbarType.ERROR,
      showButton: error != null || showButton,
      buttonText: buttonText,
      buttonOnPressed: () async {
        if (error != null) {
          LunaDialogs().textPreview(
            LunaState.context,
            'Error',
            error.toString(),
          );
        } else if (buttonOnPressed != null) {
          buttonOnPressed();
        }
      },
    );
