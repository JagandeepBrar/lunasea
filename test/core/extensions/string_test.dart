import 'package:test/test.dart';
import 'package:lunasea/core/extensions/string.dart';

void main() {
  group('StringExtension', () {
    lunaCapitalizeFirstLetters();
    lunaConvertToSlug();
    lunaPad();
  });
  group('StringLinksExtension', () {});
}

void lunaCapitalizeFirstLetters() {
  group('lunaCapitalizeFirstLetters', () {
    test('Null Value', () {
      String value;
      expect(value.lunaCapitalizeFirstLetters(), null);
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
}

void lunaConvertToSlug() {
  group('lunaConvertToSlug', () {
    test('Null Value', () {
      String value;
      expect(value.lunaConvertToSlug(), null);
    });
    test('Empty String', () {
      String value = '';
      expect(value.lunaConvertToSlug(), '');
    });
    test('Alpha String', () {
      String value = 'LunaSea Flutter Test';
      expect(value.lunaConvertToSlug(), 'lunasea-flutter-test');
    });
    test('Number String', () {
      String value = '123 456 789';
      expect(value.lunaConvertToSlug(), '123-456-789');
    });
    test('String with Symbols', () {
      String value = 'LunaSea#Flutter / Test';
      expect(value.lunaConvertToSlug(), 'lunaseaflutter--test');
    });
    test('String with Periods', () {
      String value = 'LunaSea.Flutter.Test';
      expect(value.lunaConvertToSlug(), 'lunasea-flutter-test');
    });
  });
}

void lunaPad() {
  group('lunaPad', () {
    test('Null Value', () {
      String value;
      expect(value.lunaPad(), null);
    });
    test('Empty String, Default Padding', () {
      String value = '';
      expect(value.lunaPad(), '  ');
    });
    test('Empty String, Custom Padding', () {
      String value = '';
      expect(value.lunaPad(3, '!'), '!!!!!!');
    });
    test('String, Default Padding', () {
      String value = 'LunaSea';
      expect(value.lunaPad(), ' LunaSea ');
    });
    test('String, Custom Padding', () {
      String value = 'LunaSea';
      expect(value.lunaPad(3, '!'), '!!!LunaSea!!!');
    });
  });
}
