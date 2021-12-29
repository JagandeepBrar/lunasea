import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lunasea/core.dart';

class LunaPopupMenuButton<T> extends PopupMenuButton<T> {
  LunaPopupMenuButton({
    Key? key,
    IconData? icon,
    Widget? child,
    required void Function(T) onSelected,
    required List<PopupMenuEntry<T>> Function(BuildContext) itemBuilder,
    String? tooltip,
  }) : super(
          key: key,
          shape: LunaUI.shapeBorder,
          tooltip: tooltip,
          icon: icon == null ? null : Icon(icon),
          child: child,
          onSelected: onSelected == null
              ? null
              : (result) {
                  HapticFeedback.selectionClick();
                  onSelected(result);
                },
          itemBuilder: itemBuilder,
        ) {
    if (icon == null)
      assert(child != null, 'both icon and child cannot be null');
    if (child == null)
      assert(icon != null, 'both icon and child cannot be null');
  }
}
