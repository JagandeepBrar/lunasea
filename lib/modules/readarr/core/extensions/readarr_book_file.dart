import 'package:lunasea/core.dart';
import 'package:lunasea/modules/readarr.dart';

extension LunaReadarrBookFileExtension on ReadarrBookFile {
  String get lunaPath {
    if (this.path?.isNotEmpty ?? false) return this.path!;
    return LunaUI.TEXT_EMDASH;
  }

  String get lunaSize {
    if ((this.size ?? 0) != 0) return this.size.lunaBytesToString(decimals: 1);
    return LunaUI.TEXT_EMDASH;
  }

  String get lunaQuality {
    if (this.quality?.quality?.name != null)
      return this.quality!.quality!.name!;
    return LunaUI.TEXT_EMDASH;
  }

  String get lunaDateAdded {
    if (this.dateAdded != null)
      return this.dateAdded!.lunaDateTimeReadable(timeOnNewLine: true);
    return LunaUI.TEXT_EMDASH;
  }
}
