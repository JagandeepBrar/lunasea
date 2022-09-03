import 'package:lunasea/api/sabnzbd/types/priority.dart';
import 'package:lunasea/vendor.dart';

extension SABnzbdPriorityExtension on SABnzbdPriority {
  String get readable {
    switch (this) {
      case SABnzbdPriority.FORCE:
        return 'sabnzbd.Force'.tr();
      case SABnzbdPriority.HIGH:
        return 'sabnzbd.High'.tr();
      case SABnzbdPriority.NORMAL:
        return 'sabnzbd.Normal'.tr();
      case SABnzbdPriority.LOW:
        return 'sabnzbd.Low'.tr();
      case SABnzbdPriority.STOP:
        return 'sabnzbd.Stop'.tr();
      case SABnzbdPriority.DEFAULT:
        return 'sabnzbd.CategoryDefault'.tr();
      case SABnzbdPriority.PAUSED:
        return 'sabnzbd.Paused'.tr();
      case SABnzbdPriority.DUPLICATE:
        return 'sabnzbd.Duplicate'.tr();
    }
  }
}
