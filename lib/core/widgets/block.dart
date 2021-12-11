import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class LunaBlock extends StatelessWidget {
  final bool disabled;
  final String title;
  final Color titleColor;

  /// If defined, only takes the first body subtitle from the [body] array
  /// And allows that single [TextSpan] to overflow to this many lines
  final int customBodyMaxLines;
  final List<TextSpan> body;
  final Widget bottom;
  final double bottomHeight;

  final LunaIconButton leading;
  final LunaIconButton trailing;
  final Function onTap;
  final Function onLongPress;

  final String posterPlaceholder;
  final String posterUrl;
  final Map posterHeaders;
  final bool posterIsSquare;
  final String backgroundUrl;
  final Map backgroundHeaders;

  const LunaBlock({
    Key key,
    this.disabled = false,
    @required this.title,
    this.titleColor = Colors.white,
    this.body,
    this.bottom,
    this.bottomHeight = LunaListTile.SUBTITLE_HEIGHT,
    this.customBodyMaxLines,
    this.posterPlaceholder,
    this.posterUrl,
    this.posterHeaders = const {},
    this.posterIsSquare = false,
    this.backgroundUrl,
    this.backgroundHeaders = const {},
    this.onTap,
    this.onLongPress,
    this.leading,
    this.trailing,
  }) : super(key: key);

  static double calculateItemExtent(
    int subtitleLines, {
    bool hasBottom = false,
    double bottomHeight = LunaListTile.SUBTITLE_HEIGHT,
  }) {
    double height = calculateItemHeight(
      subtitleLines,
      hasBottom: hasBottom,
      bottomHeight: bottomHeight,
    );
    return height + LunaUI.MARGIN_CARD.vertical;
  }

  static double calculateItemHeight(
    int subtitleLines, {
    bool hasBottom = false,
    double bottomHeight = LunaListTile.SUBTITLE_HEIGHT,
  }) {
    double height = LunaListTile.heightFromSubtitleLines(
      subtitleLines,
      alwaysAddSpacer: hasBottom,
    );
    if (hasBottom) height += bottomHeight;
    return height;
  }

  double _calculateHeight() {
    int _scalar = customBodyMaxLines;
    _scalar ??= body?.length ?? 0;
    return calculateItemHeight(
      _scalar,
      hasBottom: bottom != null,
      bottomHeight: bottomHeight,
    );
  }

  @override
  Widget build(BuildContext context) {
    double _height = _calculateHeight();
    return LunaCard(
      context: context,
      child: InkWell(
        child: Row(
          children: [
            _poster(_height),
            _tile(context, _height),
          ],
        ),
        onTap: onTap,
        onLongPress: onLongPress,
      ),
      height: _height,
      decoration: _decoration(),
    );
  }

  Decoration _decoration() {
    if (backgroundUrl == null) {
      return null;
    }

    return LunaCardDecoration(
      uri: backgroundUrl,
      headers: backgroundHeaders,
    );
  }

  Widget _poster(double height) {
    if (posterUrl == null && posterPlaceholder == null) {
      return const SizedBox(width: 0.0, height: 0.0);
    }

    assert(
      posterPlaceholder != null,
      'Poster placeholder required when defining a poster URL',
    );

    double _dimension = height - LunaUI.DEFAULT_MARGIN_SIZE;
    return Padding(
      padding: const EdgeInsets.only(left: LunaUI.DEFAULT_MARGIN_SIZE / 2),
      child: LunaNetworkImage(
        url: posterUrl ?? '',
        headers: posterHeaders,
        placeholderAsset: posterPlaceholder,
        height: _dimension,
        width: _dimension / (posterIsSquare ? 1.0 : 1.5),
      ),
    );
  }

  Widget _tile(BuildContext context, double height) {
    return Expanded(
      child: LunaListTile(
        context: context,
        title: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: LunaText.title(
            text: title,
            color: titleColor,
            darken: disabled,
            maxLines: 1,
          ),
        ),
        subtitle: _subtitle(),
        color: Colors.transparent,
        margin: EdgeInsets.zero,
        drawBorder: false,
        height: height,
        trailing: trailing,
        leading: leading,
      ),
    );
  }

  Widget _subtitle() {
    int maxLines = customBodyMaxLines ?? 1;
    double height = LunaListTile.SUBTITLE_HEIGHT * maxLines;

    Widget _wrapper(List<Widget> children) {
      return Expanded(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ),
      );
    }

    Widget _entry(TextSpan textSpan) {
      return SizedBox(
        height: height,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: LunaUI.FONT_SIZE_H3,
                color: disabled ? LunaColours.white30 : LunaColours.white70,
              ),
              children: [textSpan],
            ),
            overflow: TextOverflow.clip,
            softWrap: maxLines == 1 ? false : true,
            maxLines: maxLines,
          ),
        ),
      );
    }

    List<Widget> _children = [];

    if (body?.isNotEmpty ?? false) {
      if (customBodyMaxLines != null) {
        _children.add(_entry(body[0]));
      } else {
        _children.addAll(body.map(_entry));
      }
    }

    if (bottom != null) {
      _children.add(SizedBox(
        height: bottomHeight,
        child: bottom,
      ));
    }

    return _children.isEmpty ? null : _wrapper(_children);
  }
}
