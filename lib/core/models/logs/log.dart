import 'package:lunasea/core.dart';
import 'package:stack_trace/stack_trace.dart';

part 'log.g.dart';

/// Hive database object containing all information on a log
@HiveType(typeId: 23, adapterName: 'LunaLogHiveObjectAdapter')
class LunaLogHiveObject extends HiveObject {
  @HiveField(0)
  final int timestamp;
  @HiveField(1)
  final LunaLogType type;
  @HiveField(2)
  final String? className;
  @HiveField(3)
  final String? methodName;
  @HiveField(4)
  final String message;
  @HiveField(5)
  final String? error;
  @HiveField(6)
  final String? stackTrace;

  LunaLogHiveObject({
    required this.timestamp,
    required this.type,
    this.className,
    this.methodName,
    required this.message,
    this.error,
    this.stackTrace,
  });

  factory LunaLogHiveObject.withMessage({
    required LunaLogType type,
    required String message,
    String? className,
    String? methodName,
  }) {
    int timestamp = DateTime.now().millisecondsSinceEpoch;
    return LunaLogHiveObject(
      timestamp: timestamp,
      type: type,
      message: message,
    );
  }

  factory LunaLogHiveObject.withError({
    required LunaLogType type,
    required String message,
    required dynamic error,
    required StackTrace? stackTrace,
    String? className,
    String? methodName,
  }) {
    int timestamp = DateTime.now().millisecondsSinceEpoch;
    Trace? trace = stackTrace == null ? null : Trace.from(stackTrace);
    String? _className, _methodName;
    if ((trace?.frames.length ?? 0) >= 1) {
      _className = trace?.frames[0].uri.toString();
      _methodName = trace?.frames[0].member.toString();
    }
    return LunaLogHiveObject(
      timestamp: timestamp,
      type: type,
      className: className ?? _className,
      methodName: methodName ?? _methodName,
      message: message,
      error: error?.toString(),
      stackTrace: trace?.toString(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "timestamp":
          DateTime.fromMillisecondsSinceEpoch(timestamp).toIso8601String(),
      "type": type.name,
      if (className?.isNotEmpty ?? false) "class_name": className,
      if (methodName?.isNotEmpty ?? false) "method_name": methodName,
      "message": message,
      if (error?.isNotEmpty ?? false) "error": error,
      if (stackTrace?.isNotEmpty ?? false)
        "stack_trace": stackTrace?.trim().split('\n') ?? [],
    };
  }
}
