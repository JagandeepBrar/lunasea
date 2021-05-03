import 'package:test/test.dart';
import 'package:lunasea/core/ui.dart';
import 'package:lunasea/core/extensions/double.dart';

void main() {
  group('DoubleExtension', () {
    lunaHoursToAge();
  });
}

void lunaHoursToAge() {
  group('lunaHoursToAge', () {
    test('Null Value', () {
      double value;
      expect(value.lunaHoursToAge(), LunaUI.TEXT_EMDASH);
    });
    test('Negative Value', () {
      double value = -1.0;
      expect(value.lunaHoursToAge(), LunaUI.TEXT_EMDASH);
    });
    test('Zero', () {
      double value = 0.0;
      expect(value.lunaHoursToAge(), 'Just Now');
    });
    test('Within 3 Minutes', () {
      double value = 0.05;
      expect(value.lunaHoursToAge(), 'Just Now');
    });
    test('1 Hour', () {
      double value = 1.0;
      expect(value.lunaHoursToAge(), '1 Hour Ago');
    });
    test('Within 48 Hours', () {
      // 1 Day (24 Hours)
      double value = 24;
      expect(value.lunaHoursToAge(), '24.0 Hours Ago');
    });
    test('Over 48 Hours', () {
      // 3 Days (72 Hours)
      double value = 72;
      expect(value.lunaHoursToAge(), '3 Days Ago');
    });
  });
}
