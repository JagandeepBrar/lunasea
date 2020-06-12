class IPv4Address {
    static const String _REGEX = r"\b((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)(\.|$)){4}\b";
    final String _address;

    IPv4Address._internal(this._address);
    factory IPv4Address.from(String address) {
        if(!IPv4Address.validate(address)) throw FormatException('Not a valid IPv4 address string');
        return IPv4Address._internal(address);
    }

    String get address => _address;

    /// Validate that an IPv4 address has been formatted correctly
    static bool validate(String address) {
        RegExp exp = new RegExp(_REGEX);
        return exp.hasMatch(address);
    }
}
