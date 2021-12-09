import 'package:flutter/material.dart';
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

  const LunaTableContent({
    Key key,
    @required this.title,
    @required this.body,
    this.bodyIsUrl = false,
    this.titleAlign = TextAlign.end,
    this.bodyAlign = TextAlign.start,
    this.titleFlex = 5,
    this.bodyFlex = 10,
    this.titleColor = Colors.white70,
    this.bodyColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      child: Row(
        children: [
          _title(),
          _subtitle(),
        ],
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
      padding:
          const EdgeInsets.symmetric(vertical: LunaUI.DEFAULT_MARGIN_SIZE / 2),
    );
  }

  Widget _title() {
    return Expanded(
      child: Padding(
        child: Text(
          title?.toUpperCase() ?? LunaUI.TEXT_EMDASH,
          textAlign: titleAlign,
          style: TextStyle(
            color: titleColor,
            fontSize: LunaUI.FONT_SIZE_H3,
          ),
        ),
        padding: const EdgeInsets.only(
          top: LunaUI.DEFAULT_MARGIN_SIZE / 4,
          bottom: LunaUI.DEFAULT_MARGIN_SIZE / 4,
        ),
      ),
      flex: titleFlex,
    );
  }

  Widget _subtitle() {
    return Expanded(
      child: InkWell(
        child: Padding(
          child: Text(
            body ?? LunaUI.TEXT_EMDASH,
            textAlign: bodyAlign,
            style: TextStyle(
              color: bodyColor,
              fontSize: LunaUI.FONT_SIZE_H3,
            ),
          ),
          padding: const EdgeInsets.only(
            top: LunaUI.DEFAULT_MARGIN_SIZE / 4,
            bottom: LunaUI.DEFAULT_MARGIN_SIZE / 4,
          ),
        ),
        onTap: !bodyIsUrl ? null : body.lunaOpenGenericLink,
        // onLongPress: !bodyIsUrl ? null : () => body.copyToClipboard(),
        borderRadius: BorderRadius.circular(LunaUI.BORDER_RADIUS),
      ),
      flex: bodyFlex,
    );
  }
}
