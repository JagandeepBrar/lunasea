import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class LunaTwoLineCardWithPoster extends StatelessWidget {
  final Function onTap;
  final Function onLongPress;
  final String backgroundUrl;
  final String posterUrl;
  final String posterPlaceholder;
  final String title;
  final TextSpan subtitle1;
  final TextSpan subtitle2;
  final Widget customSubtitle1;
  final Widget customSubtitle2;
  final bool darken;
  final Color titleColor;
  final Map posterHeaders;
  final LunaIconButton trailing;
  static const double itemExtent = 67.0;
  static const double _padding = 8.0;

  const LunaTwoLineCardWithPoster({
    Key key,
    @required this.posterPlaceholder,
    @required this.posterUrl,
    @required this.posterHeaders,
    @required this.title,
    this.backgroundUrl,
    this.titleColor = Colors.white,
    this.subtitle1,
    this.subtitle2,
    this.customSubtitle1,
    this.customSubtitle2,
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
            if (trailing != null) _trailing(),
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
    );
  }

  Widget _poster(BuildContext context) {
    return LunaNetworkImage(
      url: posterUrl,
      placeholderAsset: posterPlaceholder,
      height: itemExtent,
      width: itemExtent,
      headers: posterHeaders,
    );
  }

  Widget _body(BuildContext context) {
    return Expanded(
      child: Padding(
        child: SizedBox(
          child: Column(
            children: [
              _title(),
              if (customSubtitle1 != null) customSubtitle1,
              if (customSubtitle1 == null && subtitle1 != null)
                _subtitle(subtitle1),
              if (customSubtitle2 != null) customSubtitle2,
              if (customSubtitle2 == null && subtitle2 != null)
                _subtitle(subtitle2),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
          ),
          height: (itemExtent - (_padding * 2)),
        ),
        padding: const EdgeInsets.all(_padding),
      ),
    );
  }

  Widget _title() {
    return LunaText.title(
      text: title,
      color: titleColor,
      darken: darken,
      maxLines: 1,
    );
  }

  Widget _subtitle(TextSpan text) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          fontSize: LunaUI.FONT_SIZE_H3,
          color: darken ? Colors.white30 : Colors.white70,
        ),
        children: [text],
      ),
      overflow: TextOverflow.fade,
      softWrap: false,
      maxLines: 1,
    );
  }

  Widget _trailing() {
    return Padding(
      padding: EdgeInsets.only(right: LunaUI.MARGIN_CARD.right),
      child: SizedBox(
        width: 48.0,
        height: itemExtent,
        child: trailing,
      ),
    );
  }
}
