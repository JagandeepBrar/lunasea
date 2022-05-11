import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class LunaFloatingActionButtonAnimated extends StatelessWidget {
  final Object? heroTag;
  final AnimatedIconData icon;
  final AnimationController? controller;
  final Color color;
  final Color backgroundColor;
  final Function onPressed;

  const LunaFloatingActionButtonAnimated({
    Key? key,
    required this.onPressed,
    required this.icon,
    required this.controller,
    this.backgroundColor = LunaColours.accent,
    this.color = Colors.white,
    this.heroTag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: AnimatedIcon(
        icon: icon,
        color: color,
        progress: controller!,
      ),
      heroTag: heroTag,
      onPressed: onPressed as void Function()?,
      backgroundColor: backgroundColor,
    );
  }
}
