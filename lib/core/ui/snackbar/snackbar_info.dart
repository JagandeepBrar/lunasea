import 'package:lunasea/core.dart';

Future<void> showLunaInfoSnackBar({
  required String title,
  required String? message,
  bool showButton = false,
  String buttonText = 'view',
  Function? buttonOnPressed,
}) async =>
    showLunaSnackBar(
      title: title,
      message: message.lunaSafe(),
      type: LunaSnackbarType.INFO,
      showButton: showButton,
      buttonText: buttonText,
      buttonOnPressed: buttonOnPressed,
    );
