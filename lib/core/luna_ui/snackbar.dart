export 'snackbar/snackbar_error.dart';
export 'snackbar/snackbar_info.dart';
export 'snackbar/snackbar_success.dart';
import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

enum LunaSnackbarType {
    SUCCESS,
    ERROR,
    INFO,
}

extension LunaSnackbarTypeExtension on LunaSnackbarType {
    Color get color {
        switch(this) {
            case LunaSnackbarType.SUCCESS: return LunaColours.accent;
            case LunaSnackbarType.ERROR: return LunaColours.red;
            case LunaSnackbarType.INFO: return LunaColours.blue;
            default: return LunaColours.purple;
        }
    }

    IconData get icon {
        switch(this) {
            case LunaSnackbarType.SUCCESS: return Icons.check_circle_outline;
            case LunaSnackbarType.ERROR: return Icons.error_outline;
            case LunaSnackbarType.INFO: return Icons.info_outline;
            default: return Icons.help_outline;
        }
    }
}

const _PADDING = 8.0;

Future<void> showLunaSnackBar({
    @required BuildContext context,
    @required String title,
    @required LunaSnackbarType type,
    @required String message,
    bool showButton = false,
    String buttonText = 'view',
    Function buttonOnPressed,
}) async => showFlash(
    context: context,
    duration: Duration(seconds: showButton ? 4 : 2),
    builder: (context, controller) => Flash(
        backgroundColor: Theme.of(context).primaryColor,
        controller: controller,
        style: FlashStyle.floating,
        boxShadows: [BoxShadow(blurRadius: 6.0, spreadRadius: 4.0, color: Colors.black.withOpacity(0.10))],
        horizontalDismissDirection: HorizontalDismissDirection.horizontal,
        margin: EdgeInsets.all(_PADDING),
        borderRadius: BorderRadius.circular(Constants.UI_BORDER_RADIUS),
        borderColor: LunaSeaDatabaseValue.THEME_AMOLED.data && LunaSeaDatabaseValue.THEME_AMOLED_BORDER.data
            ? Colors.white12
            : Colors.transparent,
        child: FlashBar(
            title: Text(
                title,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: Constants.UI_FONT_SIZE_TITLE,
                ),
            ),
            message: Text(
                message,
                style: TextStyle(
                    color: Colors.white70,
                    fontSize: Constants.UI_FONT_SIZE_SUBTITLE,
                ),
            ),
            icon: Padding(
                child: LSIconButton(
                    icon: type.icon,
                    color: type.color,
                ),
                padding: EdgeInsets.only(left: _PADDING),
            ),
            primaryAction: showButton
                ? FlatButton(
                    child: Text(
                        buttonText.toUpperCase(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                        ),
                    ),
                    textColor: LunaColours.accent,
                    onPressed: () {
                        controller.dismiss();
                        buttonOnPressed();
                    }
                )
            : null,
        ),
    ),
);
