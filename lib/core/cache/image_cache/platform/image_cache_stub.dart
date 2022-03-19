import '../image_cache.dart';

bool isPlatformSupported() => false;
LunaImageCache getImageCache() =>
    throw UnsupportedError('LunaImageCache unsupported');
