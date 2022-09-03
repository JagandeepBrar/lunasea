import 'package:lunasea/types/enum_serializable.dart';

enum SABnzbdPostProcessing with EnumSerializable {
  DEFAULT('-1'),
  NONE('0'),
  REPAIR('1'),
  REPAIR_UNPACK('2'),
  REPAIR_UNPACK_DELETE('3');

  @override
  final String value;

  const SABnzbdPostProcessing(this.value);
}
