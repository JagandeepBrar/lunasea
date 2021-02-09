import 'dart:io';

class LunaNetworking extends HttpOverrides {
    /// Initialize the default HTTP client by setting [HttpOverrides]'s global HTTP client to [LunaNetworking].
    void initialize() {
        HttpOverrides.global = LunaNetworking();
    }

    /// Overrides the default [createHttpClient] function and ensures all HTTPS connections allow bad certificate connections.
    ///
    /// Returns a new [HttpClient] using the given [context].
    @override
    HttpClient createHttpClient(SecurityContext context) {
        final HttpClient client = super.createHttpClient(context);
        client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
        return client;
    }
}
