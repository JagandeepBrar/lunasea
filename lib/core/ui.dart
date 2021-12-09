import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
export 'ui/appbar.dart';
export 'ui/banner.dart';
export 'ui/bottom_bar.dart';
export 'ui/bottom_modal_sheet.dart';
export 'ui/button.dart';
export 'ui/card.dart';
export 'ui/colors.dart';
export 'ui/containers.dart';
export 'ui/controllers.dart';
export 'ui/decoration.dart';
export 'ui/dialog.dart';
export 'ui/divider.dart';
export 'ui/drawer.dart';
export 'ui/floating_action_button.dart';
export 'ui/header.dart';
export 'ui/highlighted_node.dart';
export 'ui/icons.dart';
export 'ui/input_bar.dart';
export 'ui/list_tile.dart';
export 'ui/list_view.dart';
export 'ui/loader.dart';
export 'ui/message.dart';
export 'ui/network_image.dart';
export 'ui/popup_menu_button.dart';
export 'ui/refresh_indicator.dart';
export 'ui/scaffold.dart';
export 'ui/shape.dart';
export 'ui/snackbar.dart';
export 'ui/switch.dart';
export 'ui/table.dart';
export 'ui/text.dart';
export 'ui/theme.dart';
export 'ui/will_pop_scope.dart';

// ignore: avoid_classes_with_only_static_members
class LunaUI {
  // Text Constants
  static const String TEXT_ARROW_LEFT = '←';
  static const String TEXT_ARROW_RIGHT = '→';
  static const String TEXT_BULLET = '•';
  static const String TEXT_OBFUSCATED_PASSWORD = '••••••••••';
  static const String TEXT_ELLIPSIS = '…';
  static const String TEXT_EMDASH = '—';
  // Font-Related
  static const double FONT_SIZE_APP_BAR = 18.0;
  static const double FONT_SIZE_BUTTON = 14.0;
  static const double FONT_SIZE_GRAPH_LEGEND = 10.0;
  static const double FONT_SIZE_HEADER = 16.0;
  static const double FONT_SIZE_HIGHLIGHTED_NODE = 12.0;
  static const double FONT_SIZE_MESSAGES = 16.0;
  static const double FONT_SIZE_NAVIGATION_BAR = 13.0;
  static const double FONT_SIZE_SUBHEADER = 12.0;
  static const double FONT_SIZE_SUBTITLE = 12.0;
  static const double FONT_SIZE_TITLE = 14.0;
  static const FontWeight FONT_WEIGHT_BOLD = FontWeight.w600;
  // UI-Related
  static const int ANIMATION_SPEED = 250;
  static const int ANIMATION_IMAGE_FADE_IN_SPEED = 125;
  static const double BORDER_RADIUS = 10.0;
  static const double BUTTON_BACKGROUND_OPACITY = 0.80;
  static const double ELEVATION = 0.0;
  static const double DEFAULT_MARGIN_SIZE = 12.0;
  static const EdgeInsets MARGIN_DEFAULT = EdgeInsets.all(DEFAULT_MARGIN_SIZE);
  static const EdgeInsets MARGIN_CARD = EdgeInsets.symmetric(
    horizontal: DEFAULT_MARGIN_SIZE,
    vertical: DEFAULT_MARGIN_SIZE / 2,
  );
  // Border-Related
  static bool get shouldUseBorder =>
      LunaTheme.isAMOLEDTheme && LunaTheme.useAMOLEDBorders;
  static ShapeBorder get shapeBorder => shouldUseBorder
      ? LunaShapeBorder.roundedWithBorder()
      : LunaShapeBorder.rounded();
}
