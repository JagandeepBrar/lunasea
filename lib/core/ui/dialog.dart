import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lunasea/core.dart';

abstract class LunaDialog {
    static const HEADER_SIZE = LunaUI.FONT_SIZE_HEADER;
    static const BODY_SIZE = LunaUI.FONT_SIZE_SUBTITLE;
    static const SUBBODY_SIZE = LunaUI.FONT_SIZE_SUBHEADER;
    static const BUTTON_SIZE = LunaUI.FONT_SIZE_SUBHEADER;

    static Widget title({ @required String text }) => Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: LunaDialog.HEADER_SIZE,
            fontWeight: LunaUI.FONT_WEIGHT_BOLD,
        ),
    );

    static TextSpan bolded({ @required String text, double fontSize = LunaDialog.BODY_SIZE, Color color }) => TextSpan(
        text: text,
        style: TextStyle(
            color: color ?? LunaColours.accent,
            fontWeight: LunaUI.FONT_WEIGHT_BOLD,
            fontSize: fontSize,
        ),
    );

    static Widget richText({ @required List<TextSpan> children, TextAlign alignment = TextAlign.start }) => RichText(
        text: TextSpan(
            style: TextStyle(
                fontSize: LunaDialog.BODY_SIZE,
            ),
            children: children,
        ),
        textAlign: alignment,
    );

    static Widget button({ @required String text, @required void Function() onPressed, Color textColor }) => TextButton(
        onPressed: onPressed == null ? null : () async {
            unawaited(HapticFeedback.lightImpact());
            onPressed();
        },
        child: Text(
            text,
            style: TextStyle(
                color: textColor ?? LunaColours.accent,
                fontSize: LunaDialog.BUTTON_SIZE,
            ),
        ),
    );

    static Widget cancel(BuildContext context, { Color textColor = Colors.white, String text }) => TextButton(
        onPressed: () {
            unawaited(HapticFeedback.lightImpact());
            Navigator.of(context).pop();
        },
        child: Text(
            text ?? 'lunasea.Cancel'.tr(),
            style: TextStyle(
                color: textColor,
                fontSize: LunaDialog.BUTTON_SIZE,
            ),
        ),
    );

    static Widget content({ @required List<Widget> children }) => SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 1.0),
        child: ListBody(
            children: children,
        ),
    );

    static Widget textContent({ @required String text, TextAlign textAlign = TextAlign.center }) => Text(
        text,
        style: TextStyle(
            color: Colors.white,
            fontSize: LunaDialog.BODY_SIZE,
        ),
        textAlign: textAlign,
    );

    static TextSpan textSpanContent({ @required String text }) => TextSpan(
        text: text,
        style: TextStyle(
            color: Colors.white,
            fontSize: LunaDialog.BODY_SIZE,
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
                fontSize: LunaDialog.BODY_SIZE,
            ),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: LunaColours.accent),
            ),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: LunaColours.accent.withOpacity(0.3)),
            ),
        ),
        style: TextStyle(
            color: Colors.white,
            fontSize: LunaDialog.BODY_SIZE,
        ),
        cursorColor: LunaColours.accent,
        textInputAction: TextInputAction.done,
        onSubmitted: onSubmitted,
    );

    static Widget textFormInput({
        @required TextEditingController controller,
        @required String title,
        @required Function(String) onSubmitted,
        @required Function(String) validator,
        bool obscureText = false,
        TextInputType keyboardType = TextInputType.text,
     }) => TextFormField(
        autofocus: true,
        autocorrect: false,
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        decoration: InputDecoration(
            labelText: title,
            labelStyle: TextStyle(
                color: Colors.white54,
                decoration: TextDecoration.none,
                fontSize: LunaDialog.BODY_SIZE,
            ),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: LunaColours.accent),
            ),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: LunaColours.accent.withOpacity(0.3)),
            ),
        ),
        style: TextStyle(
            color: Colors.white,
            fontSize: LunaDialog.BODY_SIZE,
        ),
        cursorColor: LunaColours.accent,
        textInputAction: TextInputAction.done,
        validator: validator,
        onFieldSubmitted: onSubmitted,
    );

    static Widget tile({
        @required IconData icon,
        Color iconColor,
        @required String text,
        RichText subtitle,
        Function onTap,
    }) => ListTile(
        leading: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
                Icon(
                    icon ?? Icons.error_outline,
                    color: iconColor ?? LunaColours.accent,
                ),
            ],
        ),
        title: Text(
            text,
            style: TextStyle(
                fontSize: LunaDialog.BODY_SIZE,
                color: Colors.white,
            ),
        ),
        subtitle: text == null
            ? null
            : subtitle,
        onTap: onTap == null ? null : () async {
            unawaited(HapticFeedback.selectionClick());
            onTap();
        },
        contentPadding: tileContentPadding(),
    );

    static CheckboxListTile checkbox({
        @required String title,
        @required bool value,
        @required void Function(bool) onChanged,
    }) => CheckboxListTile(
        title: Text(
            title,
            style: TextStyle(
                fontSize: BODY_SIZE,
                color: Colors.white,
            ),
        ),
        value: value,
        onChanged: onChanged,
        contentPadding: tileContentPadding(),
    );

    static EdgeInsets tileContentPadding() => EdgeInsets.symmetric(horizontal: 32.0, vertical: 0.0);
    static EdgeInsets textDialogContentPadding() => EdgeInsets.fromLTRB(24.0, 32.0, 24.0, 14.0);
    static EdgeInsets listDialogContentPadding() => EdgeInsets.fromLTRB(0.0, 26.0, 0.0, 0.0);
    static EdgeInsets inputTextDialogContentPadding() => EdgeInsets.fromLTRB(24.0, 34.0, 24.0, 22.0);
    static EdgeInsets inputDialogContentPadding() => EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 22.0);

    static Future<void> dialog({
        @required BuildContext context,
        @required String title,
        @required EdgeInsets contentPadding,
        bool showCancelButton = true,
        String cancelButtonText,
        List<Widget> buttons,
        List<Widget> content,
        Widget customContent,
    }) async {
        if(customContent == null) assert(content != null, 'customContent and content both cannot be null');
        await showDialog(
            context: context,
            builder: (context) => AlertDialog(
                actions: <Widget>[
                    if(showCancelButton) LunaDialog.cancel(
                        context,
                        text: cancelButtonText,
                        textColor: buttons != null ? Colors.white : LunaColours.accent,
                    ),
                    if(buttons != null) ...buttons,
                ],
                title: LunaDialog.title(text: title),
                content: customContent ?? LunaDialog.content(children: content),
                contentPadding: contentPadding,
                shape: LunaUI.shapeBorder,
            ),
        );
    }
}
