import 'package:lunasea/api/sabnzbd/types/clear_history.dart';
import 'package:lunasea/vendor.dart';

extension SABnzbdClearHistoryExtension on SABnzbdClearHistory {
  String get readable {
    switch (this) {
      case SABnzbdClearHistory.ALL:
        return 'sabnzbd.All'.tr();
      case SABnzbdClearHistory.COMPLETED:
        return 'sabnzbd.Completed'.tr();
      case SABnzbdClearHistory.FAILED:
        return 'sabnzbd.Failed'.tr();
    }
  }
}
