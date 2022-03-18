import '../filesystem.dart';
import 'platform_web.dart';

bool isPlatformSupported() => false;
LunaFileSystem getFileSystem() => Web();
