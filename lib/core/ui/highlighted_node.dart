import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class LunaHighlightedNode extends StatelessWidget {
    final Color backgroundColor;
    final Color textColor;
    final String text;

    LunaHighlightedNode({
        @required this.text,
        this.backgroundColor = LunaColours.accent,
        this.textColor = Colors.white,
    }) {
        assert(text != null);
    }

    @override
    Widget build(BuildContext context) {
        return Container(
            decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(LunaUI.BORDER_RADIUS),
            ),
            child: Padding(
                padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                child: Text(
                    text,
                    maxLines: 1,
                    style: TextStyle(
                        fontSize: LunaUI.FONT_SIZE_HIGHLIGHTED_NODE,
                        color: textColor,
                        fontWeight: LunaUI.FONT_WEIGHT_BOLD,
                    ),
                ),
            ),
        );
    }
}
