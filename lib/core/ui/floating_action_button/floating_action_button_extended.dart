import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class LSFloatingActionButtonExtended extends StatelessWidget {
    final String label;
    final Object heroTag;
    final IconData icon;
    final Color iconColor;
    final Color labelColor;
    final Color backgroundColor;
    final Function onPressed;

    LSFloatingActionButtonExtended({
        @required this.label,
        @required this.onPressed,
        @required this.icon,
        this.backgroundColor,
        this.labelColor = Colors.white,
        this.iconColor = Colors.white,
        this.heroTag,
    });

    @override
    Widget build(BuildContext context) => FloatingActionButton.extended(
        icon: LSIcon(icon: icon, color: iconColor),
        label: Text(
            label,
            style: TextStyle(
                color: labelColor,
                fontWeight: FontWeight.bold,
                fontSize: Constants.UI_FONT_SIZE_SUBTITLE,
                letterSpacing: 0.25,
            ),
        ),
        heroTag: heroTag,
        onPressed: onPressed,
        backgroundColor: backgroundColor == null
            ? LSColors.accent
            : backgroundColor,
    );
}