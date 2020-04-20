import 'dart:async';
import 'package:flutter/material.dart';
import 'package:stack_trace/stack_trace.dart';
import 'package:f_logs/f_logs.dart';

class Logger {
    Logger._();

    static void initialize() {
        LogsConfig config = FLog.getDefaultConfigurations()
            ..formatType = FormatType.FORMAT_SQUARE
            ..timestampFormat = 'MMMM dd, y - hh:mm:ss a';
        FLog.applyConfigurations(config);
        FlutterError.onError = (FlutterErrorDetails details) async {
            bool inDebugMode = false;
            assert(inDebugMode = true);
            if (inDebugMode) {
               FlutterError.dumpErrorToConsole(details);
            }
            Zone.current.handleUncaughtError(details.exception, details.stack);
        };
    }

    static void debug(String className, String methodName, String text, {DataLogType type = DataLogType.DEFAULT}) {
        FLog.debug(
            className: className,
            methodName: methodName,
            text: text,
            dataLogType: type.toString(),
        );
    }

    static void warning(String className, String methodName, String text, {DataLogType type = DataLogType.DEFAULT}) {
        FLog.warning(
            className: className,
            methodName: methodName,
            text: text,
            dataLogType: type.toString(),
        );
    }

    static void error(String className, String methodName, String text, Object error, StackTrace trace, {DataLogType type = DataLogType.DEFAULT}) {
        FLog.error(
            className: className,
            methodName: methodName,
            text: text,
            exception: Exception(error.toString()),
            stacktrace: trace,
            dataLogType: type.toString(),
        );
    }

    static void fatal(Object error, StackTrace trace, {DataLogType type = DataLogType.DEFAULT}) {
        FLog.fatal(
            className: Trace.from(trace).frames[1].uri.toString() ?? 'Unknown',
            methodName: Trace.from(trace).frames[1].member.toString() ?? 'Unknown',
            text: error.toString(),
            exception: Exception(error.toString()),
            stacktrace: trace,
            dataLogType: type.toString(),
        );
    }

    static void exportLogs() {
        FLog.exportLogs();
    }

    static void clearLogs() {
        FLog.clearLogs();
    }
}
