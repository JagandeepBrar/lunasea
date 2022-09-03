import 'package:lunasea/types/enum_serializable.dart';

enum SABnzbdClearHistory with EnumSerializable {
  ALL('all'),
  COMPLETED('completed'),
  FAILED('failed');

  @override
  final String value;

  const SABnzbdClearHistory(this.value);
}
