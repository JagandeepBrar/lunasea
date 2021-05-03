import 'dart:io';
import 'package:lunasea/core/assets.dart';
import 'package:test/test.dart';

void main() {
  group('LunaAssets', () {
    test('Blanks: Assets Exist', () {
      expect(File(LunaAssets.blankAudio).existsSync(), true);
      expect(File(LunaAssets.blankDevice).existsSync(), true);
      expect(File(LunaAssets.blankStream).existsSync(), true);
      expect(File(LunaAssets.blankUser).existsSync(), true);
      expect(File(LunaAssets.blankVideo).existsSync(), true);
    });
    test('Branding: Assets Exist', () {
      expect(File(LunaAssets.brandingFull).existsSync(), true);
      expect(File(LunaAssets.brandingLogo).existsSync(), true);
    });
    test('Services: Assets Exist', () {
      expect(File(LunaAssets.serviceBandsintown).existsSync(), true);
      expect(File(LunaAssets.serviceDiscogs).existsSync(), true);
      expect(File(LunaAssets.serviceImdb).existsSync(), true);
      expect(File(LunaAssets.serviceLastfm).existsSync(), true);
      expect(File(LunaAssets.serviceThemoviedb).existsSync(), true);
      expect(File(LunaAssets.serviceThetvdb).existsSync(), true);
      expect(File(LunaAssets.serviceTrakt).existsSync(), true);
      expect(File(LunaAssets.serviceTvmaze).existsSync(), true);
      expect(File(LunaAssets.serviceYoutube).existsSync(), true);
    });
  });
}
