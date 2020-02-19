export './dialogs/system.dart';
export './dialogs/lidarr.dart';
export './dialogs/radarr.dart';
export './dialogs/sonarr.dart';
export './dialogs/nzbget.dart';
export './dialogs/sabnzbd.dart';

import 'package:flutter/material.dart';
import 'package:lunasea/widgets.dart';

abstract class LSDialog {
    Widget title(String title) {
        return Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold,
            ),
        );
    }

    Widget button(String text, Function onPressed, {Color textColor}) {
        return FlatButton(
            child: Text(
                text,
                style: TextStyle(
                    color: textColor == null
                        ? LSColors.accent
                        : textColor,
                ),
            ),
            onPressed: onPressed,
        );
    }
}
