import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

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

  Future<void> _compact([int count = 100]) async {
    if (LunaBox.logs.box.keys.length <= count) return;
    List<LunaLogHiveObject> logs = LunaBox.logs.box.values.toList();
    logs.sort((a, b) => (b.timestamp).compareTo(a.timestamp));
    logs.skip(count).forEach((log) => log.delete());
  }

  Future<String> export() async {
    final logs = LunaBox.logs.box.values.map((log) => log.toMap()).toList();
    final encoder = JsonEncoder.withIndent(' '.repeat(4));
    return encoder.convert(logs);
  }

  Future<void> clear() async => LunaBox.logs.clear();

  void debug(String message) {
    LunaLogHiveObject log = LunaLogHiveObject.withMessage(
      type: LunaLogType.WARNING,
      message: message,
    );
    LunaBox.logs.box.add(log);
  }

  void warning(String className, String methodName, String message) {
    LunaLogHiveObject log = LunaLogHiveObject.withMessage(
      type: LunaLogType.WARNING,
      className: className,
      methodName: methodName,
      message: message,
    );
    LunaBox.logs.box.add(log);
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
      LunaBox.logs.box.add(log);
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
      LunaBox.logs.box.add(log);
    }
  }
}
