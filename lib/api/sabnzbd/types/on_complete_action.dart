import 'package:lunasea/types/enum_serializable.dart';

enum SABnzbdOnCompleteAction with EnumSerializable {
  SHUTDOWN_PROGRAM('shutdown_program'),
  SHUTDOWN_PC('shutdown_pc'),
  HIBERNATE_PC('hibernate_pc'),
  STANDBY_PC('standby_pc'),
  NONE('none');

  @override
  final String value;

  const SABnzbdOnCompleteAction(this.value);
}
