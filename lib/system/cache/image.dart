// ignore: always_use_package_imports
import 'package:extended_image/extended_image.dart';

class LunaImageCache {
  Future<bool> clear() async {
    return clearDiskCachedImages();
  }
}
