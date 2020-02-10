import 'package:lunasea/core.dart';

extension BytesExtension on int {
    String toStringFromBytes({ int decimals = 2 }) {
        int position = 0;
        double size = this.toDouble();
        while(size > 1024) {
            size /= 1024;
            position++;
        }
        return '${size.toStringAsFixed(decimals)} ${Constants.BYTE_SIZES[position]}';
    }
}
