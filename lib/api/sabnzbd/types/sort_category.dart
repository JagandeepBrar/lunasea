import 'package:lunasea/types/enum/readable.dart';
import 'package:lunasea/types/enum/serializable.dart';
import 'package:lunasea/vendor.dart';

enum SABnzbdSortCategory with EnumSerializable, EnumReadable {
  AGE('avg_age'),
  NAME('name'),
  SIZE('size');

  @override
  final String value;

  const SABnzbdSortCategory(this.value);

  @override
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
