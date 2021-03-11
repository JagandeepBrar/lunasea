import 'dart:async';
import 'dart:convert';
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
    /// If the logs box has over [count] entries, will only store the latest 100.
    Future<void> _compactDatabase([int count = 100]) async {
        if(Database.logsBox.keys.length <= count) return;
        List<LunaLogHiveObject> logs = Database.logsBox.values.toList();
        logs.sort((a,b) => (b?.timestamp?.toDouble() ?? double.maxFinite).compareTo(a?.timestamp?.toDouble() ?? double.maxFinite));
        logs.skip(count).forEach((log) => log.delete());
    }

    /// Export all logs, and return the [File] object containing the log file.
    Future<File> exportLogs() async {
        // Get maps/JSON of all logs
        List<Map<String, dynamic>> logs = [];
        Database.logsBox.values.forEach((log) {
            if(log != null) logs.add(log.toMap());
        });
        // Create a string
        JsonEncoder encoder = JsonEncoder.withIndent('    ');
        String data = encoder.convert(logs);
        // Write the JSON to the temporary directory, return the file
        Directory tempDirectory = await getTemporaryDirectory();
        String path = '${tempDirectory.path}/logs.json';
        File file = File(path);
        await file?.writeAsString(data);
        return file;
    }

    /// Clear all logs currently saved to the database.
    Future<void> clearLogs() async => Database().clearLogsBox();

    /// Log a new warning-level log.
    void warning(String className, String methodName, String message) {
        LunaLogHiveObject log =LunaLogHiveObject.fromError(
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
        LunaLogHiveObject log =LunaLogHiveObject.fromError(
            type: LunaLogType.ERROR,
            message: message,
            error: error,
            stackTrace: stackTrace,
        );
        Database.logsBox.add(log);
    }

    /// Log a new critical-level log.
    void critical(dynamic error, StackTrace stackTrace) {
        if(!(error is DioError)) {
            if(LunaFirebaseCrashlytics.instance.isCrashlyticsCollectionEnabled) LunaFirebaseCrashlytics.instance.recordError(error, stackTrace);
            LunaLogHiveObject log =LunaLogHiveObject.fromError(
                type: LunaLogType.CRITICAL,
                message: "A critical error has occurred",
                error: error,
                stackTrace: stackTrace,
            );
            Database.logsBox.add(log);
        }
    }
}
