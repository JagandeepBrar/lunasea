import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

export 'package:easy_localization/easy_localization.dart';

export 'appbar.dart';
export 'banner.dart';
export 'block.dart';
export 'bottom_bar.dart';
export 'bottom_modal_sheet.dart';
export 'button.dart';
export 'card.dart';
export 'colors.dart';
export 'containers.dart';
export 'controllers.dart';
export 'dialog.dart';
export 'divider.dart';
export 'drawer.dart';
export 'floating_action_button.dart';
export 'grid_view.dart';
export 'header.dart';
export 'highlighted_node.dart';
export 'icons.dart';
export 'input_bar.dart';
export 'linear_indicator.dart';
export 'list_tile.dart';
export 'list_view.dart';
export 'loader.dart';
export 'message.dart';
export 'mixins.dart';
export 'images.dart';
export 'page_view.dart';
export 'popup_menu_button.dart';
export 'refresh_indicator.dart';
export 'scaffold.dart';
export 'scroll_behaviour.dart';
export 'shape.dart';
export 'shimmer.dart';
export 'snackbar.dart';
export 'switch.dart';
export 'table.dart';
export 'text_span.dart';
export 'text_style.dart';
export 'text.dart';
export 'theme.dart';
export 'will_pop_scope.dart';

// ignore: avoid_classes_with_only_static_members
class LunaUI {
  // Text Constants
  static const String TEXT_ARROW_LEFT = '←';
  static const String TEXT_ARROW_RIGHT = '→';
  static const String TEXT_BULLET = '•';
  static const String TEXT_OBFUSCATED_PASSWORD = '••••••••••••';
  static const String TEXT_ELLIPSIS = '…';
  static const String TEXT_EMDASH = '—';

  // <--> Font Sizes
  static const double FONT_SIZE_H1 = 18.0;
  static const double FONT_SIZE_H2 = 16.0;
  static const double FONT_SIZE_H3 = 14.0;
  static const double FONT_SIZE_H4 = 12.0;
  static const double FONT_SIZE_H5 = 10.0;

  // <--> Font Size Mappings
  static const double FONT_SIZE_BUTTON = FONT_SIZE_H3;
  static const double FONT_SIZE_GRAPH_LEGEND = FONT_SIZE_H5;
  static const double FONT_SIZE_HEADER = FONT_SIZE_H2;
  static const double FONT_SIZE_MESSAGES = FONT_SIZE_H2;
  static const double FONT_SIZE_SUBHEADER = FONT_SIZE_H3;
  static const double FONT_SIZE_SUBTITLE = FONT_SIZE_H3;
  static const double FONT_SIZE_TITLE = FONT_SIZE_H2;

  // <--> Icons
  static const double ICON_SIZE = 24.0;

  // <--> Animations
  static const int ANIMATION_SPEED = 250;
  static const int ANIMATION_SPEED_IMAGES = ANIMATION_SPEED ~/ 2;
  static const int ANIMATION_SPEED_SCROLLING = ANIMATION_SPEED * 2;
  static const int ANIMATION_SPEED_SHIMMER = ANIMATION_SPEED * 4;

  // <--> Other
  static const double BORDER_RADIUS = 10.0;
  static const double OPACITY_DIMMED = 0.75;
  static const double OPACITY_DISABLED = 0.50;
  static const double OPACITY_SPLASH = 0.25;
  static const double ELEVATION = 0.0;
  static const FontWeight FONT_WEIGHT_BOLD = FontWeight.w600;

  // <--> Margins
  static const double DEFAULT_MARGIN_SIZE = 12.0;
  static const double MARGIN_SIZE_HALF = DEFAULT_MARGIN_SIZE / 2;

  static const EdgeInsets MARGIN_DEFAULT = EdgeInsets.all(DEFAULT_MARGIN_SIZE);
  static const EdgeInsets MARGIN_HALF = EdgeInsets.all(MARGIN_SIZE_HALF);

  static const EdgeInsets MARGIN_DEFAULT_HORIZONTAL =
      EdgeInsets.symmetric(horizontal: DEFAULT_MARGIN_SIZE);
  static const EdgeInsets MARGIN_DEFAULT_VERTICAL =
      EdgeInsets.symmetric(vertical: DEFAULT_MARGIN_SIZE);

  static const EdgeInsets MARGIN_HALF_HORIZONTAL =
      EdgeInsets.symmetric(horizontal: MARGIN_SIZE_HALF);
  static const EdgeInsets MARGIN_HALF_VERTICAL =
      EdgeInsets.symmetric(vertical: MARGIN_SIZE_HALF);

  static const EdgeInsets MARGIN_H_DEFAULT_V_HALF = EdgeInsets.symmetric(
      horizontal: DEFAULT_MARGIN_SIZE, vertical: MARGIN_SIZE_HALF);
  static const EdgeInsets MARGIN_H_HALF_V_DEFAULT = EdgeInsets.symmetric(
      horizontal: MARGIN_SIZE_HALF, vertical: DEFAULT_MARGIN_SIZE);

  // <--> Borders
  static bool get shouldUseBorder {
    return LunaTheme.isAMOLEDTheme && LunaTheme.useBorders;
  }

  static ShapeBorder get shapeBorder {
    return shouldUseBorder
        ? LunaShapeBorder.roundedWithBorder()
        : LunaShapeBorder.rounded();
  }
}
