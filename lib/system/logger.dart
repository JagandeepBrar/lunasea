import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/database/models/log.dart';
import 'package:lunasea/types/exception.dart';
import 'package:lunasea/types/log_type.dart';

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
    List<LunaLog> logs = LunaBox.logs.data.toList();
    logs.sort((a, b) => (b.timestamp).compareTo(a.timestamp));
    logs.skip(count).forEach((log) => log.delete());
  }

  Future<String> export() async {
    final logs = LunaBox.logs.data.map((log) => log.toJson()).toList();
    final encoder = JsonEncoder.withIndent(' '.repeat(4));
    return encoder.convert(logs);
  }

  Future<void> clear() async => LunaBox.logs.clear();

  void debug(String message) {
    LunaLog log = LunaLog.withMessage(
      type: LunaLogType.DEBUG,
      message: message,
    );
    LunaBox.logs.create(log);
  }

  void warning(String message, [String? className, String? methodName]) {
    LunaLog log = LunaLog.withMessage(
      type: LunaLogType.WARNING,
      message: message,
      className: className,
      methodName: methodName,
    );
    LunaBox.logs.create(log);
  }

  void error(String message, dynamic error, StackTrace? stackTrace) {
    if (error is! NetworkImageLoadException) {
      LunaLog log = LunaLog.withError(
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
      LunaLog log = LunaLog.withError(
        type: LunaLogType.CRITICAL,
        message: error?.toString() ?? LunaUI.TEXT_EMDASH,
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
        warning(exception.toString(), exception.runtimeType.toString());
        break;
      case LunaLogType.ERROR:
        error(exception.toString(), exception, trace);
        break;
      default:
        break;
    }
  }
}
