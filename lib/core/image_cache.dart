import 'package:flutter/material.dart';

class LunaImageCache {
    LunaImageCache._();

    static void initialize() {
        ImageCache().maximumSize = 1000;
        ImageCache().maximumSizeBytes = 128 << 20;
    }
}
