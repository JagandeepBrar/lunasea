import 'package:lunasea/types/enum/serializable.dart';

enum SABnzbdAction with EnumSerializable {
  FALSE('0'),
  TRUE('1');

  @override
  final String value;

  const SABnzbdAction(this.value);
}
