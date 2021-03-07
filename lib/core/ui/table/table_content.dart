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
    }) : super(key: key) {
        assert(title != null);
        assert(body != null);
    }

    @override
    Widget build(BuildContext context) {
        return Padding(
            child: Row(
                children: [
                    _title(),
                    Container(width: 16.0, height: 0.0),
                    _subtitle(),
                ],
                crossAxisAlignment: CrossAxisAlignment.start,
            ),
            padding: padding,
        );
    }

    Widget _title() {
        return Expanded(
            child: Text(
                title.toUpperCase(),
                textAlign: titleAlign,
                style: TextStyle(
                    color: titleColor,
                    fontSize: LunaUI.FONT_SIZE_SUBTITLE,
                ),
            ),
            flex: titleFlex,
        );
    }

    Widget _subtitle() {
        return Expanded(
            child: InkWell(
                child: Text(
                    body,
                    textAlign: bodyAlign,
                    style: TextStyle(
                        color: bodyColor,
                        fontSize: LunaUI.FONT_SIZE_SUBTITLE,
                    ),
                ),
                onTap: !bodyIsUrl ? null : body.lunaOpenGenericLink,
                onLongPress: !bodyIsUrl ? null : () async {
                    await Clipboard.setData(ClipboardData(text: body));
                    showLunaSuccessSnackBar(title: 'Copied Content', message: 'Copied link to the clipboard');
                },
                borderRadius: BorderRadius.circular(5.0),
            ),
            flex: bodyFlex,
        );
    }
}
