import 'package:flutter/material.dart';

class LunaColours {
    LunaColours._();

    static const PRIMARY_COLOR = 0xFF32323E;
    static const SECONDARY_COLOR = 0xFF282834;
    static const ACCENT_COLOR = 0xFF4ECCA3;
    static const SPLASH_COLOR = 0xFF2EA07B;

    static const LIST_COLOR_ICONS = [
        Colors.blue,
        Color(ACCENT_COLOR),
        Colors.red,
        Colors.orange,
        Colors.purpleAccent,
        Colors.blueGrey,
    ];

    static Color get accent => const Color(ACCENT_COLOR);
    static Color get primary => const Color(PRIMARY_COLOR);
    static Color get secondary => const Color(SECONDARY_COLOR);
    static Color get splash => const Color(SPLASH_COLOR);

    static Color get blue => Colors.blue;
    static Color get orange => Colors.orange;
    static Color get red => Colors.red;
    static Color get purple => Colors.purpleAccent;
    static Color get blueGrey => Colors.blueGrey;

    static Color list(int i) {
        return LIST_COLOR_ICONS[i%LIST_COLOR_ICONS.length];
    }

    static Color graph(int i) {
        switch(i) {
            case 0: return LunaColours.accent;
            case 1: return LunaColours.purple;
            case 2: return LunaColours.blue;
            default: return LunaColours.list(i);
        }
    }
}
