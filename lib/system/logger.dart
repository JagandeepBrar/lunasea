import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/types/exception.dart';

class LunaLogger {
  static String get checkLogsMessage => 'lunasea.CheckLogsMessage'.tr();

  void initialize() {
    FlutterError.onError = (details) async {
      if (kDebugMode) FlutterError.dumpErrorToConsole(details);
      Zone.current.handleUncaughtError(
        details.exception,
        details.stack ?? StackTrace.current,
      );
    };
    _compact();
  }

  Future<void> _compact([int count = 50]) async {
    if (LunaBox.logs.data.length <= count) return;
    List<LunaLogHiveObject> logs = LunaBox.logs.data.toList();
    logs.sort((a, b) => (b.timestamp).compareTo(a.timestamp));
    logs.skip(count).forEach((log) => log.delete());
  }

  Future<String> export() async {
    final logs = LunaBox.logs.data.map((log) => log.toMap()).toList();
    final encoder = JsonEncoder.withIndent(' '.repeat(4));
    return encoder.convert(logs);
  }

  Future<void> clear() async => LunaBox.logs.clear();

  void debug(String message) {
    LunaLogHiveObject log = LunaLogHiveObject.withMessage(
      type: LunaLogType.WARNING,
      message: message,
    );
    LunaBox.logs.create(log);
  }

  void warning(String className, String methodName, String message) {
    LunaLogHiveObject log = LunaLogHiveObject.withMessage(
      type: LunaLogType.WARNING,
      className: className,
      methodName: methodName,
      message: message,
    );
    LunaBox.logs.create(log);
  }

  void error(String message, dynamic error, StackTrace? stackTrace) {
    if (error is! NetworkImageLoadException) {
      LunaLogHiveObject log = LunaLogHiveObject.withError(
        type: LunaLogType.ERROR,
        message: message,
        error: error,
        stackTrace: stackTrace,
      );
      if (kDebugMode) {
        print(message);
        print(error);
        print(stackTrace);
      }
      LunaBox.logs.create(log);
    }
  }

  void critical(dynamic error, StackTrace stackTrace) {
    if (error is! NetworkImageLoadException) {
      LunaLogHiveObject log = LunaLogHiveObject.withError(
        type: LunaLogType.CRITICAL,
        message: error?.toString() ?? 'Unknown critical error',
        error: error,
        stackTrace: stackTrace,
      );
      if (kDebugMode) {
        print(error);
        print(stackTrace);
      }
      LunaBox.logs.create(log);
    }
  }

  void exception(LunaException exception, [StackTrace? trace]) {
    switch (exception.type) {
      case LunaLogType.WARNING:
        // TODO: Handle this case.
        break;
      case LunaLogType.ERROR:
        // TODO: Handle this case.
        break;
      case LunaLogType.CRITICAL:
        // TODO: Handle this case.
        break;
      case LunaLogType.DEBUG:
        // TODO: Handle this case.
        break;
    }
  }
}
