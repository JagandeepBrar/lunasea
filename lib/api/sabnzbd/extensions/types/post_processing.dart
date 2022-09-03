import 'package:lunasea/api/sabnzbd/types/post_processing.dart';
import 'package:lunasea/vendor.dart';

extension SABnzbdPostProcessingExtension on SABnzbdPostProcessing {
  String get readable {
    switch (this) {
      case SABnzbdPostProcessing.DEFAULT:
        return 'sabnzbd.CategoryDefault'.tr();
      case SABnzbdPostProcessing.NONE:
        return 'sabnzbd.None'.tr();
      case SABnzbdPostProcessing.REPAIR:
        return 'sabnzbd.Repair'.tr();
      case SABnzbdPostProcessing.REPAIR_UNPACK:
        return 'sabnzbd.RepairUnpack'.tr();
      case SABnzbdPostProcessing.REPAIR_UNPACK_DELETE:
        return 'sabnzbd.RepairUnpackDelete'.tr();
    }
  }
}
