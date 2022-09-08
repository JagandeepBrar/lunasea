import 'package:lunasea/api/wake_on_lan/wake_on_lan.dart';

bool isPlatformSupported() => false;
LunaWakeOnLAN getWakeOnLAN() =>
    throw UnsupportedError('LunaWakeOnLAN unsupported');
