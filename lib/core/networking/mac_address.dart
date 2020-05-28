import 'package:convert/convert.dart';

class MacAddress {
    final String _address;

    MacAddress._internal(this._address);
    factory MacAddress.from(String address) {
        if(!MacAddress.validate(address)) throw FormatException('Not a valid MAC address string');
        return MacAddress._internal(address);
    }

    String get address => _address;
    List<int> get bytes => _getBytes();

    //Parse the address string and returns an int array list of 6 values, each containing one block of the 
    List<int> _getBytes() {
        List<int> _bytes = List(6);
        for(int i=0; i<18; i += 3) _bytes[(i/3).floor()] = hex.decode(_address.substring(i, i+2))[0];
        return _bytes;
    }

    /// Validate that a MAC address has been formatted correctly
    static bool validate(String address) {
        try {
            //Validate the length
            if(address.length != 17) return false;
            //Validate that each block is a valid hex digit
            for(int i=0; i<18; i += 3) hex.decode(address.substring(i, i+2));
            return true;
        } catch (error) {
            return false;
        }
    }
}