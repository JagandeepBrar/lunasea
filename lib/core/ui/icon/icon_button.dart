import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lunasea/core.dart';

class LSIconButton extends StatelessWidget {
    final IconData icon;
    final String text;
    final Color color;
    final Function onPressed;
    final Function onLongPress;
    final double iconSize;
    final double textSize;

    LSIconButton({
        this.icon,
        this.text,
        this.color = Colors.white,
        this.onPressed,
        this.onLongPress,
        this.iconSize = 24.0,
        this.textSize = 10.0,
    });

    @override
    Widget build(BuildContext context) {
        assert(text != null || icon != null, 'text and icon can not both be null');
        return InkWell(
            child: IconButton(
                icon: text != null
                    ? Text(
                        text,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: color,
                            fontWeight: FontWeight.bold,
                            fontSize: textSize,
                        ),
                    )
                    : LSIcon(icon: icon, color: color),
                iconSize: iconSize,
                onPressed: onPressed == null ? null : () async {
                    HapticFeedback.lightImpact();
                    onPressed();
                }
            ),
            onLongPress: onLongPress == null ? null : () async {
                HapticFeedback.heavyImpact();
                onLongPress();
            },
        );
    }
}
