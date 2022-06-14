import 'package:lunasea/vendor.dart';

part 'deprecated.g.dart';

void registerDeprecatedAdapters() {
  Hive.registerAdapter(_Deprecated02Adapter());
  Hive.registerAdapter(_Deprecated03Adapter());
  Hive.registerAdapter(_Deprecated04Adapter());
  Hive.registerAdapter(_Deprecated05Adapter());
  Hive.registerAdapter(_Deprecated06Adapter());
  Hive.registerAdapter(_Deprecated07Adapter());
  Hive.registerAdapter(_Deprecated11Adapter());
}

@HiveType(typeId: 2, adapterName: '_Deprecated02Adapter') // Next: 2
class _Deprecated02 extends HiveObject {}

@HiveType(typeId: 3, adapterName: '_Deprecated03Adapter') // Next: 3
class _Deprecated03 extends HiveObject {}

@HiveType(typeId: 4, adapterName: '_Deprecated04Adapter') // Next: 1
class _Deprecated04 extends HiveObject {}

@HiveType(typeId: 5, adapterName: '_Deprecated05Adapter') // Next: 3
class _Deprecated05 extends HiveObject {}

@HiveType(typeId: 6, adapterName: '_Deprecated06Adapter') // Next: 2
class _Deprecated06 extends HiveObject {}

@HiveType(typeId: 7, adapterName: '_Deprecated07Adapter') // Next: 2
class _Deprecated07 extends HiveObject {}

@HiveType(typeId: 11, adapterName: '_Deprecated11Adapter') // Next: 5
enum _Deprecated11 {
  @HiveField(0)
  DEPRECATED,
}
