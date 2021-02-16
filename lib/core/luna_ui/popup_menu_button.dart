import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lunasea/core.dart';

class LunaPopupMenuButton<T> extends PopupMenuButton<T> {
    LunaPopupMenuButton({
        IconData icon,
        Widget child,
        @required void Function(T) onSelected,
        @required List<PopupMenuEntry<T>> Function(BuildContext) itemBuilder,
    }) : super(
        shape: LunaUI.shapeBorder,
        icon: icon == null ? null : Icon(icon),
        child: child,
        onSelected: onSelected == null ? null : (result) {
            HapticFeedback.selectionClick();
            onSelected(result);
        },
        itemBuilder: itemBuilder,
        // TODO: Remove this once Flutter fixes the offset issue
        offset: Offset(0.0, -47.0),
    ) {
        if(icon == null) assert(child != null, 'both icon and child cannot be null');
        if(child == null) assert(icon != null, 'both icon and child cannot be null');
    }
}
