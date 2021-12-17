import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class LunaLogger {
  static String get checkLogsMessage => 'lunasea.CheckLogsMessage'.tr();

  /// Initialize the logger by setting the timestamp format and capturing errors on [FlutterError.onError].
  void initialize() {
    LunaFirebaseAnalytics().setEnabledState();
    LunaFirebaseCrashlytics().setEnabledState();
    FlutterError.onError =
        (FlutterErrorDetails details, {bool forceReport = false}) async {
      if (kDebugMode)
        FlutterError.dumpErrorToConsole(details, forceReport: forceReport);
      recordCrashlyticsFlutterError(details);
      Zone.current.handleUncaughtError(details.exception, details.stack);
    };
    _compactDatabase();
  }

  /// Compact the logs database.
  ///
  /// If the logs box has over [count] entries, will only store the latest 100.
  Future<void> _compactDatabase([int count = 100]) async {
    if (Database.logsBox.keys.length <= count) return;
    List<LunaLogHiveObject> logs = Database.logsBox.values.toList();
    logs.sort((a, b) => (b?.timestamp?.toDouble() ?? double.maxFinite)
        .compareTo(a?.timestamp?.toDouble() ?? double.maxFinite));
    logs.skip(count).forEach((log) => log.delete());
  }

  /// Export all logs, and return the [File] object containing the log file.
  Future<String> exportLogs() async {
    // Get maps/JSON of all logs
    List<Map<String, dynamic>> logs = [];
    Database.logsBox.values.forEach((log) {
      if (log != null) logs.add(log.toMap());
    });
    // Create a string
    JsonEncoder encoder = const JsonEncoder.withIndent('    ');
    String data = encoder.convert(logs);
    return data;
  }

  /// Clear all logs currently saved to the database.
  Future<void> clearLogs() async => Database().clearLogsBox();

  /// Records a Crashlytics error if it passes the following checks:
  /// - In release mode
  /// - Crashlytics is enabled in the instance
  /// - Crashlytics is enabled in Hive
  /// - The error is not a DioError
  Future<void> recordCrashlyticsError(
      dynamic error, StackTrace stackTrace) async {
    if (kReleaseMode &&
        LunaFirebaseCrashlytics.isPlatformCompatible &&
        LunaFirebaseCrashlytics.instance.isCrashlyticsCollectionEnabled &&
        LunaDatabaseValue.ENABLE_FIREBASE_CRASHLYTICS.data &&
        error is! DioError)
      LunaFirebaseCrashlytics.instance.recordError(error, stackTrace);
  }

  /// Records a Crashlytics flutter error if it passes the following checks:
  /// - In release mode
  /// - Crashlytics is enabled in the instance
  /// - Crashlytics is enabled in Hive
  /// - The error is not a DioError
  Future<void> recordCrashlyticsFlutterError(
      FlutterErrorDetails details) async {
    if (kReleaseMode &&
        LunaFirebaseCrashlytics.isPlatformCompatible &&
        LunaFirebaseCrashlytics.instance.isCrashlyticsCollectionEnabled &&
        LunaDatabaseValue.ENABLE_FIREBASE_CRASHLYTICS.data &&
        error is! DioError)
      LunaFirebaseCrashlytics.instance.recordFlutterError(details);
  }

  /// Log a new debug-level log.
  void debug(String message) {
    LunaLogHiveObject log = LunaLogHiveObject.withMessage(
      type: LunaLogType.WARNING,
      message: message,
    );
    Database.logsBox.add(log);
  }

  /// Log a new warning-level log.
  void warning(String className, String methodName, String message) {
    LunaLogHiveObject log = LunaLogHiveObject.withMessage(
      type: LunaLogType.WARNING,
      className: className,
      methodName: methodName,
      message: message,
    );
    Database.logsBox.add(log);
  }

  /// Log a new error-level log.
  void error(String message, dynamic error, StackTrace stackTrace) {
    if (error is! DioError && error is! NetworkImageLoadException) {
      recordCrashlyticsError(error, stackTrace);
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
      Database.logsBox.add(log);
    }
  }

  /// Log a new critical-level log.
  void critical(dynamic error, StackTrace stackTrace) {
    if (error is! DioError && error is! NetworkImageLoadException) {
      recordCrashlyticsError(error, stackTrace);
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
      Database.logsBox.add(log);
    }
  }
}
