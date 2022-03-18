import '../networking.dart';

bool isPlatformSupported() => false;
LunaNetworking getNetworking() =>
    throw UnsupportedError('LunaNetworking unsupported');
