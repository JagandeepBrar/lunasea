import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:stack_trace/stack_trace.dart';

part 'log.g.dart';

/// Hive database object containing all information on a log
@HiveType(typeId: 23, adapterName: 'LunaLogHiveObjectAdapter')
class LunaLogHiveObject extends HiveObject {
    LunaLogHiveObject({
        @required this.timestamp,
        @required this.type,
        this.className,
        this.methodName,
        @required this.message,
        this.error,
        this.stackTrace,
    });

    factory LunaLogHiveObject.fromError({
        @required LunaLogType type,
        @required String message,
        String className,
        String methodName,
        dynamic error,
        StackTrace stackTrace,
    }) {
        assert(type != null);
        int timestamp = DateTime.now().millisecondsSinceEpoch;
        Trace trace = stackTrace == null ? null : Trace.from(stackTrace);
        String _className, _methodName;
        if((trace?.frames?.length ?? 0) >= 1) {
            _className =  trace.frames[0]?.uri?.toString();
            _methodName = trace.frames[0]?.member?.toString();
        }
        return LunaLogHiveObject(
            timestamp: timestamp,
            type: type,
            className: className ?? _className,
            methodName: methodName ?? _methodName,
            message: message,
            error: error.toString(),
            stackTrace: trace.toString(),
        );
    }

    Map<String, dynamic> toMap() {
        return {
            "timestamp": DateTime.fromMillisecondsSinceEpoch(timestamp).toIso8601String(),
            "type": type.name,
            if(className != null && className.isNotEmpty) "class_name": className,
            if(methodName != null && methodName.isNotEmpty) "method_name": methodName,
            "message": message,
            if(error != null && error.isNotEmpty) "error": error,
            if(stackTrace != null && stackTrace.isNotEmpty) "stack_trace": stackTrace?.trim()?.split('\n') ?? [],
        };
    }
    
    @HiveField(0)
    final int timestamp;
    @HiveField(1)
    final LunaLogType type;
    @HiveField(2)
    final String className;
    @HiveField(3)
    final String methodName;
    @HiveField(4)
    final String message;
    @HiveField(5)
    final String error;
    @HiveField(6)
    final String stackTrace;
}
