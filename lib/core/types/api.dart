abstract class API {
    void logError(String text, Object error, StackTrace trace);
    Future<dynamic> testConnection();
}
