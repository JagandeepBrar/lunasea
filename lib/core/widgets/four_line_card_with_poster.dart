import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class LunaFourLineCardWithPoster extends StatelessWidget {
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
    final double _height = 90.0;
    final double _width = 60.0;
    final double _padding = 8.0;

    LunaFourLineCardWithPoster({
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
                        if(trailing != null) _trailing(),
                    ],
                ),
                onTap: onTap,
                onLongPress: onLongPress,
                borderRadius: BorderRadius.circular(LunaUI().borderRadius),
            ),
            decoration: backgroundUrl == null ? null : LunaCardDecoration(
                uri: backgroundUrl,
                headers: posterHeaders,
            ),
        );
    }

    Widget _poster(BuildContext context) {
        return LunaNetworkImage(
            url: posterUrl,
            placeholderAsset: posterPlaceholder,
            height: _height,
            width: _width,
            headers: posterHeaders,
        );
    }

    Widget _body(BuildContext context) {
        return Expanded(
            child: Padding(
                child: Container(
                    child: Column(
                        children: [
                            _title(),
                            if(customSubtitle1 != null) customSubtitle1,
                            if(customSubtitle1 == null && subtitle1 != null) _subtitle(subtitle1, subtitle1MaxLines),
                            if(customSubtitle2 != null) customSubtitle2,
                            if(customSubtitle2 == null && subtitle2 != null) _subtitle(subtitle2, subtitle2MaxLines),
                            if(customSubtitle3 != null) customSubtitle3,
                            if(customSubtitle3 == null && subtitle3 != null) _subtitle(subtitle3, subtitle3MaxLines),
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                    ),
                    height: (_height-(_padding*2)),
                ),
                padding: EdgeInsets.all(_padding),
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

    Widget _subtitle(TextSpan text, int maxLines) {
        return RichText(
            text: TextSpan(
                style: TextStyle(
                    fontSize: LunaUI().fontSizeSubtitle,
                    color: darken ? Colors.white30 : Colors.white70,
                ),
                children: [text],
            ),
            overflow: TextOverflow.fade,
            softWrap: maxLines == 1 ? false : true,
            maxLines: maxLines,
        );
    }

    Widget _trailing() {
        return Container(
            child: Padding(
                child: trailing,
                padding: EdgeInsets.only(right: 12.0),
            ),
            height: _height,
        );
    }
}
