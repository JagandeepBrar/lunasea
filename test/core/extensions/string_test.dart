import 'package:test/test.dart';
import 'package:lunasea/core/ui.dart';
import 'package:lunasea/core/extensions/string.dart';

void main() {
  group('StringExtension', () {
    group('lunaCapitalizeFirstLetters', () {
      test('Null Value', () {
        String value;
        expect(value.lunaCapitalizeFirstLetters(), LunaUI.TEXT_EMDASH);
      });
      test('Empty String', () {
        String value = '';
        expect(value.lunaCapitalizeFirstLetters(), '');
      });
      test('Single Character (Alpha/Lowercase)', () {
        String value = 'a';
        expect(value.lunaCapitalizeFirstLetters(), 'A');
      });
      test('Single Character (Alpha/Uppercase)', () {
        String value = 'A';
        expect(value.lunaCapitalizeFirstLetters(), 'A');
      });
      test('Single Character (Number)', () {
        String value = '1';
        expect(value.lunaCapitalizeFirstLetters(), '1');
      });
      test('Single Character (Symbol)', () {
        String value = '#';
        expect(value.lunaCapitalizeFirstLetters(), '#');
      });
      test('Single Word (Alpha)', () {
        String value = 'test';
        expect(value.lunaCapitalizeFirstLetters(), 'Test');
      });
      test('Multiple Words', () {
        String value = 'this is a test';
        expect(value.lunaCapitalizeFirstLetters(), 'This Is A Test');
      });
      test('Multiple Words (Includes Symbols and Numbers)', () {
        String value = 'this 1s /\\ test';
        expect(value.lunaCapitalizeFirstLetters(), 'This 1s /\\ Test');
      });
    });
  });
}
