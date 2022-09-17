import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lunasea/system/state.dart';
import 'package:lunasea/types/loading_state.dart';
import 'package:lunasea/widgets/ui.dart';

enum LunaButtonType {
  TEXT,
  ICON,
  LOADER,
}

/// A Luna-styled button.
class LunaButton extends Card {
  static const DEFAULT_HEIGHT = 46.0;

  LunaButton._({
    Key? key,
    required Widget child,
    EdgeInsets margin = LunaUI.MARGIN_HALF,
    Color? backgroundColor,
    double height = DEFAULT_HEIGHT,
    Alignment alignment = Alignment.center,
    Decoration? decoration,
    Function? onTap,
    Function? onLongPress,
    LunaLoadingState? loadingState,
  }) : super(
          key: key,
          child: InkWell(
            child: Container(
              child: child,
              decoration: decoration,
              height: height,
              alignment: alignment,
            ),
            borderRadius: BorderRadius.circular(LunaUI.BORDER_RADIUS),
            onTap: () async {
              HapticFeedback.lightImpact();
              if (onTap != null && loadingState != LunaLoadingState.ACTIVE)
                onTap();
            },
            onLongPress: () async {
              HapticFeedback.heavyImpact();
              if (onLongPress != null &&
                  loadingState != LunaLoadingState.ACTIVE) onLongPress();
            },
          ),
          margin: margin,
          color: backgroundColor != null
              ? backgroundColor.withOpacity(LunaUI.OPACITY_DIMMED)
              : Theme.of(LunaState.context)
                  .canvasColor
                  .withOpacity(LunaUI.OPACITY_DIMMED),
          shape:
              backgroundColor != null ? LunaShapeBorder() : LunaUI.shapeBorder,
          elevation: LunaUI.ELEVATION,
          clipBehavior: Clip.antiAlias,
        );

  /// Create a default button.
  ///
  /// If [LunaLoadingState] is passed in, will build the correct button based on the type.
  factory LunaButton({
    required LunaButtonType type,
    Color color = LunaColours.accent,
    Color? backgroundColor,
    String? text,
    IconData? icon,
    double iconSize = LunaUI.ICON_SIZE,
    LunaLoadingState? loadingState,
    EdgeInsets margin = LunaUI.MARGIN_HALF,
    double height = DEFAULT_HEIGHT,
    Alignment alignment = Alignment.center,
    Decoration? decoration,
    Function? onTap,
    Function? onLongPress,
  }) {
    switch (loadingState) {
      case LunaLoadingState.ACTIVE:
        return LunaButton.loader(
          color: color,
          backgroundColor: backgroundColor,
          margin: margin,
          height: height,
          alignment: alignment,
          decoration: decoration,
          onTap: onTap,
          onLongPress: onLongPress,
          loadingState: loadingState,
        );
      case LunaLoadingState.ERROR:
        return LunaButton.icon(
          icon: Icons.error_rounded,
          iconSize: iconSize,
          color: color,
          backgroundColor: backgroundColor,
          margin: margin,
          height: height,
          alignment: alignment,
          decoration: decoration,
          onTap: onTap,
          onLongPress: onLongPress,
          loadingState: loadingState,
        );
      default:
        break;
    }
    switch (type) {
      case LunaButtonType.TEXT:
        return LunaButton.text(
          text: text!,
          icon: icon,
          iconSize: iconSize,
          color: color,
          backgroundColor: backgroundColor,
          margin: margin,
          height: height,
          alignment: alignment,
          decoration: decoration,
          onTap: onTap,
          onLongPress: onLongPress,
          loadingState: loadingState,
        );
      case LunaButtonType.ICON:
        assert(icon != null);
        return LunaButton.icon(
          icon: icon,
          iconSize: iconSize,
          color: color,
          backgroundColor: backgroundColor,
          margin: margin,
          height: height,
          alignment: alignment,
          decoration: decoration,
          onTap: onTap,
          onLongPress: onLongPress,
          loadingState: loadingState,
        );
      case LunaButtonType.LOADER:
        return LunaButton.loader(
          color: color,
          backgroundColor: backgroundColor,
          margin: margin,
          height: height,
          alignment: alignment,
          decoration: decoration,
          onTap: onTap,
          onLongPress: onLongPress,
          loadingState: loadingState,
        );
    }
  }

  /// Build a button that contains a centered text string.
  factory LunaButton.text({
    required String text,
    required IconData? icon,
    double iconSize = LunaUI.ICON_SIZE,
    Color color = LunaColours.accent,
    Color? backgroundColor,
    EdgeInsets margin = LunaUI.MARGIN_HALF,
    double height = DEFAULT_HEIGHT,
    Alignment alignment = Alignment.center,
    Decoration? decoration,
    LunaLoadingState? loadingState,
    Function? onTap,
    Function? onLongPress,
  }) {
    return LunaButton._(
      child: Padding(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (icon != null)
              Padding(
                child: Icon(
                  icon,
                  color: color,
                  size: iconSize,
                ),
                padding: const EdgeInsets.only(
                    right: LunaUI.DEFAULT_MARGIN_SIZE / 2),
              ),
            Flexible(
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: LunaUI.FONT_WEIGHT_BOLD,
                  fontSize: LunaUI.FONT_SIZE_H3,
                ),
                overflow: TextOverflow.fade,
                softWrap: false,
                maxLines: 1,
              ),
            ),
          ],
        ),
        padding:
            const EdgeInsets.symmetric(horizontal: LunaUI.DEFAULT_MARGIN_SIZE),
      ),
      margin: margin,
      height: height,
      backgroundColor: backgroundColor,
      alignment: alignment,
      decoration: decoration,
      onTap: onTap,
      onLongPress: onLongPress,
      loadingState: loadingState,
    );
  }

  /// Build a button that contains a [LunaLoader].
  factory LunaButton.loader({
    EdgeInsets margin = LunaUI.MARGIN_HALF,
    Color color = LunaColours.accent,
    Color? backgroundColor,
    double height = DEFAULT_HEIGHT,
    Alignment alignment = Alignment.center,
    Decoration? decoration,
    Function? onTap,
    Function? onLongPress,
    LunaLoadingState? loadingState,
  }) {
    return LunaButton._(
      child: LunaLoader(
        useSafeArea: false,
        color: color,
        size: LunaUI.FONT_SIZE_H3,
      ),
      margin: margin,
      height: height,
      backgroundColor: backgroundColor,
      alignment: alignment,
      decoration: decoration,
      onTap: onTap,
      onLongPress: onLongPress,
      loadingState: loadingState,
    );
  }

  /// Build a button that contains a single, centered [Icon].
  factory LunaButton.icon({
    required IconData? icon,
    Color color = LunaColours.accent,
    Color? backgroundColor,
    EdgeInsets margin = LunaUI.MARGIN_HALF,
    double height = DEFAULT_HEIGHT,
    double iconSize = LunaUI.ICON_SIZE,
    Alignment alignment = Alignment.center,
    Decoration? decoration,
    Function? onTap,
    Function? onLongPress,
    LunaLoadingState? loadingState,
  }) {
    return LunaButton._(
      child: Icon(
        icon,
        color: color,
        size: iconSize,
      ),
      margin: margin,
      height: height,
      backgroundColor: backgroundColor,
      alignment: alignment,
      decoration: decoration,
      onTap: onTap,
      onLongPress: onLongPress,
      loadingState: loadingState,
    );
  }
}
