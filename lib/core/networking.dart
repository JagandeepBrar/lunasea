import 'dart:io';

class LunaNetworking extends HttpOverrides {
    static void initialize() => HttpOverrides.global = LunaNetworking();

    @override
    HttpClient createHttpClient(SecurityContext context) {
        final HttpClient client = super.createHttpClient(context);
        client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
        return client;
    }
}
