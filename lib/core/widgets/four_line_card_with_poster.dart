import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class LunaFourLineCardWithPoster extends StatelessWidget {
  static final double itemExtent = LunaListTile.extentFromSubtitleLines(3);
  static final double _itemHeight = LunaListTile.heightFromSubtitleLines(3);

  final Function onTap;
  final Function onLongPress;
  final String backgroundUrl;
  final String posterUrl;
  final String posterPlaceholder;
  final String title;
  final TextSpan subtitle1;
  final TextSpan subtitle2;
  final TextSpan subtitle3;
  final int subtitle1MaxLines;
  final int subtitle2MaxLines;
  final int subtitle3MaxLines;
  final Widget customSubtitle1;
  final Widget customSubtitle2;
  final Widget customSubtitle3;
  final bool darken;
  final Color titleColor;
  final Map posterHeaders;
  final LunaIconButton trailing;

  const LunaFourLineCardWithPoster({
    Key key,
    @required this.posterPlaceholder,
    @required this.posterUrl,
    @required this.posterHeaders,
    @required this.title,
    this.backgroundUrl,
    this.titleColor = Colors.white,
    this.subtitle1,
    this.subtitle2,
    this.subtitle3,
    this.subtitle1MaxLines = 1,
    this.subtitle2MaxLines = 1,
    this.subtitle3MaxLines = 1,
    this.customSubtitle1,
    this.customSubtitle2,
    this.customSubtitle3,
    this.darken = false,
    this.onTap,
    this.onLongPress,
    this.trailing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LunaCard(
      context: context,
      child: InkWell(
        child: Row(
          children: [
            _poster(context),
            _body(context),
          ],
        ),
        onTap: onTap,
        onLongPress: onLongPress,
        borderRadius: BorderRadius.circular(LunaUI.BORDER_RADIUS),
      ),
      decoration: backgroundUrl == null
          ? null
          : LunaCardDecoration(
              uri: backgroundUrl,
              headers: posterHeaders,
            ),
      height: _itemHeight,
    );
  }

  Widget _poster(BuildContext context) {
    return LunaNetworkImage(
      url: posterUrl,
      placeholderAsset: posterPlaceholder,
      height: _itemHeight,
      width: _itemHeight / 1.5,
      headers: posterHeaders,
    );
  }

  Widget _body(BuildContext context) {
    return Expanded(
      child: LunaListTile(
        context: context,
        title: _title(),
        height: _itemHeight,
        color: Colors.transparent,
        subtitle: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (customSubtitle1 != null) customSubtitle1,
            if (customSubtitle1 == null && subtitle1 != null)
              _subtitle(subtitle1, subtitle1MaxLines),
            if (customSubtitle2 != null) customSubtitle2,
            if (customSubtitle2 == null && subtitle2 != null)
              _subtitle(subtitle2, subtitle2MaxLines),
            if (customSubtitle3 != null) customSubtitle3,
            if (customSubtitle3 == null && subtitle3 != null)
              _subtitle(subtitle3, subtitle3MaxLines),
          ],
        ),
        margin: EdgeInsets.zero,
        trailing: trailing,
        drawBorder: false,
      ),
    );
  }

  Widget _title() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: LunaText.title(
        text: title,
        color: titleColor,
        darken: darken,
        maxLines: 1,
      ),
    );
  }

  Widget _subtitle(TextSpan text, int maxLines) {
    return SizedBox(
      child: RichText(
        text: TextSpan(
          style: TextStyle(
            fontSize: LunaUI.FONT_SIZE_H3,
            color: darken ? Colors.white30 : Colors.white70,
          ),
          children: [text],
        ),
        overflow: TextOverflow.fade,
        softWrap: maxLines == 1 ? false : true,
        maxLines: maxLines,
      ),
      height: LunaListTile.SUBTITLE_HEIGHT * maxLines,
    );
  }
}
