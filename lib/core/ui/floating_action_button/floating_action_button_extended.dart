import 'package:flutter/material.dart';
import 'package:lunasea/core/constants.dart';
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
                letterSpacing: Constants.UI_LETTER_SPACING
            )
        ),
        heroTag: heroTag,
        onPressed: onPressed,
        backgroundColor: backgroundColor == null
            ? LSColors.accent
            : backgroundColor,
    );
}