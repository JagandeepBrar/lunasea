import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

extension LunaRadarrExtraFileExtension on RadarrExtraFile {
    String get lunaRelativePath {
        if(relativePath != null && relativePath.isNotEmpty) return relativePath;
        return LunaUI.TEXT_EMDASH;
    }

    String get lunaExtension {
        if(extension != null && extension.isNotEmpty) return extension;
        return LunaUI.TEXT_EMDASH;
    }

    String get lunaType {
        if(type != null && type.isNotEmpty) return type.lunaCapitalizeFirstLetters();
        return LunaUI.TEXT_EMDASH;
    }
}