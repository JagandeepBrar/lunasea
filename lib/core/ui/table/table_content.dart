import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lunasea/core.dart';

class LunaTableContent extends StatelessWidget {
    final String title;
    final String body;
    final bool bodyIsUrl;
    final int titleFlex;
    final int bodyFlex;
    final TextAlign titleAlign;
    final TextAlign bodyAlign;
    final Color titleColor;
    final Color bodyColor;
    final EdgeInsets padding;

    LunaTableContent({
        Key key,
        @required this.title,
        @required this.body,
        this.bodyIsUrl = false,
        this.titleAlign = TextAlign.end,
        this.bodyAlign = TextAlign.start,
        this.titleFlex = 2,
        this.bodyFlex = 5,
        this.titleColor = Colors.white70,
        this.bodyColor = Colors.white,
        this.padding = const EdgeInsets.symmetric(vertical: 4.0),
    }) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return Padding(
            padding: padding,
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    _title(),
                    Container(width: 16.0, height: 0.0),
                    _subtitle(),
                ],
            ),
        );
    }

    Widget _title() {
        return Expanded(
            flex: titleFlex,
            child: Text(
                title?.toUpperCase() ?? LunaUI.TEXT_EMDASH,
                textAlign: titleAlign,
                style: TextStyle(
                    color: titleColor,
                    fontSize: LunaUI.FONT_SIZE_SUBTITLE,
                ),
            ),
        );
    }

    Widget _subtitle() {
        return Expanded(
            flex: bodyFlex,
            child: InkWell(
                borderRadius: BorderRadius.circular(5.0),
                onTap: !bodyIsUrl ? null : body.lunaOpenGenericLink,
                onLongPress: !bodyIsUrl ? null : () async {
                    await Clipboard.setData(ClipboardData(text: body));
                    showLunaSuccessSnackBar(title: 'Copied Content', message: 'Copied link to the clipboard');
                },
                child: Text(
                    body ?? LunaUI.TEXT_EMDASH,
                    textAlign: bodyAlign,
                    style: TextStyle(
                        color: bodyColor,
                        fontSize: LunaUI.FONT_SIZE_SUBTITLE,
                    ),
                ),
            ),
        );
    }
}
