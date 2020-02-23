import 'package:flutter/material.dart';
import 'package:lunasea/core/constants.dart';

class LSColors {
    LSColors._();

    static Color get accent => const Color(Constants.ACCENT_COLOR);
    static Color get primary => const Color(Constants.PRIMARY_COLOR);
    static Color get secondary => const Color(Constants.SECONDARY_COLOR);
    static Color get splash => const Color(Constants.SPLASH_COLOR);

    static Color list(int i) {
        return Constants.LIST_COLOR_ICONS[i%Constants.LIST_COLOR_ICONS.length];
    }
}
