import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class LSIconButton extends StatelessWidget {
    final IconData icon;
    final Color color;
    final Function onPressed;
    final Function onLongPress;
    final double iconSize;

    LSIconButton({
        @required this.icon,
        this.color = Colors.white,
        this.onPressed,
        this.onLongPress,
        this.iconSize = 24.0,
    });

    @override
    Widget build(BuildContext context) => InkWell(
        child: IconButton(
            icon: LSIcon(
                icon: icon,
                color: color,
            ),
            iconSize: iconSize,
            onPressed: onPressed,
        ),
        onLongPress: onLongPress,
    );
}
