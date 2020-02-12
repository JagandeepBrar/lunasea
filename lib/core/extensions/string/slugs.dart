extension SlugsExtension on String {
    String lsConvertToSlug() {
        return this
            .toLowerCase()
            .replaceAll(RegExp(r'[\ \.]'), '-')
            .replaceAll(RegExp(r'[^a-zA-Z0-9\-]'), '')
            .trim();
    }
}
