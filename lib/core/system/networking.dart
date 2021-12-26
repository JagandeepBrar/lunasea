import 'dart:io';

import 'package:lunasea/core.dart';

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
    if (!LunaDatabaseValue.NETWORKING_TLS_VALIDATION.data)
      client.badCertificateCallback = (cert, host, port) => true;
    return client;
  }

  /// Overrides the default [findProxyFromEnvironment] function.
  ///
  /// Currently just calls the super function to use the default finding function.
  @override
  String findProxyFromEnvironment(Uri url, Map<String, String> environment) {
    return super.findProxyFromEnvironment(url, environment);
  }
}
