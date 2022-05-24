// ignore: always_use_package_imports
import '../window_manager.dart';

bool isPlatformSupported() => false;
LunaWindowManager getWindowManager() =>
    throw UnsupportedError('LunaWindowManager unsupported');
