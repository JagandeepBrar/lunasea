import 'package:lunasea/types/log_type.dart';

abstract class LunaException implements Exception {
  LunaLogType get type;
}

mixin WarningExceptionMixin implements LunaException {
  @override
  LunaLogType get type => LunaLogType.WARNING;
}

mixin ErrorExceptionMixin implements LunaException {
  @override
  LunaLogType get type => LunaLogType.ERROR;
}
