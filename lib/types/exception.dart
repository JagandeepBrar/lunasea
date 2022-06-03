import 'package:lunasea/core/models/logs/log_type.dart';

abstract class LunaException implements Exception {
  LunaLogType get type;
}

mixin DebugExceptionMixin implements LunaException {
  @override
  LunaLogType get type => LunaLogType.DEBUG;
}

mixin WarningExceptionMixin implements LunaException {
  @override
  LunaLogType get type => LunaLogType.WARNING;
}

mixin ErrorExceptionMixin implements LunaException {
  @override
  LunaLogType get type => LunaLogType.ERROR;
}
