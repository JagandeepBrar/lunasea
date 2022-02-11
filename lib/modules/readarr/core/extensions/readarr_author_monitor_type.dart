import 'package:lunasea/core.dart';
import 'package:lunasea/modules/readarr.dart';

extension LunaReadarrAuthorMonitorTypeExtension on ReadarrAuthorMonitorType {
  String get lunaName {
    switch (this) {
      case ReadarrAuthorMonitorType.ALL:
        return 'All Episodes';
      case ReadarrAuthorMonitorType.FUTURE:
        return 'Future Episodes';
      case ReadarrAuthorMonitorType.MISSING:
        return 'Missing Episodes';
      case ReadarrAuthorMonitorType.EXISTING:
        return 'Existing Episodes';
      case ReadarrAuthorMonitorType.PILOT:
        return 'Pilot Episode';
      case ReadarrAuthorMonitorType.FIRST_SEASON:
        return 'Only First Season';
      case ReadarrAuthorMonitorType.LATEST_SEASON:
        return 'Only Latest Season';
      case ReadarrAuthorMonitorType.NONE:
        return 'None';
      default:
        return 'lunasea.Unknown'.tr();
    }
  }
}
