import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lunasea/core.dart';

class LunaIconButton extends StatelessWidget {
    final IconData icon;
    final double iconSize;
    final String text;
    final double textSize;
    final Color color;
    final Function onPressed;
    final Function onLongPress;

    LunaIconButton({
        Key key,
        this.text,
        this.textSize = 10.0,
        this.icon,
        this.iconSize = 24.0,
        this.color = Colors.white,
        this.onPressed,
        this.onLongPress,
    }) : super(key: key) {
        assert((text != null || icon != null), 'both text and icon cannot be null');
    }

    @override
    Widget build(BuildContext context) {
        return InkWell(
            child: IconButton(
                icon: _icon(),
                iconSize: iconSize,
                onPressed: onPressed == null ? null : () async {
                    HapticFeedback.lightImpact();
                    onPressed();
                },
            ),
            onLongPress: onLongPress == null ? null : () async {
                HapticFeedback.heavyImpact();
                onLongPress();
            },
        );
    }

    Widget _icon() {
        if(icon != null) return Icon(icon, color: color);
        return Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: color,
                fontWeight: LunaUI.FONT_WEIGHT_BOLD,
                fontSize: textSize,
            ),
        );
    }
}