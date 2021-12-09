import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class LunaHeader extends StatelessWidget {
  final String text;
  final String subtitle;
  final EdgeInsets padding;

  const LunaHeader({
    Key key,
    @required this.text,
    this.subtitle,
    this.padding,
  }) : super(key: key);

  Widget _headerText() {
    return Text(
      text.toUpperCase(),
      style: const TextStyle(
        fontWeight: LunaUI.FONT_WEIGHT_BOLD,
        fontSize: LunaUI.FONT_SIZE_H2,
        color: Colors.white,
      ),
    );
  }

  Widget _barSeperator() {
    return Padding(
      child: Container(
        height: 2.0,
        width: LunaUI.DEFAULT_MARGIN_SIZE * 3,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(LunaUI.BORDER_RADIUS),
          color: LunaColours.accent,
        ),
      ),
      padding: EdgeInsets.only(
        top: 4.0,
        left: 1.0,
        bottom: subtitle != null ? 6.0 : 0.0,
      ),
    );
  }

  Widget _subtitle() {
    return Text(
      subtitle,
      style: const TextStyle(
        fontSize: LunaUI.FONT_SIZE_H4,
        color: Colors.white70,
        fontWeight: FontWeight.w300,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _headerText(),
          _barSeperator(),
          if (subtitle != null) _subtitle(),
        ],
      ),
      padding: padding ??
          const EdgeInsets.fromLTRB(
            LunaUI.DEFAULT_MARGIN_SIZE,
            LunaUI.DEFAULT_MARGIN_SIZE / 2,
            LunaUI.DEFAULT_MARGIN_SIZE,
            LunaUI.DEFAULT_MARGIN_SIZE / 1.5,
          ),
    );
  }
}
