abstract class API {
    void logWarning(String methodName, String text);
    void logError(String methodName, String text, Object error, StackTrace trace);
    Future<bool> testConnection();
}
