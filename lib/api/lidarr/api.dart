import 'package:lunasea/vendor.dart';

part 'api.g.dart';

String _baseUrl(String host) {
  String base = host.endsWith('/') ? host.substring(0, host.length - 1) : host;
  return '$base/api/v3/';
}

@RestApi()
abstract class LidarrAPI {
  factory LidarrAPI({
    required String host,
    required String apiKey,
    Map<String, dynamic> headers = const {},
  }) {
    Dio dio = Dio(BaseOptions(
      headers: headers,
      followRedirects: true,
      maxRedirects: 5,
      queryParameters: {
        if (apiKey.isNotEmpty) 'apikey': apiKey,
      },
      contentType: Headers.jsonContentType,
      responseType: ResponseType.json,
    ));
    return _LidarrAPI(dio, baseUrl: _baseUrl(host));
  }
}
