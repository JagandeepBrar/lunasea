extension StringSlugsExtension on String {
    // ignore: non_constant_identifier_names
    String lsSlugs_ConvertToSlug() {
        return this
            .toLowerCase()
            .replaceAll(RegExp(r'[\ \.]'), '-')
            .replaceAll(RegExp(r'[^a-zA-Z0-9\-]'), '')
            .trim();
    }
}
