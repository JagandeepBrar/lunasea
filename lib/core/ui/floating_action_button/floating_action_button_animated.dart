import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class LSFloatingActionButtonAnimated extends StatelessWidget {
    final Object heroTag;
    final AnimatedIconData icon;
    final AnimationController controller;
    final Color iconColor;
    final Color backgroundColor;
    final Function onPressed;

    LSFloatingActionButtonAnimated({
        @required this.onPressed,
        @required this.icon,
        @required this.controller,
        this.backgroundColor,
        this.iconColor = Colors.white,
        this.heroTag,
    });

    @override
    Widget build(BuildContext context) => FloatingActionButton(
        child: AnimatedIcon(
            icon: icon,
            color: iconColor,
            progress: controller,
        ),
        heroTag: heroTag,
        onPressed: onPressed,
        backgroundColor: backgroundColor == null
            ? LSColors.accent
            : backgroundColor,
    );
}