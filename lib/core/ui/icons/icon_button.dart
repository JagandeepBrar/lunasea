import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lunasea/core.dart';

class LunaIconButton extends StatelessWidget {
  final IconData icon;
  final double iconSize;
  final String text;
  final Color color;
  final Function onPressed;
  final Function onLongPress;
  final LunaLoadingState loadingState;
  final AlignmentGeometry alignment;

  LunaIconButton({
    Key key,
    this.text,
    this.icon,
    this.iconSize = LunaUI.DEFAULT_ICON_SIZE,
    this.alignment = Alignment.center,
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
        padding: EdgeInsets.zero,
        onPressed: _onPressed(),
      ),
      hoverColor: Colors.transparent,
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
      size: LunaUI.FONT_SIZE_H4,
      color: color,
      useSafeArea: false,
    );
  }

  Widget _icon() {
    if (loadingState == LunaLoadingState.ERROR) {
      return Icon(
        Icons.error_rounded,
        color: color,
      );
    } else if (icon != null) {
      return Icon(
        icon,
        color: color,
      );
    } else {
      return Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: color,
          fontWeight: LunaUI.FONT_WEIGHT_BOLD,
          fontSize: LunaUI.FONT_SIZE_H5,
        ),
      );
    }
  }
}
