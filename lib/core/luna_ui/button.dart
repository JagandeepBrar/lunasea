import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lunasea/core.dart';

class LunaButton extends StatelessWidget {
    final Color textColor;
    final Color backgroundColor;
    final EdgeInsets margin;
    final LunaLoadingState loadingState;
    final Function onTap;
    final String text;
    final Widget child;

    LunaButton({
        Key key,
        @required this.onTap,
        this.text = '',
        this.child,
        this.textColor = Colors.white,
        this.backgroundColor = LunaColours.accent,
        this.margin = const EdgeInsets.symmetric(horizontal: 6.0, vertical: 6.0),
        this.loadingState = LunaLoadingState.INACTIVE,
    }) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return Row(
            children: [
                Expanded(
                    child: Card(
                        child: InkWell(
                            child: ListTile(
                                title: _title(),
                            ),
                            borderRadius: BorderRadius.circular(LunaUI().borderRadius),
                            onTap: loadingState == LunaLoadingState.ACTIVE ? null : () async {
                                HapticFeedback.mediumImpact();
                                if(onTap != null) onTap();
                            },
                        ),
                        margin: margin,
                        color: backgroundColor,
                        elevation: LunaUI().elevation,
                        shape: LunaUI().shapeBorder(),
                    ),
                ),
            ],
        );
    }

    Widget _title() {
        if(loadingState == LunaLoadingState.ACTIVE) return LunaLoader(color: textColor, size: 20.0);
        if(loadingState == LunaLoadingState.ERROR) return LSIconButton(iconSize: 20.0, icon: Icons.error, color: textColor);
        if(child != null) return child;
        return Text(
            text,
            style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.bold,
                fontSize: LunaUI().fontSizeButton,
            ),
            textAlign: TextAlign.center,
        );
    }
}