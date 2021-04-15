import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

extension LunaRadarrManualImportExtension on RadarrManualImport {
    String get lunaLanguage {
        if((languages?.length ?? 0) > 1) return 'Multi-Language';
        if((languages?.length ?? 0) == 1) return languages[0].name;
        return LunaUI.TEXT_EMDASH;
    }

    String get lunaQualityProfile {
        return quality?.quality?.name ?? LunaUI.TEXT_EMDASH;
    }

    String get lunaSize {
        return size?.lunaBytesToString() ?? LunaUI.TEXT_EMDASH;
    }

    String get lunaMovie {
        if(movie == null) return LunaUI.TEXT_EMDASH;
        String title = movie.title ?? LunaUI.TEXT_EMDASH;
        int year = (movie.year ?? 0) == 0 ? null : movie.year;
        return [
            title,
            if(year != null) '($year)',
        ].join(' ');
    }
}
