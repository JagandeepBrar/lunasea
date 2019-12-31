import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:f_logs/f_logs.dart';

class Logger {
    Logger._();

    static void initialize() {
        FLog.applyConfigurations(FLog.getDefaultConfigurations());
        FlutterError.onError = (FlutterErrorDetails details) async {
            bool inDebugMode = false;
            assert(inDebugMode = true);
            if (inDebugMode) {
               FlutterError.dumpErrorToConsole(details);
            }
            Zone.current.handleUncaughtError(details.exception, details.stack);
        };
    }

    static void severe(Object error, StackTrace trace) {
        FLog.severe(
            text: error.toString(),
            stacktrace: trace,
        );
    }
}
