const BYTE_SIZES = ['B', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB'];

extension BytesExtension on int {
    String _bytesToString({ int decimals = 2, position = 0 }) {
        if(this == null || this <= 0) return '${0.toStringAsFixed(decimals)} B';
        double size = this.toDouble();
        while(size > 1024) {
            size /= 1024;
            position++;
        }
        return '${size.toStringAsFixed(decimals)} ${BYTE_SIZES[position]}';
    }

    String lsBytesToString({ int decimals = 2 }) => _bytesToString(decimals: decimals, position: 0);
    String lsKilobytesToString({ int decimals = 2 }) => _bytesToString(decimals: decimals, position: 1);
    String lsMegabytesToString({ int decimals = 2 }) => _bytesToString(decimals: decimals, position: 2);
    String lsGigabytesToString({ int decimals = 2 }) => _bytesToString(decimals: decimals, position: 3);
}
