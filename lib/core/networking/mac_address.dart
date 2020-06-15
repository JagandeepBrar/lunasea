import 'package:convert/convert.dart';

class MacAddress {
    static const String _REGEX = r"^([0-9A-Fa-f]{2}[:]){5}([0-9A-Fa-f]{2})$";
    final String _address;

    MacAddress._internal(this._address);
    factory MacAddress.from(String address) {
        if(!MacAddress.validate(address)) throw FormatException('Not a valid MAC address string');
        return MacAddress._internal(address);
    }

    String get address => _address;
    List<int> get bytes => _getBytes();

    //Parse the address string and returns an int array list of 6 values, each containing one block of the 
    List<int> _getBytes() => _address.split(":").map((octet) => hex.decode(octet)[0]).toList();

    /// Validate that a MAC address has been formatted correctly
    static bool validate(String address) {
        RegExp exp = new RegExp(_REGEX);
        return exp.hasMatch(address);
    }
}