import 'package:flutter/painting.dart';

class LunaImageCache {
    /// Initialize the image cache by setting [ImageCache]'s maximumSize and maximumSizeBytes.
    static void initialize() {
        ImageCache().maximumSize = 1000;
        ImageCache().maximumSizeBytes = 128 << 20;
    }
}
