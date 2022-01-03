import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class LunaLogger {
  static String get checkLogsMessage => 'lunasea.CheckLogsMessage'.tr();

  /// Initialize the logger by setting the timestamp format and capturing errors on [FlutterError.onError].
  void initialize() {
    FlutterError.onError = (details) async {
      if (kDebugMode) FlutterError.dumpErrorToConsole(details);
      Zone.current.handleUncaughtError(
        details.exception,
        details.stack ?? StackTrace.current,
      );
    };
    _compactDatabase();
  }

  /// Compact the logs database.
  ///
  /// If the logs box has over [count] entries, will only store the latest 100.
  Future<void> _compactDatabase([int count = 100]) async {
    if (Database.logs.box.keys.length <= count) return;
    List<LunaLogHiveObject> logs = Database.logs.box.values.toList();
    logs.sort((a, b) => (b.timestamp).compareTo(a.timestamp));
    logs.skip(count).forEach((log) => log.delete());
  }

  /// Export all logs, and return the [File] object containing the log file.
  Future<String> exportLogs() async {
    // Get maps/JSON of all logs
    List<Map<String, dynamic>> logs = [];
    Database.logs.box.values.forEach((log) => logs.add(log.toMap()));
    // Create a string
    JsonEncoder encoder = JsonEncoder.withIndent(' '.repeat(4));
    String data = encoder.convert(logs);
    return data;
  }

  /// Clear all logs currently saved to the database.
  Future<void> clearLogs() async => Database.logs.clear();

  /// Log a new debug-level log.
  void debug(String message) {
    LunaLogHiveObject log = LunaLogHiveObject.withMessage(
      type: LunaLogType.WARNING,
      message: message,
    );
    Database.logs.box.add(log);
  }

  /// Log a new warning-level log.
  void warning(String className, String methodName, String message) {
    LunaLogHiveObject log = LunaLogHiveObject.withMessage(
      type: LunaLogType.WARNING,
      className: className,
      methodName: methodName,
      message: message,
    );
    Database.logs.box.add(log);
  }

  /// Log a new error-level log.
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
      Database.logs.box.add(log);
    }
  }

  /// Log a new critical-level log.
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
      Database.logs.box.add(log);
    }
  }
}
