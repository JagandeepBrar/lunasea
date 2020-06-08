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

    static Widget content({ @required List<Widget> children }) => SingleChildScrollView(
        child: ListBody(
            children: children,
        ),
        padding: EdgeInsets.zero,
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

    static Widget textFormInput({
        @required TextEditingController controller,
        @required String title,
        @required Function(String) onSubmitted,
        @required Function(String) validator,
        bool obscureText = false,
     }) => TextFormField(
        autofocus: true,
        autocorrect: false,
        controller: controller,
        obscureText: obscureText,
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
        validator: validator,
        onFieldSubmitted: onSubmitted,
    );

    static Widget tile({
        @required IconData icon,
        Color iconColor,
        @required String text,
        @required Function onTap,
    }) => ListTile(
        leading: Icon(
            icon ?? Icons.error_outline,
            color: iconColor ?? LSColors.accent,
        ),
        title: Text(
            text,
            style: TextStyle(
                color: Colors.white,
            ),
        ),
        onTap: onTap,
        contentPadding: listContentPadding(),
    );

    static TextSpan bolded({ @required String title, double fontSize = 14.0, Color color }) => TextSpan(
        text: title,
        style: TextStyle(
            color: color == null
                ? LSColors.accent
                : color,
            fontWeight: FontWeight.bold,
            fontSize: fontSize,
        ),
    );

    static EdgeInsets listContentPadding() => EdgeInsets.fromLTRB(32.0, 0.0, 16.0, 0.0);

    static EdgeInsets textDialogContentPadding() => EdgeInsets.fromLTRB(24.0, 30.0, 24.0, 14.0);

    static EdgeInsets listDialogContentPadding() => EdgeInsets.fromLTRB(0.0, 20.0, 24.0, 0.0);

    static EdgeInsets inputDialogContentPadding() => EdgeInsets.fromLTRB(24.0, 18.0, 24.0, 22.0);
}
