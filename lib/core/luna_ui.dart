import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

export 'luna_ui/appbar.dart';
export 'luna_ui/bottom_navigation_bar.dart';
export 'luna_ui/colors.dart';
export 'luna_ui/decoration.dart';
export 'luna_ui/invalid_route.dart';
export 'luna_ui/list_view.dart';
export 'luna_ui/popup_menu_button.dart';
export 'luna_ui/refresh_indicator.dart';
export 'luna_ui/sliver_sticky_header.dart';
export 'luna_ui/snackbar.dart';
export 'luna_ui/switch.dart';
export 'luna_ui/text.dart';

class LunaUI {
    final double fontSizeAppBar = 18.0;
    final double fontSizeNavigationBar = 13.0;

    final FontWeight fontWeightBold = FontWeight.w600;
    final int uiNavigationSpeed = 250;

    bool shouldUseBorder() => LunaDatabaseValue.THEME_AMOLED.data && LunaDatabaseValue.THEME_AMOLED_BORDER.data;
    ShapeBorder shapeBorder() => shouldUseBorder() ? LSRoundedShapeWithBorder() : LSRoundedShape();
}
