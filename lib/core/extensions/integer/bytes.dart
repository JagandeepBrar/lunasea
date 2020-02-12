import 'package:lunasea/core/constants.dart';

extension IntegerBytesExtension on int {
    String _bytesToString({ int decimals = 2, position = 0 }) {
        if(this == null || this <= 0) return '${0.toStringAsFixed(decimals)} B';
        double size = this.toDouble();
        while(size > 1024) {
            size /= 1024;
            position++;
        }
        return '${size.toStringAsFixed(decimals)} ${Constants.BYTE_SIZES[position]}';
    }

    // ignore: non_constant_identifier_names
    String lsBytes_BytesToString({ int decimals = 2 }) => _bytesToString(decimals: decimals, position: 0);
    // ignore: non_constant_identifier_names
    String lsBytes_KilobytesToString({ int decimals = 2 }) => _bytesToString(decimals: decimals, position: 1);
    // ignore: non_constant_identifier_names
    String lsBytes_MegabytesToString({ int decimals = 2 }) => _bytesToString(decimals: decimals, position: 2);
    // ignore: non_constant_identifier_names
    String lsBytes_GigabytesToString({ int decimals = 2 }) => _bytesToString(decimals: decimals, position: 3);
}
