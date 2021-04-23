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
  final LunaLoadingState loadingState;
  final AlignmentGeometry alignment;
  final EdgeInsetsGeometry padding;

  LunaIconButton({
    Key key,
    this.text,
    this.textSize = 10.0,
    this.icon,
    this.iconSize = 24.0,
    this.alignment = Alignment.center,
    this.padding = const EdgeInsets.all(8.0),
    this.color = Colors.white,
    this.onPressed,
    this.onLongPress,
    this.loadingState,
  }) : super(key: key) {
    assert((text != null || icon != null), 'both text and icon cannot be null');
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: IconButton(
        icon: loadingState == LunaLoadingState.ACTIVE ? _loader() : _icon(),
        iconSize: iconSize,
        alignment: alignment,
        padding: padding,
        onPressed: _onPressed(),
      ),
      onLongPress: _onLongPress(),
    );
  }

  Function _onPressed() {
    if (onPressed == null) return null;
    if (loadingState == LunaLoadingState.ACTIVE) return null;
    return () async {
      HapticFeedback.lightImpact();
      onPressed();
    };
  }

  Function _onLongPress() {
    if (onLongPress == null) return null;
    if (loadingState == LunaLoadingState.ACTIVE) return null;
    return () async {
      HapticFeedback.heavyImpact();
      onLongPress();
    };
  }

  Widget _loader() {
    return LunaLoader(
      size: 12.0,
      color: color,
      useSafeArea: false,
    );
  }

  Widget _icon() {
    if (icon != null) return Icon(icon, color: color);
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
