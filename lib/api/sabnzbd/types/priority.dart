import 'package:lunasea/types/enum/readable.dart';
import 'package:lunasea/types/enum/serializable.dart';
import 'package:lunasea/vendor.dart';

enum SABnzbdPriority with EnumSerializable, EnumReadable {
  FORCE('2'),
  HIGH('1'),
  NORMAL('0'),
  LOW('-1'),
  PAUSED('-2'),
  DUPLICATE('-3'),
  STOP('-4'),
  DEFAULT('-100');

  @override
  final String value;

  const SABnzbdPriority(this.value);

  static List<SABnzbdPriority> get valuesForQueued {
    return SABnzbdPriority.values.skipWhile((priority) {
      if (priority == SABnzbdPriority.PAUSED) return false;
      if (priority == SABnzbdPriority.DUPLICATE) return false;
      return true;
    }).toList();
  }

  @override
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
