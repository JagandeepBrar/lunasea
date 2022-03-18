import '../filesystem.dart';

bool isPlatformSupported() => false;
LunaFileSystem getFileSystem() =>
    throw UnsupportedError('LunaFileSystem unsupported');
