import 'package:lunasea/types/enum_serializable.dart';

enum SABnzbdSortCategory with EnumSerializable {
  AGE('avg_age'),
  NAME('name'),
  SIZE('size');

  @override
  final String value;

  const SABnzbdSortCategory(this.value);
}
