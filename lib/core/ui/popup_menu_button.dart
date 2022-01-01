import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lunasea/core.dart';

class LunaPopupMenuButton<T> extends PopupMenuButton<T> {
  LunaPopupMenuButton({
    required PopupMenuItemSelected<T> onSelected,
    required PopupMenuItemBuilder<T> itemBuilder,
    Key? key,
    IconData? icon,
    Widget? child,
    String? tooltip,
  }) : super(
          key: key,
          shape: LunaUI.shapeBorder,
          tooltip: tooltip,
          icon: icon == null ? null : Icon(icon),
          child: child,
          onSelected: (result) {
            HapticFeedback.selectionClick();
            onSelected(result);
          },
          itemBuilder: itemBuilder,
        );
}
