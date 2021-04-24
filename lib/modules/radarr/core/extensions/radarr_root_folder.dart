import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

extension LunaRadarrRootFolderExtension on RadarrRootFolder {
  String get lunaPath {
    if (this.path != null && this.path.isNotEmpty) return this.path;
    return LunaUI.TEXT_EMDASH;
  }

  String get lunaSpace {
    return this.freeSpace?.lunaBytesToString() ?? LunaUI.TEXT_EMDASH;
  }
}
