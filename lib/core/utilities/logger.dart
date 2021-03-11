import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:path_provider/path_provider.dart';

class LunaLogger {
    static String get checkLogsMessage => 'lunasea.CheckLogsMessage'.tr();

    /// Initialize the logger by setting the timestamp format and capturing errors on [FlutterError.onError].
    void initialize() {
        LunaFirebaseAnalytics().setEnabledState();
        LunaFirebaseCrashlytics().setEnabledState();
        FlutterError.onError = (FlutterErrorDetails details, { bool forceReport = false }) async {
            if (kDebugMode) FlutterError.dumpErrorToConsole(details, forceReport: forceReport);
            LunaFirebaseCrashlytics.instance.recordFlutterError(details);
            Zone.current.handleUncaughtError(details.exception, details.stack);
        };
        _compactDatabase();
    }

    /// Compact the logs database.
    /// 
    /// If the logs box has over 250 entries, will only store the latest 100.
    Future<void> _compactDatabase() async {
        if(Database.logsBox.keys.length <= 100) return;
        List<LunaLogHiveObject> logs = Database.logsBox.values.toList();
        logs.sort((a,b) => (b?.timestamp?.toDouble() ?? double.maxFinite).compareTo(a?.timestamp?.toDouble() ?? double.maxFinite));
        Database.logsBox.clear();
        Database.logsBox.addAll(logs.getRange(0, 100));
    }

    /// Export all logs, and return the [File] object containing the log file.
    Future<File> exportLogs() async {
        String logs = '';
        Database.logsBox.values.forEach((log) {
            if(log != null) logs = logs + log.toString() + '\n';
        });
        Directory tempDirectory = await getTemporaryDirectory();
        String path = '${tempDirectory.path}/logs.txt';
        File file = File(path);
        await file?.writeAsString(logs);
        return file;
    }

    /// Clear all logs currently saved to the database.
    Future<void> clearLogs() async => Database().clearLogsBox();

    /// Log a new warning-level log.
    void warning(String className, String methodName, String message) {
        LunaLogHiveObject log =LunaLogHiveObject(
            type: LunaLogType.WARNING,
            className: className,
            methodName: methodName,
            message: message,
        );
        Database.logsBox.add(log);
    }

    /// Log a new error-level log.
    void error(String message, dynamic error, StackTrace stackTrace) {
        if(LunaFirebaseCrashlytics.instance.isCrashlyticsCollectionEnabled && !(error is DioError)) LunaFirebaseCrashlytics.instance.recordError(error, stackTrace);
        LunaLogHiveObject log =LunaLogHiveObject(
            type: LunaLogType.ERROR,
            message: message,
            error: error,
            stackTrace: stackTrace,
        );
        Database.logsBox.add(log);
    }

    /// Log a new fatal-level log.
    void fatal(dynamic error, StackTrace stackTrace) {
        if(LunaFirebaseCrashlytics.instance.isCrashlyticsCollectionEnabled && !(error is DioError)) LunaFirebaseCrashlytics.instance.recordError(error, stackTrace);
        LunaLogHiveObject log =LunaLogHiveObject(
            type: LunaLogType.FATAL,
            message: "A fatal error has occurred",
            error: error,
            stackTrace: stackTrace,
        );
        Database.logsBox.add(log);
        Database.logsBox.close();
    }
}
