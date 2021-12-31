import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

extension LunaRadarrExtraFileExtension on RadarrExtraFile {
  String get lunaRelativePath {
    if (this.relativePath?.isNotEmpty ?? false) return this.relativePath!;
    return LunaUI.TEXT_EMDASH;
  }

  String get lunaExtension {
    if (this.extension?.isNotEmpty ?? false) return this.extension!;
    return LunaUI.TEXT_EMDASH;
  }

  String get lunaType {
    if (this.type?.isNotEmpty ?? false)
      return this.type.lunaCapitalizeFirstLetters()!;
    return LunaUI.TEXT_EMDASH;
  }
}
