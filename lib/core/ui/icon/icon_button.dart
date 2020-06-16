import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class LSIconButton extends StatelessWidget {
    final IconData icon;
    final Color color;
    final Function onPressed;
    final double iconSize;

    LSIconButton({
        @required this.icon,
        this.color = Colors.white,
        this.onPressed,
        this.iconSize = 24.0,
    });

    @override
    Widget build(BuildContext context) => IconButton(
        icon: LSIcon(
            icon: icon,
            color: color,
        ),
        iconSize: iconSize,
        onPressed: onPressed,
    );
}
