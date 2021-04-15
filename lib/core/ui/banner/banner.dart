import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class LunaBanner extends StatelessWidget {
    // An arbitrarily large number of max lines
    static const _MAX_LINES = 5000000;
    final String headerText;
    final String bodyText;
    final IconData icon;
    final Color iconColor;

    LunaBanner({
        Key key,
        @required this.headerText,
        this.bodyText,
        this.icon = Icons.info_outline_rounded,
        this.iconColor = LunaColours.accent,
    }) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return LunaCard(
            context: context,
            child: Container(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                                Padding(
                                    child: Icon(
                                        icon,
                                        size: 20.0,
                                        color: iconColor,
                                    ),
                                    padding: EdgeInsets.only(right: LunaUI.MARGIN_DEFAULT.right-4.0),
                                ),
                                Expanded(
                                    child: LunaText.title(
                                        text: headerText,
                                        maxLines: _MAX_LINES,
                                        softWrap: true,
                                    ),
                                ),
                            ],
                        ),
                        if(bodyText?.isNotEmpty ?? false) Padding(
                            child: LunaText.subtitle(
                                text: bodyText.toString(),
                                softWrap: true,
                                maxLines: _MAX_LINES,
                            ),
                            padding: EdgeInsets.only(top: LunaUI.MARGIN_CARD.top),
                        ),
                    ],
                ),
                padding: LunaUI.MARGIN_DEFAULT,
            ),
        );
    }
}
