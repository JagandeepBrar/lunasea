import '../window_manager.dart';

bool isPlatformSupported() => false;
LunaWindowManager getWindowManager() =>
    throw UnsupportedError('LunaWindowManager unsupported');
