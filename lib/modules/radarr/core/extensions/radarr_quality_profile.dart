import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

extension RadarrQualityProfileExtension on RadarrQualityProfile {
  String? get lunaName {
    if (this.name != null && this.name!.isNotEmpty) return this.name;
    return LunaUI.TEXT_EMDASH;
  }
}
