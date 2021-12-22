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
    int titleFlex = 1,
    int bodyFlex = 2,
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
        type: _Type.CONTENT,
      );

  @override
  Widget build(BuildContext context) {
    if (type == _Type.SPACER) return SizedBox(height: spacerSize);
    return Row(
      children: [
        _title(),
        _subtitle(),
      ],
      crossAxisAlignment: CrossAxisAlignment.start,
    );
  }

  Widget _title() {
    return Expanded(
      child: Padding(
        child: Text(
          title?.toUpperCase() ?? LunaUI.TEXT_EMDASH,
          textAlign: titleAlign,
          style: const TextStyle(
            color: LunaColours.grey,
            fontSize: LunaUI.FONT_SIZE_H3,
          ),
        ),
        padding: const EdgeInsets.only(
          top: LunaUI.DEFAULT_MARGIN_SIZE / 4,
          bottom: LunaUI.DEFAULT_MARGIN_SIZE / 4,
          right: LunaUI.DEFAULT_MARGIN_SIZE / 4,
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
            style: const TextStyle(
              color: LunaColours.white,
              fontSize: LunaUI.FONT_SIZE_H3,
            ),
          ),
          padding: const EdgeInsets.only(
            top: LunaUI.DEFAULT_MARGIN_SIZE / 4,
            bottom: LunaUI.DEFAULT_MARGIN_SIZE / 4,
            left: LunaUI.DEFAULT_MARGIN_SIZE / 2,
          ),
        ),
        onTap: !bodyIsUrl ? null : body.lunaOpenGenericLink,
        onLongPress: !bodyIsUrl ? null : () => body.copyToClipboard(),
        borderRadius: BorderRadius.circular(LunaUI.BORDER_RADIUS),
      ),
      flex: bodyFlex,
    );
  }
}
