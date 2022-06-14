extension IntegerAsBytesExtension on int? {
  static const _BIT_CHUNK = 1000;
  static const _BIT_SIZES = ['b', 'Kb', 'Mb', 'Gb', 'Tb', 'Pb', 'Eb'];

  static const _BYTE_CHUNK = 1024;
  static const _BYTE_SIZES = ['B', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB'];

  String _toBits(int decimals, int position) {
    if (this == null || this! <= 0) return '${0.toStringAsFixed(decimals)} B';

    int idx = position;
    double size = this!.toDouble();

    while (size > _BIT_CHUNK) {
      size /= _BIT_CHUNK;
      idx++;
    }

    return '${size.toStringAsFixed(decimals)} ${_BIT_SIZES[idx]}';
  }

  String _toBytes(int decimals, int position) {
    if (this == null || this! <= 0) return '${0.toStringAsFixed(decimals)} B';

    int idx = position;
    double size = this!.toDouble();

    while (size > _BYTE_CHUNK) {
      size /= _BYTE_CHUNK;
      idx++;
    }

    return '${size.toStringAsFixed(decimals)} ${_BYTE_SIZES[idx]}';
  }

  String asBits({int decimals = 2}) => _toBits(decimals, 0);
  String asKilobits({int decimals = 2}) => _toBits(decimals, 1);
  String asMegabits({int decimals = 2}) => _toBits(decimals, 2);
  String asGigabits({int decimals = 2}) => _toBits(decimals, 3);

  String asBytes({int decimals = 2}) => _toBytes(decimals, 0);
  String asKilobytes({int decimals = 2}) => _toBytes(decimals, 1);
  String asMegabytes({int decimals = 2}) => _toBytes(decimals, 2);
  String asGigabytes({int decimals = 2}) => _toBytes(decimals, 3);
}
