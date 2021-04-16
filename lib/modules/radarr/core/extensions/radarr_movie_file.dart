import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

extension LunaRadarrMovieFileExtension on RadarrMovieFile {
    String get lunaRelativePath {
        if(this?.relativePath != null && this.relativePath.isNotEmpty) return this.relativePath;
        return LunaUI.TEXT_EMDASH;
    }

    String get lunaSize {
        if(this?.size != null && this.size != 0) return this.size.lunaBytesToString(decimals: 1);
        return LunaUI.TEXT_EMDASH;
    }

    String get lunaLanguage {
        if(this?.languages == null || this.languages.length == 0) return LunaUI.TEXT_EMDASH;
        return this.languages.map<String>((lang) => lang.name).join('\n');
    }

    String get lunaQuality {
        if(this?.quality?.quality?.name != null) return this.quality.quality.name;
        return LunaUI.TEXT_EMDASH;
    }

    String get lunaDateAdded {
        if(this?.dateAdded != null) return this.dateAdded.lunaDateTimeReadable(timeOnNewLine: true);
        return LunaUI.TEXT_EMDASH;
    }

    String get lunaCustomFormats {
        if(this?.customFormats != null && this.customFormats.isNotEmpty) return this.customFormats.map<String>((format) => format.name).join('\n');
        return LunaUI.TEXT_EMDASH;
    }
}
