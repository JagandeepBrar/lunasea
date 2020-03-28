export './dialogs/system.dart';
export './dialogs/lidarr.dart';
export './dialogs/radarr.dart';
export './dialogs/sonarr.dart';
export './dialogs/nzbget.dart';
export './dialogs/sabnzbd.dart';
export './dialogs/settings.dart';
export './dialogs/search.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

abstract class LSDialog {
    static Widget title({ @required String text }) => Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontWeight: FontWeight.bold,
        ),
    );

    static Widget button({ @required String text, @required Function onPressed, Color textColor = Colors.white }) => FlatButton(
        child: Text(
            text,
            style: TextStyle(color: textColor),
        ),
        onPressed: onPressed,
    );

    static Widget content({ @required List<Widget> children, bool noPadding = false }) => SingleChildScrollView(
        child: ListBody(
            children: children,
        ),
        padding: EdgeInsets.only(top: 16.0),
    );

    static Widget textContent({ @required String text }) => Text(
        text,
        style: TextStyle(color: Colors.white),
        textAlign: TextAlign.center,
    );

    static Widget tile({
        @required bool icon,
        IconData iconData,
        Color iconColor,
        @required String text,
        @required Function onTap,
    }) => ListTile(
        leading: Icon(
            iconData ?? Icons.error_outline,
            color: iconColor ?? LSColors.accent,
        ),
        title: Text(
            text,
            style: TextStyle(
                color: Colors.white,
            ),
        ),
        onTap: onTap,
        //contentPadding: EdgeInsets.fromLTRB(32.0, 0.0, 0.0, 0.0),
    );
}
