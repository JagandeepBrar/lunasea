import '../wake_on_lan.dart';

bool isPlatformSupported() => false;
LunaWakeOnLAN getWakeOnLAN() =>
    throw UnsupportedError('LunaWakeOnLAN unsupported');
