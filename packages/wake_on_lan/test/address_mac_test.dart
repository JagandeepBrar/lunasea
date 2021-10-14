import 'package:wake_on_lan/wake_on_lan.dart' show MACAddress;
import 'package:test/test.dart';

void main() {
    _getters();
    _functionValidate();
    _factoryFrom();
}

void _getters() {
    group('Getters', () {
        String address = '00:FF:00:FF:00:FF';
        List<int> bytes = [0, 255, 0, 255, 0, 255];
        MACAddress mac = MACAddress.from(address);
        test('address', () {
            expect(mac.address, address); 
        });
        test('bytes', () {
            expect(mac.bytes, bytes);
        });
    });
}

void _functionValidate() {
    group('Function: .validate()', () {
        test('Valid String', () {
            String address = '00:00:00:00:00:00';
            expect(MACAddress.validate(address), true);
        });
        test('Null String', () {
            String? address = null;
            expect(MACAddress.validate(address), false);
        });
        test('Empty String', () {
            String address = '';
            expect(MACAddress.validate(address), false);
        });
        test('Invalid String (Alpha)', () {
            String address = 'hello';
            expect(MACAddress.validate(address), false);
        });
        test('Invalid String (MAC structure, invalid octet)', () {
            String address = '00:00:00:00:FG:00';
            expect(MACAddress.validate(address), false);
        });
        test('Invalid String (MAC structure, invalid octet)', () {
            String address = '00:00:00:00:A:00';
            expect(MACAddress.validate(address), false);
        });
    });
}

void _factoryFrom() {
    group('Factory: .from()', () {
        test('Valid Instance', () {
            String address = '00:00:00:00:00:00';
            expect(MACAddress.from(address), equals(isA<MACAddress>()));
        });
        test('Invalid Instance: Empty String', () {
            String address = '';
            expect(() => MACAddress.from(address), throwsA(isA<FormatException>()));
        });
        test('Invalid Instance: Invalid String (Alpha)', () {
            String address = 'hello';
            expect(() => MACAddress.from(address), throwsA(isA<FormatException>()));
        });
        test('Invalid Instance: Invalid String (MAC structure, invalid octet)', () {
            String address = '00:00:00:00:FG:00';
            expect(() => MACAddress.from(address), throwsA(isA<FormatException>()));
        });
        test('Invalid Instance: Invalid String (MAC structure, invalid octet)', () {
            String address = '00:00:00:00:A:00';
            expect(() => MACAddress.from(address), throwsA(isA<FormatException>()));
        });
    });
}