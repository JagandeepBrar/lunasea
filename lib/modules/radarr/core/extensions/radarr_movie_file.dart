import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

extension LunaRadarrMovieFileExtension on RadarrMovieFile {
    String get lunaRelativePath {
        if(this?.relativePath != null && this.relativePath.isNotEmpty) return this.relativePath;
        return Constants.TEXT_EMDASH;
    }

    String get lunaSize {
        if(this?.size != null && this.size != 0) return this.size.lunaBytesToString(decimals: 1);
        return Constants.TEXT_EMDASH;
    }

    String get lunaQuality {
        if(this?.quality?.quality?.name != null) return this.quality.quality.name;
        return Constants.TEXT_EMDASH;
    }

    String get lunaDateAdded {
        if(this?.dateAdded != null) return this.dateAdded.lunaDateReadable;
        return Constants.TEXT_EMDASH;
    }

    String get lunaCustomFormats {
        if(this?.customFormats != null) return this.customFormats.map<String>((format) => format.name).join('\n');
        return Constants.TEXT_EMDASH;
    }
}
