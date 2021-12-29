import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lunasea/core.dart';

class LunaIconButton extends StatelessWidget {
  final IconData? icon;
  final double iconSize;
  final String? text;
  final double textSize;
  final Color color;
  final Function? onPressed;
  final Function? onLongPress;
  final LunaLoadingState? loadingState;
  final AlignmentGeometry alignment;
  final MouseCursor? mouseCursor;

  const LunaIconButton.arrow({
    Key? key,
    this.text,
    this.textSize = LunaUI.FONT_SIZE_H5,
    this.icon = LunaIcons.ARROW_RIGHT,
    this.iconSize = LunaUI.ICON_SIZE,
    this.alignment = Alignment.center,
    this.color = Colors.white,
    this.onPressed,
    this.onLongPress,
    this.loadingState,
    this.mouseCursor,
  }) : super(key: key);

  const LunaIconButton.appBar({
    Key? key,
    this.text,
    this.textSize = LunaUI.FONT_SIZE_H5,
    this.icon,
    this.iconSize = LunaUI.ICON_SIZE,
    this.alignment = Alignment.center,
    this.color = Colors.white,
    this.onPressed,
    this.onLongPress,
    this.loadingState,
    this.mouseCursor,
  }) : super(key: key);

  const LunaIconButton({
    Key? key,
    this.text,
    this.textSize = LunaUI.FONT_SIZE_H5,
    this.icon,
    this.iconSize = LunaUI.ICON_SIZE,
    this.alignment = Alignment.center,
    this.color = Colors.white,
    this.onPressed,
    this.onLongPress,
    this.loadingState,
    this.mouseCursor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: IconButton(
        icon: loadingState == LunaLoadingState.ACTIVE ? _loader() : _icon(),
        iconSize: iconSize,
        alignment: alignment,
        padding: EdgeInsets.zero,
        onPressed: _onPressed() as void Function()?,
        mouseCursor: mouseCursor ??
            (onPressed != null ? SystemMouseCursors.click : MouseCursor.defer),
      ),
      hoverColor: Colors.transparent,
      mouseCursor: mouseCursor ??
          (onLongPress != null ? SystemMouseCursors.click : MouseCursor.defer),
      onLongPress: _onLongPress() as void Function()?,
    );
  }

  Function? _onPressed() {
    if (onPressed == null) return null;
    if (loadingState == LunaLoadingState.ACTIVE) return null;
    return () async {
      HapticFeedback.lightImpact();
      onPressed!();
    };
  }

  Function? _onLongPress() {
    if (onLongPress == null) return null;
    if (loadingState == LunaLoadingState.ACTIVE) return null;
    return () async {
      HapticFeedback.heavyImpact();
      onLongPress!();
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
    assert((text != null || icon != null), 'both text and icon cannot be null');
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
        text!,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: color,
          fontWeight: LunaUI.FONT_WEIGHT_BOLD,
          fontSize: textSize,
        ),
      );
    }
  }
}
