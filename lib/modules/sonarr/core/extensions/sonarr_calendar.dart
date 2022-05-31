import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

extension SonarrCalendarExtension on SonarrCalendar {
  String get lunaAirTime {
    if (this.airDateUtc != null)
      return LunaSeaDatabase.USE_24_HOUR_TIME.read()
          ? DateFormat.Hm().format(this.airDateUtc!.toLocal())
          : DateFormat('hh:mm\na').format(this.airDateUtc!.toLocal());
    return LunaUI.TEXT_EMDASH;
  }

  bool get lunaHasAired {
    if (this.airDateUtc != null)
      return DateTime.now().isAfter(this.airDateUtc!.toLocal());
    return false;
  }
}
