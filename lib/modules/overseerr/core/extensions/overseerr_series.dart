import 'package:lunasea/core.dart';
import 'package:lunasea/modules/overseerr.dart';

extension LunaOverseerrSeriesExtension on OverseerrSeries? {
  String lunaTitle() {
    if (this?.name != null) return this!.name!;
    return LunaUI.TEXT_EMDASH;
  }

  String lunaYear() {
    if (this?.firstAirDate?.isEmpty ?? true) return LunaUI.TEXT_EMDASH;
    return this!.firstAirDate!.split('-')[0];
  }
}
