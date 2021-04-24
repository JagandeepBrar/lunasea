import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lunasea/core.dart';

enum LunaSnackbarType {
  SUCCESS,
  ERROR,
  INFO,
}

extension LunaSnackbarTypeExtension on LunaSnackbarType {
  Color get color {
    switch (this) {
      case LunaSnackbarType.SUCCESS:
        return LunaColours.accent;
      case LunaSnackbarType.ERROR:
        return LunaColours.red;
      case LunaSnackbarType.INFO:
        return LunaColours.blue;
      default:
        return LunaColours.purple;
    }
  }

  IconData get icon {
    switch (this) {
      case LunaSnackbarType.SUCCESS:
        return Icons.check_circle_outline;
      case LunaSnackbarType.ERROR:
        return Icons.error_outline;
      case LunaSnackbarType.INFO:
        return Icons.info_outline;
      default:
        return Icons.help_outline;
    }
  }
}

const _PADDING = 8.0;

Future<void> showLunaSnackBar({
  @required String title,
  @required LunaSnackbarType type,
  @required String message,
  Duration duration,
  FlashPosition position = FlashPosition.bottom,
  bool showButton = false,
  String buttonText = 'view',
  Function buttonOnPressed,
}) async =>
    showFlash(
      context: LunaState.navigatorKey.currentContext,
      duration:
          duration != null ? duration : Duration(seconds: showButton ? 4 : 2),
      builder: (context, controller) => Flash(
        backgroundColor: Theme.of(context).primaryColor,
        controller: controller,
        style: FlashStyle.floating,
        boxShadows: [
          BoxShadow(
              blurRadius: 6.0,
              spreadRadius: 4.0,
              color: Colors.black.withOpacity(0.10))
        ],
        horizontalDismissDirection: HorizontalDismissDirection.horizontal,
        margin: EdgeInsets.all(_PADDING),
        position: position,
        borderRadius: BorderRadius.circular(LunaUI.BORDER_RADIUS),
        borderColor:
            LunaUI.shouldUseBorder ? Colors.white12 : Colors.transparent,
        child: FlashBar(
          title: Text(
            title,
            style: TextStyle(
              fontWeight: LunaUI.FONT_WEIGHT_BOLD,
              fontSize: LunaUI.FONT_SIZE_TITLE,
            ),
          ),
          message: Text(
            message,
            style: TextStyle(
              color: Colors.white70,
              fontSize: LunaUI.FONT_SIZE_SUBTITLE,
            ),
          ),
          icon: Padding(
            child: LunaIconButton(
              icon: type.icon,
              color: type.color,
            ),
            padding: EdgeInsets.only(left: _PADDING),
          ),
          primaryAction: showButton
              ? TextButton(
                  child: Text(
                    buttonText.toUpperCase(),
                    style: TextStyle(
                      fontWeight: LunaUI.FONT_WEIGHT_BOLD,
                      color: LunaColours.accent,
                    ),
                  ),
                  onPressed: () {
                    HapticFeedback.lightImpact();
                    controller.dismiss();
                    buttonOnPressed();
                  },
                )
              : null,
        ),
      ),
    );
