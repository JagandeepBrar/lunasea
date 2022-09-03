import 'package:lunasea/api/sabnzbd/types/on_complete_action.dart';
import 'package:lunasea/vendor.dart';

extension SABnzbdOnCompleteActionExtension on SABnzbdOnCompleteAction {
  String get readable {
    switch (this) {
      case SABnzbdOnCompleteAction.SHUTDOWN_PROGRAM:
        return 'sabnzbd.ShutdownSABnzbd'.tr();
      case SABnzbdOnCompleteAction.SHUTDOWN_PC:
        return 'sabnzbd.ShutdownPC'.tr();
      case SABnzbdOnCompleteAction.HIBERNATE_PC:
        return 'sabnzbd.HibernatePC'.tr();
      case SABnzbdOnCompleteAction.STANDBY_PC:
        return 'sabnzbd.StandbyPC'.tr();
      case SABnzbdOnCompleteAction.NONE:
        return 'sabnzbd.None'.tr();
    }
  }
}
