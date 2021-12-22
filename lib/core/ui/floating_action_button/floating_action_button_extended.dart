import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class LunaFloatingActionButtonExtended extends StatelessWidget {
  final Color color;
  final Color backgroundColor;
  final IconData icon;
  final String label;
  final void Function() onPressed;
  final Object heroTag;

  const LunaFloatingActionButtonExtended({
    Key key,
    @required this.icon,
    @required this.label,
    @required this.onPressed,
    this.backgroundColor = LunaColours.accent,
    this.color = Colors.white,
    this.heroTag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      icon: Icon(icon, color: color),
      onPressed: onPressed,
      label: Text(
        label,
        style: TextStyle(
          color: color,
          fontWeight: LunaUI.FONT_WEIGHT_BOLD,
          fontSize: LunaUI.FONT_SIZE_H3,
          letterSpacing: 0.35,
        ),
      ),
      backgroundColor: backgroundColor,
      heroTag: heroTag,
    );
  }
}
