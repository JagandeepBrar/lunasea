import 'package:lunasea/extensions/string/string.dart';
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
      message: message.uiSafe(),
      type: LunaSnackbarType.INFO,
      showButton: showButton,
      buttonText: buttonText,
      buttonOnPressed: buttonOnPressed,
    );
