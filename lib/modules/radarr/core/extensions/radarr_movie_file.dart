import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

extension LunaRadarrMovieFileExtension on RadarrMovieFile {
    String get lunaRelativePath {
        if(relativePath?.isNotEmpty ?? false) return relativePath;
        return LunaUI.TEXT_EMDASH;
    }

    String get lunaSize {
        if(size != null && size != 0) return size.lunaBytesToString(decimals: 1);
        return LunaUI.TEXT_EMDASH;
    }

    String get lunaLanguage {
        if(languages?.isNotEmpty ?? false) return languages.map<String>((lang) => lang.name).join('\n');
        return LunaUI.TEXT_EMDASH;
    }

    String get lunaQuality {
        if(quality?.quality?.name != null) return quality.quality.name;
        return LunaUI.TEXT_EMDASH;
    }

    String get lunaDateAdded {
        if(dateAdded != null) return dateAdded.lunaDateTimeReadable(timeOnNewLine: true);
        return LunaUI.TEXT_EMDASH;
    }

    String get lunaCustomFormats {
        if(customFormats != null && customFormats.isNotEmpty) return customFormats.map<String>((format) => format.name).join('\n');
        return LunaUI.TEXT_EMDASH;
    }
}
