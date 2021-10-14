import 'package:wake_on_lan/wake_on_lan.dart' show IPv4Address;
import 'package:test/test.dart';

void main() {
    _getters();
    _functionValidate();
    _factoryFrom();
}

void _getters() {
    group('Getters', () {
        String address = '192.168.1.1';
        IPv4Address ipv4 = IPv4Address.from(address);
        test('address', () {
            expect(ipv4.address, address); 
        });
    });
}

void _functionValidate() {
    group('Function: .validate()', () {
        test('Valid String', () {
            String address = '192.168.1.1';
            expect(IPv4Address.validate(address), true);
        });
        test('Null String', () {
            String? address = null;
            expect(IPv4Address.validate(address), false);
        });
        test('Empty String', () {
            String address = '';
            expect(IPv4Address.validate(address), false);
        });
        test('Invalid String (Alpha)', () {
            String address = 'hello';
            expect(IPv4Address.validate(address), false);
        });
        test('Invalid String (IPv4 structure, invalid octet)', () {
            String address = '192.168.1.256';
            expect(IPv4Address.validate(address), false);
        });
    });
}


void _factoryFrom() {
    group('Factory: .from()', () {
        test('Valid Instance', () {
            String address = '192.168.1.1';
            expect(IPv4Address.from(address), equals(isA<IPv4Address>()));
        });
        test('Invalid Instance: Empty String', () {
            String address = '';
            expect(() => IPv4Address.from(address), throwsA(isA<FormatException>()));
        });
        test('Invalid Instance: Invalid String (Alpha)', () {
            String address = 'hello';
            expect(() => IPv4Address.from(address), throwsA(isA<FormatException>()));
        });
        test('Invalid Instance: Invalid String (MAC structure, invalid octet)', () {
            String address = '192.168.1.256';
            expect(() => IPv4Address.from(address), throwsA(isA<FormatException>()));
        });
    });
}
