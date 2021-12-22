import 'dart:io';
import 'package:flutter/material.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';

class LunaDesktopWindow {
  static const double _MINIMUM_WINDOW_SIZE = 400;
  static const double _INITIAL_WINDOW_SIZE = 700;

  static bool get isPlatformCompatible =>
      Platform.isWindows || Platform.isMacOS || Platform.isLinux;

  void initialize() {
    if (isPlatformCompatible) {
      doWhenWindowReady(() {
        const Size minSize = Size(_MINIMUM_WINDOW_SIZE, _MINIMUM_WINDOW_SIZE);
        const Size size = Size(_INITIAL_WINDOW_SIZE, _INITIAL_WINDOW_SIZE);

        final win = appWindow;
        win.minSize = minSize;
        win.size = size;
        win.alignment = Alignment.center;
        win.title = "LunaSea";
        win.show();
      });
    }
  }
}
