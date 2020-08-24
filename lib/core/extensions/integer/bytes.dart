import 'package:lunasea/core/constants.dart';

extension IntegerBytesExtension on int {
    String _bytesToString({ int decimals = 2, position = 0, bool bytes = true }) {
        if(this == null || this <= 0) return '${0.toStringAsFixed(decimals)} B';
        int chunk = bytes ? 1024 : 1000;
        double size = this.toDouble();
        while(size > chunk) {
            size /= chunk;
            position++;
        }
        return '${size.toStringAsFixed(decimals)} ${bytes ? Constants.BYTE_SIZES[position] : Constants.BIT_SIZES[position]}';
    }

    // ignore: non_constant_identifier_names
    String lsBytes_BytesToString({ int decimals = 2, bool bytes = true }) => _bytesToString(decimals: decimals, position: 0, bytes: bytes);
    // ignore: non_constant_identifier_names
    String lsBytes_KilobytesToString({ int decimals = 2, bool bytes = true }) => _bytesToString(decimals: decimals, position: 1, bytes: bytes);
    // ignore: non_constant_identifier_names
    String lsBytes_MegabytesToString({ int decimals = 2, bool bytes = true }) => _bytesToString(decimals: decimals, position: 2, bytes: bytes);
    // ignore: non_constant_identifier_names
    String lsBytes_GigabytesToString({ int decimals = 2, bool bytes = true }) => _bytesToString(decimals: decimals, position: 3, bytes: bytes);
}
