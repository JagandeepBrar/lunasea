import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class LSFloatingActionButton extends StatelessWidget {
    final Object heroTag;
    final IconData icon;
    final Color iconColor;
    final Color backgroundColor;
    final Function onPressed;

    LSFloatingActionButton({
        @required this.onPressed,
        @required this.icon,
        this.backgroundColor,
        this.iconColor = Colors.white,
        this.heroTag,
    });

    @override
    Widget build(BuildContext context) => FloatingActionButton(
        child: LSIcon(icon: icon, color: iconColor),
        heroTag: heroTag,
        onPressed: onPressed,
        backgroundColor: backgroundColor == null
            ? LSColors.accent
            : backgroundColor,
    );
}