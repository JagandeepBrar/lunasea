import 'package:lunasea/types/enum_serializable.dart';

enum SABnzbdPriority with EnumSerializable {
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
}
