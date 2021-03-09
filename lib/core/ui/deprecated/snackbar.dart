import 'package:flutter/material.dart';
import 'package:flash/flash.dart';
import 'package:lunasea/core.dart';

enum SNACKBAR_TYPE {
    success,
    failure,
    info,
}

const _LEFT_PADDING = 8.0;

// ignore: non_constant_identifier_names
Future<void> LSSnackBar({
    @required BuildContext context,
    @required String title,
    String message,
    Duration duration,
    SNACKBAR_TYPE type = SNACKBAR_TYPE.info,
    bool showButton = false,
    String buttonText = 'view',
    Function buttonOnPressed,
}) async {
    if(showButton) assert(buttonOnPressed != null);
    Color color;
    IconData icon;
    switch(type) {
        case SNACKBAR_TYPE.failure: color = LunaColours.red; icon = Icons.error_outline; break;
        case SNACKBAR_TYPE.success: color = LunaColours.accent; icon = Icons.check_circle_outline; break;
        case SNACKBAR_TYPE.info: color = LunaColours.blue; icon = Icons.info_outline; break;
    }
    showFlash(
        context: context,
        duration: duration != null
            ? duration
            : showButton
                ? Duration(seconds: 4)
                : Duration(seconds: 2),
        builder: (context, controller) => Flash(
            backgroundColor: Theme.of(context).primaryColor,
            controller: controller,
            style: FlashStyle.floating,
            boxShadows: [BoxShadow(blurRadius: 6.0, spreadRadius: 4.0, color: Colors.black.withOpacity(0.10))],
            horizontalDismissDirection: HorizontalDismissDirection.horizontal,
            margin: EdgeInsets.all(8.0),
            borderRadius: BorderRadius.circular(Constants.UI_BORDER_RADIUS),
            borderColor: LunaDatabaseValue.THEME_AMOLED.data && LunaDatabaseValue.THEME_AMOLED_BORDER.data
                ? Colors.white12
                : Colors.transparent,
            child: FlashBar(
                title: Text(
                    title,
                    style: TextStyle(
                        fontWeight: LunaUI.FONT_WEIGHT_BOLD,
                        fontSize: Constants.UI_FONT_SIZE_TITLE,
                    ),
                ),
                message: Text(
                    message ?? LunaLogger.checkLogsMessage,
                    style: TextStyle(
                        color: Colors.white70,
                        fontSize: Constants.UI_FONT_SIZE_SUBTITLE,
                    ),
                ),
                icon: Padding(
                    child: LSIconButton(
                        icon: icon,
                        color: color,
                    ),
                    padding: EdgeInsets.only(left: _LEFT_PADDING),
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
                            controller.dismiss();
                            buttonOnPressed();
                        },
                    )
                    : null,
            ),
        ),
    );
}
