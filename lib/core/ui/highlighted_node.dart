import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class LunaHighlightedNode extends StatelessWidget {
  final Color backgroundColor;
  final Color textColor;
  final String text;

  const LunaHighlightedNode({
    Key? key,
    required this.text,
    this.backgroundColor = LunaColours.accent,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        child: Text(
          text,
          maxLines: 1,
          style: TextStyle(
            fontSize: LunaUI.FONT_SIZE_H4,
            color: textColor,
            fontWeight: LunaUI.FONT_WEIGHT_BOLD,
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(LunaUI.BORDER_RADIUS),
      ),
    );
  }
}
