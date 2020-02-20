abstract class API {
    void logWarning(String methodName, String text);
    void logError(String methodName, String text, Object error);
    Future<bool> testConnection();
}
