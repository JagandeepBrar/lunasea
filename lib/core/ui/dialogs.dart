//Export
export './dialogs/system.dart';
export './dialogs/lidarr.dart';
export './dialogs/radarr.dart';
export './dialogs/sonarr.dart';
export './dialogs/nzbget.dart';
export './dialogs/sabnzbd.dart';
export './dialogs/settings.dart';
export './dialogs/search.dart';
//Import
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

    static Widget button({ @required String text, @required void Function() onPressed, Color textColor = Colors.white }) => FlatButton(
        child: Text(
            text,
            style: TextStyle(color: textColor),
        ),
        onPressed: onPressed,
    );

    static Widget cancel(BuildContext context, { Color textColor = Colors.white }) => FlatButton(
        child: Text(
            'Cancel',
            style: TextStyle(color: textColor),
        ),
        onPressed: () => Navigator.of(context).pop(),
    );

    static Widget content({ @required List<Widget> children, bool padTop = false }) => SingleChildScrollView(
        child: ListBody(
            children: children,
        ),
        padding: padTop
            ? EdgeInsets.only(top: 20.0)
            : EdgeInsets.zero,
    );

    static Widget textContent({ @required String text, TextAlign textAlign = TextAlign.center }) => Text(
        text,
        style: TextStyle(
            color: Colors.white,
        ),
        textAlign: textAlign,
    );

    static TextSpan textSpanContent({ @required String text }) => TextSpan(
        text: text,
        style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
        ),
    );

    static Widget textInput({
        @required TextEditingController controller,
        @required Function(String) onSubmitted,
        @required String title,
     }) => TextField(
        autofocus: true,
        autocorrect: false,
        controller: controller,
        decoration: InputDecoration(
            labelText: title,
            labelStyle: TextStyle(
                color: Colors.white54,
                decoration: TextDecoration.none,
            ),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: LSColors.accent),
            ),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: LSColors.accent),
            ),
        ),
        style: TextStyle(color: Colors.white),
        cursorColor: LSColors.accent,
        textInputAction: TextInputAction.done,
        onSubmitted: onSubmitted,
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
    );

    static TextSpan bolded({ @required String title }) => TextSpan(
        text: title,
        style: TextStyle(
            color: LSColors.accent,
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
        ),
    );
}
