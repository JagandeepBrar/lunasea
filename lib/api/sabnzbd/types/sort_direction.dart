import 'package:lunasea/types/enum_serializable.dart';

enum SABnzbdSortDirection with EnumSerializable {
  ASCENDING('asc'),
  DESCENDING('desc');

  @override
  final String value;

  const SABnzbdSortDirection(this.value);
}
