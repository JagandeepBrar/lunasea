import 'package:lunasea/api/sabnzbd/types/sort_category.dart';
import 'package:lunasea/vendor.dart';

extension SABnzbdSortCategoryExtension on SABnzbdSortCategory {
  String get readable {
    switch (this) {
      case SABnzbdSortCategory.AGE:
        return 'sabnzbd.Age'.tr();
      case SABnzbdSortCategory.NAME:
        return 'sabnzbd.Name'.tr();
      case SABnzbdSortCategory.SIZE:
        return 'sabnzbd.Size'.tr();
    }
  }
}
