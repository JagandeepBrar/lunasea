import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:stack_trace/stack_trace.dart';

part 'log.g.dart';

/// Hive database object containing all information on a log
@HiveType(typeId: 23, adapterName: 'LunaLogHiveObjectAdapter')
class LunaLogHiveObject extends HiveObject {
    LunaLogHiveObject._({
        @required this.timestamp,
        @required this.type,
        @required this.className,
        @required this.methodName,
        @required this.message,
        @required this.error,
        @required this.stackTrace,
    });

    factory LunaLogHiveObject({
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
        if((trace?.frames?.length ?? 0) >= 2) {
            _className =  trace.frames[1]?.uri?.toString();
            _methodName = trace.frames[1]?.member?.toString();
        }
        return LunaLogHiveObject._(
            timestamp: timestamp,
            type: type,
            className: className ?? _className,
            methodName: methodName ?? _methodName,
            message: message,
            error: error.toString(),
            stackTrace: trace.toString(),
        );
    }

    @override
    String toString() {
        DateTime timestampObject = DateTime.fromMillisecondsSinceEpoch(timestamp);
        String header = [
            '[${timestampObject.toIso8601String()}]',
            '[${type.name}]',
            if(className != null && className.isNotEmpty) '[$className]',
            if(methodName != null && methodName.isNotEmpty) '[$methodName]',
            '[$message]',
            if(error != null && error.isNotEmpty) '[$error]',
        ].join(' ');
        return [
            header,
            if(stackTrace != null && stackTrace.isNotEmpty) stackTrace,
        ].join('\n');
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
