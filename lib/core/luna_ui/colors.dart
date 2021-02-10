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

    static const Color accent = const Color(ACCENT_COLOR);
    static const Color primary = const Color(PRIMARY_COLOR);
    static const Color secondary = const Color(SECONDARY_COLOR);
    static const Color splash = const Color(SPLASH_COLOR);

    static const Color blue = Colors.blue;
    static const Color orange = Colors.orange;
    static const Color red = Colors.red;
    static const Color purple = Colors.purpleAccent;
    static const Color blueGrey = Colors.blueGrey;

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
