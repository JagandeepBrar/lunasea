import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:lunasea/core/constants.dart';
import 'package:lunasea/core/database.dart';
import 'package:sentry/sentry.dart';
import 'package:stack_trace/stack_trace.dart';
import 'package:f_logs/f_logs.dart' show FLog, DataLogType, FormatType, LogsConfig;
export 'package:dio/dio.dart' show DioError;

class LunaLogger {
    LunaLogger._();
    static final SentryClient _sentry = SentryClient(dsn: Constants.SENTRY_DSN);

    static void initialize() {
        LogsConfig config = FLog.getDefaultConfigurations()
            ..formatType = FormatType.FORMAT_SQUARE
            ..timestampFormat = 'MMMM dd, y - hh:mm:ss a';
        FLog.applyConfigurations(config);
        FlutterError.onError = (FlutterErrorDetails details, { bool forceReport = false }) async {
            bool inDebugMode = false;
            assert(inDebugMode = true);
            if (inDebugMode) {
               FlutterError.dumpErrorToConsole(details, forceReport: forceReport);
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

    static void error(String className, String methodName, String text, dynamic error, StackTrace stack, {
        DataLogType type = DataLogType.DEFAULT,
        bool uploadToSentry = true,
    }) {
        FLog.error(
            className: className,
            methodName: methodName,
            text: text,
            exception: error,
            stacktrace: stack,
            dataLogType: type.toString(),
        );
        if(uploadToSentry && LunaSeaDatabaseValue.ENABLED_SENTRY.data) _sentry.captureException(
            exception: error,
            stackTrace: stack,
        );
    }

    static void fatal(dynamic error, StackTrace stack, {
        DataLogType type = DataLogType.DEFAULT,
        bool uploadToSentry = true,
    }) {
        Trace _trace = Trace.from(stack);
        FLog.fatal(
            className: _trace.frames.length >= 1 ? _trace.frames[1].uri.toString() ?? 'Unknown' : 'Unknown',
            methodName: _trace.frames.length >= 1 ? _trace.frames[1].member.toString() ?? 'Unknown' : 'Unknown',
            text: error.toString(),
            exception: error,
            stacktrace: stack,
            dataLogType: type.toString(),
        );
        if(LunaSeaDatabaseValue.ENABLED_SENTRY.data) _sentry.captureException(
            exception: error,
            stackTrace: stack,
        );
    }

    static Future<File> exportLogs() async => FLog.exportLogs();

    static Future<void> clearLogs() async => FLog.clearLogs();
}
