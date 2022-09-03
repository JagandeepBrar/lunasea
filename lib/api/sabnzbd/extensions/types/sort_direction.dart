import 'package:lunasea/api/sabnzbd/types/sort_direction.dart';
import 'package:lunasea/vendor.dart';

extension SABnzbdSortDirectionExtension on SABnzbdSortDirection {
  String get readable {
    switch (this) {
      case SABnzbdSortDirection.ASCENDING:
        return 'sabnzbd.Ascending'.tr();
      case SABnzbdSortDirection.DESCENDING:
        return 'sabnzbd.Descending'.tr();
    }
  }
}
