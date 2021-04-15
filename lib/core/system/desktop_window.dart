import 'dart:io';
import 'package:flutter/material.dart';
import 'package:window_size/window_size.dart' as window_size;

class LunaDesktopWindow {
    static const double _MINIMUM_WINDOW_SIZE = 400;
    static bool get isPlatformCompatible => Platform.isWindows || Platform.isMacOS || Platform.isLinux;

    /// Initialize the Desktop window:
    /// - Sets the minimum window size
    void initialize() {
        if(isPlatformCompatible) {
            window_size.setWindowMinSize(Size(_MINIMUM_WINDOW_SIZE, _MINIMUM_WINDOW_SIZE));
        }
    }
}
