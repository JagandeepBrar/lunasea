import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
export 'luna_ui/appbar.dart';
export 'luna_ui/bottom_navigation_bar.dart';
export 'luna_ui/button.dart';
export 'luna_ui/card.dart';
export 'luna_ui/colors.dart';
export 'luna_ui/containers.dart';
export 'luna_ui/controllers.dart';
export 'luna_ui/decoration.dart';
export 'luna_ui/divider.dart';
export 'luna_ui/header.dart';
export 'luna_ui/highlighted_node.dart';
export 'luna_ui/icons.dart';
export 'luna_ui/input_bar.dart';
export 'luna_ui/invalid_route.dart';
export 'luna_ui/list_tile.dart';
export 'luna_ui/list_view.dart';
export 'luna_ui/loader.dart';
export 'luna_ui/message.dart';
export 'luna_ui/network_image.dart';
export 'luna_ui/popup_menu_button.dart';
export 'luna_ui/refresh_indicator.dart';
export 'luna_ui/shape.dart';
export 'luna_ui/sliver_sticky_header.dart';
export 'luna_ui/snackbar.dart';
export 'luna_ui/switch.dart';
export 'luna_ui/table.dart';
export 'luna_ui/text.dart';

class LunaUI {
    // Text Constants
    static const String         TEXT_ARROW_LEFT = '←';
    static const String         TEXT_ARROW_RIGHT = '→';
    static const String         TEXT_BULLET = '•';
    static const String         TEXT_ELLIPSIS = '…';
    static const String         TEXT_EMDASH = '—';
    // Font-Related
    static const double         FONT_SIZE_APP_BAR = 18.0;
    static const double         FONT_SIZE_BUTTON = 14.0;
    static const double         FONT_SIZE_GRAPH_LEGEND = 10.0;
    static const double         FONT_SIZE_HEADER = 18.0;
    static const double         FONT_SIZE_HIGHLIGHTED_NODE = 12.0;
    static const double         FONT_SIZE_MESSAGES = 16.0;
    static const double         FONT_SIZE_NAVIGATION_BAR = 13.0;
    static const double         FONT_SIZE_SUBHEADER = 12.0;
    static const double         FONT_SIZE_SUBTITLE = 13.0;
    static const double         FONT_SIZE_TITLE = 16.0;
    static const FontWeight     FONT_WEIGHT_BOLD = FontWeight.w600;
    // UI-Related
    static const int            ANIMATION_SPEED = 250;
    static const int            ANIMATION_IMAGE_FADE_IN_SPEED = 125;
    static const double         BORDER_RADIUS = 10.0;
    static const double         ELEVATION = 0.0;
    static const EdgeInsets     MARGIN_CARD = const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0);
    // Border-Related
    static bool get shouldUseBorder => LunaDatabaseValue.THEME_AMOLED.data && LunaDatabaseValue.THEME_AMOLED_BORDER.data;
    static ShapeBorder get shapeBorder => shouldUseBorder ? LunaShapeBorder.roundedWithBorder() : LunaShapeBorder.rounded();
}
