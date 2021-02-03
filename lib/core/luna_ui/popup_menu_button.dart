import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lunasea/core.dart';

class LunaPopupMenuButton<T> extends PopupMenuButton<T> {
    LunaPopupMenuButton({
        @required IconData icon,
        @required void Function(T) onSelected,
        @required List<PopupMenuEntry<T>> Function(BuildContext) itemBuilder,
    }) : super(
        shape: LunaDatabaseValue.THEME_AMOLED.data && LunaDatabaseValue.THEME_AMOLED_BORDER.data
            ? LSRoundedShapeWithBorder()
            : LSRoundedShape(),
        icon: LSIcon(icon: icon),
        onSelected: onSelected == null ? null : (result) {
            HapticFeedback.selectionClick();
            onSelected(result);
        },
        itemBuilder: itemBuilder,
    );
}
