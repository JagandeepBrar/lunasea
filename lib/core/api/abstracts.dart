export './abstracts/calendar.dart';

abstract class API {
    void logWarning(String methodName, String text);
    void logError(String methodName, String text, Object error);
    Future<bool> testConnection(List<dynamic> values);
}

abstract class Entry {}
