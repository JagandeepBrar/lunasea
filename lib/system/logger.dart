import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:f_logs/f_logs.dart';

class Logger {
    Logger._();

    static void initialize() {
        LogsConfig config = FLog.getDefaultConfigurations()
            ..formatType = FormatType.FORMAT_SQUARE
            ..isDevelopmentDebuggingEnabled = false;
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

    static void info(String className, String methodName, String text, {DataLogType type = DataLogType.DEFAULT}) {
        FLog.info(
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

    static void error(String className, String methodName, String text, {DataLogType type = DataLogType.DEFAULT}) {
        FLog.error(
            className: className,
            methodName: methodName,
            text: text,
            dataLogType: type.toString(),
        );
    }

    static void fatal(Object error, StackTrace trace, {DataLogType type = DataLogType.DEFAULT}) {
        FLog.fatal(
            text: error.toString(),
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
