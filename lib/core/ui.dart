import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
export 'ui/appbar.dart';
export 'ui/banner.dart';
export 'ui/block.dart';
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
export 'ui/expandable_list_tile.dart';
export 'ui/floating_action_button.dart';
export 'ui/header.dart';
export 'ui/highlighted_node.dart';
export 'ui/icons.dart';
export 'ui/input_bar.dart';
export 'ui/linear_indicator.dart';
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
  static const String TEXT_OBFUSCATED_PASSWORD = '••••••••••••';
  static const String TEXT_ELLIPSIS = '…';
  static const String TEXT_EMDASH = '—';
  // <--> Font-Related
  static const double FONT_SIZE_H1 = 18.0;
  static const double FONT_SIZE_H2 = 16.0;
  static const double FONT_SIZE_H3 = 14.0;
  static const double FONT_SIZE_H4 = 12.0;
  static const double FONT_SIZE_H5 = 10.0;
  // <--> Icon-Related
  static const double ICON_SIZE = 24.0;
  // Font-Related
  static const double FONT_SIZE_BUTTON = FONT_SIZE_H3;
  static const double FONT_SIZE_GRAPH_LEGEND = FONT_SIZE_H5;
  static const double FONT_SIZE_HEADER = FONT_SIZE_H2;
  static const double FONT_SIZE_MESSAGES = FONT_SIZE_H2;
  static const double FONT_SIZE_SUBHEADER = FONT_SIZE_H3;
  static const double FONT_SIZE_SUBTITLE = FONT_SIZE_H3;
  static const double FONT_SIZE_TITLE = FONT_SIZE_H2;
  static const FontWeight FONT_WEIGHT_BOLD = FontWeight.w600;
  // UI-Related
  static const int ANIMATION_SPEED = 250;
  static const int ANIMATION_SPEED_IMAGES = 175;
  static const double BORDER_RADIUS = 10.0;
  static const double OPACITY_BUTTON_BACKGROUND = 0.80;
  static const double OPACITY_DISABLED = 0.50;
  static const double OPACITY_SPLASH = 0.25;
  static const double ELEVATION = 0.0;
  static const double DEFAULT_MARGIN_SIZE = 12.0;
  static const EdgeInsets MARGIN_DEFAULT = EdgeInsets.all(DEFAULT_MARGIN_SIZE);
  static const EdgeInsets MARGIN_CARD = EdgeInsets.symmetric(
    horizontal: DEFAULT_MARGIN_SIZE,
    vertical: DEFAULT_MARGIN_SIZE / 2,
  );
  static const EdgeInsets MARGIN_BUTTON = EdgeInsets.symmetric(
    horizontal: DEFAULT_MARGIN_SIZE / 2,
    vertical: DEFAULT_MARGIN_SIZE / 2,
  );
  // Border-Related
  static bool get shouldUseBorder =>
      LunaTheme.isAMOLEDTheme && LunaTheme.useAMOLEDBorders;
  static ShapeBorder get shapeBorder => shouldUseBorder
      ? LunaShapeBorder.roundedWithBorder()
      : LunaShapeBorder.rounded();
}
