import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lunasea/core.dart';

class LSButton extends StatelessWidget {
    final String text;
    final Function onTap;
    final Color backgroundColor;
    final Color textColor;
    final bool reducedMargin;
    final LunaLoadingState loadingState;

    LSButton({
        @required this.text,
        @required this.onTap,
        this.backgroundColor = const Color(LunaColours.ACCENT_COLOR),
        this.textColor = Colors.white,
        this.reducedMargin = false,
        this.loadingState = LunaLoadingState.INACTIVE,
    });

    @override
    Widget build(BuildContext context) => Row(
        children: <Widget>[
            Expanded(
                child: Card(
                    child: InkWell(
                        child: ListTile(
                            title: loadingState == LunaLoadingState.ACTIVE
                                ? LSLoader(
                                    color: Colors.white,
                                    size: 20.0,
                                )
                                : Text(
                                    text,
                                    style: TextStyle(
                                        color: textColor,
                                        fontWeight: LunaUI.FONT_WEIGHT_BOLD,
                                        fontSize: Constants.UI_FONT_SIZE_STICKYHEADER,
                                    ),
                                    textAlign: TextAlign.center,
                                ),
                        ),
                        borderRadius: BorderRadius.circular(Constants.UI_BORDER_RADIUS),
                        onTap: loadingState == LunaLoadingState.ACTIVE ? null : onTap == null ? null : () async {
                            HapticFeedback.lightImpact();
                            onTap();
                        },
                    ),
                    color: backgroundColor,
                    margin: reducedMargin
                        ? EdgeInsets.symmetric(horizontal: 6.0, vertical: 6.0)
                        : LunaUI.MARGIN_CARD,
                    elevation: LunaUI.ELEVATION,
                    shape: LunaUI.shapeBorder,
                ),
            ),
        ],
    );
}
