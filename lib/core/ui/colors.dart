import 'package:flutter/material.dart';

class LunaColours {
    LunaColours._();

    static const LIST_COLOR_ICONS = [
        blue,
        accent,
        red,
        orange,
        purple,
        blueGrey,
    ];

    static const Color accent = Color(0xFF4ECCA3);
    static const Color splash = Color(0xFF2EA07B);
    static const Color primary = Color(0xFF32323E);
    static const Color secondary = Color(0xFF282834);

    static const Color blue = Color(0xFF00A8E8);
    static const Color orange = Color(0xFFFF9000);
    static const Color red = Color(0xFFF71735);
    static const Color purple = Color(0xFF9649CB);
    static const Color blueGrey = Color(0xFF848FA5);

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
