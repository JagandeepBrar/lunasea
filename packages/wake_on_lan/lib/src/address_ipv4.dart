/// [IPv4Address] is a helper class to ensure that your IPv4 address has been formatted correctly.
/// 
/// The class has a static function, `validate(String address)` which allows easy validation that an IPv4 address string is correctly formatted.
///
/// Create an [IPv4Address] object by using the factory `IPv4Address.from(address)` where address is a string representation of the address. The factory will call the validation function mentioned above, but will throw a [FormatException] on a poorly constructed string, so it is recommended to validate it first.
class IPv4Address {
    static const String _REGEX = r"\b((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)(\.|$)){4}\b";
    final String _address;

    IPv4Address._internal(this._address);
    /// Creates [IPv4Address] from string [address].
    /// 
    /// The address should first be validated using the static function [IPv4Address.validate(address)].
    /// On an invalidly formatted [address] string, [FormatException] will be thrown.
    /// 
    /// When using for Wake on LAN functionality, please ensure this address is the broadcast IPv4 address of your network.
    /// This typically is the IPv4 address of your machine with the last block set to 255.
    /// _This can differ depending on the subnet mask used for the network_.
    factory IPv4Address.from(String address) {
        if(!IPv4Address.validate(address)) throw FormatException('Not a valid IPv4 address string');
        return IPv4Address._internal(address);
    }

    /// String representation of the address
    String get address => _address;

    /// Validate that an IPv4 address in string [address] is correctly formatted.
    /// 
    /// Returns [true] on a valid address, [false] on a poorly formatted [address].
    static bool validate(String? address) {
        if(address == null) return false;
        RegExp exp = RegExp(_REGEX);
        return exp.hasMatch(address);
    }
}
