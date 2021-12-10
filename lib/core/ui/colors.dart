import 'package:flutter/material.dart';

class LunaColours {
  /// List of LunaSea colours in order that the should appear in a list.
  ///
  /// Use [byListIndex] to fetch the colour at the any index
  static const _LIST_COLOR_ICONS = [
    blue,
    accent,
    red,
    orange,
    purple,
    blueGrey,
  ];

  /// Core accent colour
  static const Color accent = Color(0xFF4ECCA3);

  /// Core splash colour
  static const Color splash = Color(0xFF2EA07B);

  /// Core primary colour (background)
  static const Color primary = Color(0xFF32323E);

  /// Core secondary colour (appbar, bottom bar, etc.),
  static const Color secondary = Color(0xFF282834);

  /// Blue
  static const Color blue = Color(0xFF00A8E8);

  /// Orange
  static const Color orange = Color(0xFFFF9000);

  /// Red
  static const Color red = Color(0xFFF71735);

  /// Purple
  static const Color purple = Color(0xFF9649CB);

  /// Blue Grey
  static const Color blueGrey = Color(0xFF848FA5);

  /// Shades of White
  static const Color white30 = Colors.white30;
  static const Color white70 = Colors.white70;

  /// Returns the correct colour for a graph by what layer it is on the graph canvas.
  Color byGraphLayer(int index) {
    switch (index) {
      case 0:
        return LunaColours.accent;
      case 1:
        return LunaColours.purple;
      case 2:
        return LunaColours.blue;
      default:
        return byListIndex(index);
    }
  }

  /// Return the correct colour for a list.
  /// If the index is greater than the list of colour's length, uses modulus to loop list.
  Color byListIndex(int index) {
    return _LIST_COLOR_ICONS[index % _LIST_COLOR_ICONS.length];
  }
}
