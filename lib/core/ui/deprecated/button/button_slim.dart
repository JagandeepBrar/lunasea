import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lunasea/core.dart';

class LSButtonSlim extends StatelessWidget {
    final String text;
    final Function onTap;
    final Color backgroundColor;
    final Color textColor;
    final EdgeInsets margin;
    final Widget widget;

    LSButtonSlim({
        @required this.text,
        @required this.onTap,
        this.widget,
        this.backgroundColor = const Color(LunaColours.ACCENT_COLOR),
        this.textColor = Colors.white,
        this.margin = const EdgeInsets.symmetric(horizontal: 6.0, vertical: 6.0),
    });

    @override
    Widget build(BuildContext context) => Row(
        children: <Widget>[
            Expanded(
                child: Card(
                    child: InkWell(
                        child: Padding(
                            child: widget != null ? widget :Text(
                                text,
                                style: TextStyle(
                                    color: textColor,
                                    fontWeight: LunaUI.FONT_WEIGHT_BOLD,
                                    fontSize: Constants.UI_FONT_SIZE_STICKYHEADER,
                                ),
                                textAlign: TextAlign.center,
                            ),
                            padding: EdgeInsets.symmetric(vertical: 14.0),
                        ),
                        borderRadius: BorderRadius.circular(Constants.UI_BORDER_RADIUS),
                        onTap: onTap == null ? null : () async {
                            HapticFeedback.lightImpact();
                            onTap();
                        }
                    ),
                    color: backgroundColor,
                    margin: margin,
                    elevation: LunaUI.ELEVATION,
                    shape: LunaUI.shapeBorder,
                ),
            ),
        ],
    );
}