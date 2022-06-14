// ignore: always_use_package_imports
import '../filesystem.dart';

bool isPlatformSupported() => false;
LunaFileSystem getFileSystem() =>
    throw UnsupportedError('LunaFileSystem unsupported');
