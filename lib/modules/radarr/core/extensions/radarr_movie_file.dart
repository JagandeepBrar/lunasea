import 'package:lunasea/core.dart';
import 'package:lunasea/extensions/datetime.dart';
import 'package:lunasea/extensions/int/bytes.dart';
import 'package:lunasea/modules/radarr.dart';

extension LunaRadarrMovieFileExtension on RadarrMovieFile {
  String get lunaRelativePath {
    if (this.relativePath?.isNotEmpty ?? false) return this.relativePath!;
    return LunaUI.TEXT_EMDASH;
  }

  String get lunaSize {
    if ((this.size ?? 0) != 0) return this.size.asBytes(decimals: 1);
    return LunaUI.TEXT_EMDASH;
  }

  String get lunaLanguage {
    if (this.languages?.isEmpty ?? true) return LunaUI.TEXT_EMDASH;
    return this.languages!.map<String?>((lang) => lang.name).join('\n');
  }

  String get lunaQuality {
    if (this.quality?.quality?.name != null)
      return this.quality!.quality!.name!;
    return LunaUI.TEXT_EMDASH;
  }

  String get lunaDateAdded {
    if (this.dateAdded != null)
      return this.dateAdded!.asDateTime(delimiter: '\n');
    return LunaUI.TEXT_EMDASH;
  }

  String get lunaCustomFormats {
    if (this.customFormats != null && this.customFormats!.isNotEmpty)
      return this
          .customFormats!
          .map<String?>((format) => format.name)
          .join('\n');
    return LunaUI.TEXT_EMDASH;
  }
}
