extension StringLanguageExtension on String {
    // ignore: non_constant_identifier_names
    lsLanguage_Capitalize() {
        List<String> split = this.split(' ');
        for(var i=0; i<split.length; i++) {
            split[i] = split[i].substring(0, 1).toUpperCase()+split[i].substring(1);
        }
        return split.join(' ');
    }
}
