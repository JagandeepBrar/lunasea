import 'dart:async';
import 'dart:io';
import 'package:f_logs/f_logs.dart' show FLog, DataLogType, FormatType, LogsConfig;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:stack_trace/stack_trace.dart';

class LunaLogger {
    static const CHECK_LOGS_MESSAGE = 'Check the logs for more details';

    /// Initialize the logger by setting the timestamp format and capturing errors on [FlutterError.onError].
    void initialize() {
        LunaFirebaseCrashlytics().setEnabledState();
        LogsConfig config = FLog.getDefaultConfigurations()
            ..formatType = FormatType.FORMAT_SQUARE
            ..timestampFormat = 'MMMM dd, y - hh:mm:ss a';
        FLog.applyConfigurations(config);
        FlutterError.onError = (FlutterErrorDetails details, { bool forceReport = false }) async {
            if (kDebugMode) FlutterError.dumpErrorToConsole(details, forceReport: forceReport);
            LunaFirebaseCrashlytics.instance.recordFlutterError(details);
            Zone.current.handleUncaughtError(details.exception, details.stack);
        };
    }

    /// Log a new debug-level log.
    void debug(String text) => FLog.debug(
        text: text,
        dataLogType: DataLogType.DEFAULT.toString(),
    );

    /// Log a new warning-level log.
    void warning(String className, String methodName, String text) => FLog.warning(
        className: className,
        methodName: methodName,
        text: text,
        dataLogType: DataLogType.DEFAULT.toString(),
    );

    /// Log a new error-level log.
    void error(String text, dynamic error, StackTrace stack) {
        LunaFirebaseCrashlytics.instance.recordError(error, stack)
        .catchError((error) {
            print(error);
        });
        Trace _trace = stack == null ? null : Trace.from(stack);
        FLog.error(
            className: (_trace?.frames?.length ?? 0) >= 1 ? _trace.frames[1].uri.toString() ?? 'Unknown' : 'Unknown',
            methodName: (_trace?.frames?.length ?? 0) >= 1 ? _trace.frames[1].member.toString() ?? 'Unknown' : 'Unknown',
            text: text,
            exception: error,
            stacktrace: stack,
            dataLogType: DataLogType.DEFAULT.toString(),
        );   
    }

    /// Log a new fatal-level log.
    void fatal(dynamic error, StackTrace stack) {
        LunaFirebaseCrashlytics.instance.recordError(error, stack);
        Trace _trace = stack == null ? null : Trace.from(stack);
        FLog.fatal(
            className: (_trace?.frames?.length ?? 0) >= 1 ? _trace.frames[1].uri.toString() ?? 'Unknown' : 'Unknown',
            methodName: (_trace?.frames?.length ?? 0) >= 1 ? _trace.frames[1].member.toString() ?? 'Unknown' : 'Unknown',
            text: error.toString(),
            exception: error,
            stacktrace: stack,
            dataLogType: DataLogType.DEFAULT.toString(),
        );
    }

    /// Export all logs, and return the [File] object containing the log file.
    Future<File> exportLogs() async => FLog.exportLogs();
    /// Clear all logs currently saved to the database.
    Future<void> clearLogs() async => FLog.clearLogs();
}
