import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

extension LunaRadarrExtraFileExtension on RadarrExtraFile {
    String get lunaRelativePath {
        if(this?.relativePath != null && this.relativePath.isNotEmpty) return this.relativePath;
        return LunaUI.TEXT_EMDASH;
    }

    String get lunaExtension {
        if(this?.extension != null && this.extension.isNotEmpty) return this.extension;
        return LunaUI.TEXT_EMDASH;
    }

    String get lunaType {
        if(this?.type != null && this.type.isNotEmpty) return this.type.lunaCapitalizeFirstLetters();
        return LunaUI.TEXT_EMDASH;
    }
}