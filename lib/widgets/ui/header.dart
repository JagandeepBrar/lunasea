import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class LunaHeader extends StatelessWidget {
  final String? text;
  final String? subtitle;

  const LunaHeader({
    Key? key,
    required this.text,
    this.subtitle,
  }) : super(key: key);

  Widget _headerText() {
    return Text(
      text!,
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
      padding: const EdgeInsets.only(
        top: LunaUI.DEFAULT_MARGIN_SIZE / 2,
        left: 0,
        bottom: LunaUI.DEFAULT_MARGIN_SIZE / 2,
      ),
    );
  }

  Widget _subtitle() {
    return Padding(
      child: Text(
        subtitle!,
        style: const TextStyle(
          fontSize: LunaUI.FONT_SIZE_H4,
          color: LunaColours.grey,
          fontWeight: FontWeight.w300,
        ),
      ),
      padding: const EdgeInsets.only(bottom: LunaUI.DEFAULT_MARGIN_SIZE / 2),
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
      padding: const EdgeInsets.only(
        left: LunaUI.DEFAULT_MARGIN_SIZE,
        right: LunaUI.DEFAULT_MARGIN_SIZE,
        top: LunaUI.DEFAULT_MARGIN_SIZE / 2,
      ),
    );
  }
}
