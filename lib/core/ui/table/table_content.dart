import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

enum _Type {
  CONTENT,
  SPACER,
}

class LunaTableContent extends StatelessWidget {
  final String title;
  final String body;
  final bool bodyIsUrl;
  final int titleFlex;
  final int bodyFlex;
  final double spacerSize;
  final TextAlign titleAlign;
  final TextAlign bodyAlign;
  final Color titleColor;
  final Color bodyColor;
  final _Type type;

  const LunaTableContent._({
    Key key,
    this.title,
    this.body,
    this.bodyIsUrl = false,
    this.titleAlign = TextAlign.end,
    this.bodyAlign = TextAlign.start,
    this.titleFlex = 5,
    this.bodyFlex = 10,
    this.spacerSize = LunaUI.DEFAULT_MARGIN_SIZE,
    this.titleColor = Colors.white70,
    this.bodyColor = Colors.white,
    @required this.type,
  });

  factory LunaTableContent.spacer({
    Key key,
    double spacerSize = LunaUI.DEFAULT_MARGIN_SIZE,
  }) =>
      LunaTableContent._(
        key: key,
        type: _Type.SPACER,
        spacerSize: spacerSize,
      );

  factory LunaTableContent({
    Key key,
    @required String title,
    @required String body,
    bool bodyIsUrl = false,
    TextAlign titleAlign = TextAlign.end,
    TextAlign bodyAlign = TextAlign.start,
    int titleFlex = 5,
    int bodyFlex = 10,
    Color titleColor = Colors.white70,
    Color bodyColor = Colors.white,
  }) =>
      LunaTableContent._(
        key: key,
        title: title,
        body: body,
        bodyIsUrl: bodyIsUrl,
        titleAlign: titleAlign,
        bodyAlign: bodyAlign,
        titleFlex: titleFlex,
        bodyFlex: bodyFlex,
        titleColor: titleColor,
        bodyColor: bodyColor,
        type: _Type.CONTENT,
      );

  @override
  Widget build(BuildContext context) {
    if (type == _Type.SPACER) return SizedBox(height: spacerSize);
    return Padding(
      child: Row(
        children: [
          _title(),
          _subtitle(),
        ],
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
      padding: EdgeInsets.zero,
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
          right: LunaUI.DEFAULT_MARGIN_SIZE / 2,
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
            left: LunaUI.DEFAULT_MARGIN_SIZE / 2,
          ),
        ),
        onTap: body.lunaOpenGenericLink,
        // onTap: !bodyIsUrl ? null : body.lunaOpenGenericLink,
        // onLongPress: !bodyIsUrl ? null : () => body.copyToClipboard(),
        borderRadius: BorderRadius.circular(LunaUI.BORDER_RADIUS),
      ),
      flex: bodyFlex,
    );
  }
}
