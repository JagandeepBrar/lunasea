import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

export 'luna_ui/appbar.dart';
export 'luna_ui/bottom_navigation_bar.dart';
export 'luna_ui/button.dart';
export 'luna_ui/card.dart';
export 'luna_ui/colors.dart';
export 'luna_ui/containers.dart';
export 'luna_ui/decoration.dart';
export 'luna_ui/icons.dart';
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
export 'luna_ui/text.dart';

class LunaUI {
    final String textEmDash = '—';
    final String textBullet = '•';
    final String textRightArrow = '→';
    final String textLeftArrow = '←';
    final String textEllipsis = '…';
    
    final double fontSizeAppBar = 18.0;
    final double fontSizeButton = 14.0;
    final double fontSizeNavigationBar = 13.0;
    final double fontSizeMessages = 16.0;
    final double fontSizeTitle = 16.0;
    final double fontSizeSubtitle = 13.0;
    final FontWeight fontWeightBold = FontWeight.w600;

    final int animationUISpeed = 250;
    final int animationImageFadeInSpeed = 125;
    final double borderRadius = 10.0;
    final double elevation = 0.0;

    bool shouldUseBorder() => LunaDatabaseValue.THEME_AMOLED.data && LunaDatabaseValue.THEME_AMOLED_BORDER.data;
    ShapeBorder shapeBorder() => shouldUseBorder() ? LunaShapeBorder.roundedWithBorder() : LunaShapeBorder.rounded();
}
