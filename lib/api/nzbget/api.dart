import 'package:lunasea/api/nzbget/models/status.dart';
import 'package:lunasea/api/nzbget/models/version.dart';
import 'package:lunasea/vendor.dart';

part 'api.g.dart';

String _baseUrl(String host, String user, String password) {
  String base = host.endsWith('/') ? host.substring(0, host.length - 1) : host;

  if (user.isNotEmpty && password.isNotEmpty) {
    return '$base/$user:$password/jsonrpc/';
  }
  return '$base/jsonrpc/';
}

void _attachInterceptor(Dio dio) {
  dio.interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) {
      options.data = json.encode({
        'jsonrpc': '2.0',
        'method': options.queryParameters['method'],
        'params': options.queryParameters['params'] ?? [],
        'id': 1,
      });
      options.queryParameters = const {};
      return handler.next(options);
    },
  ));
}

void _setResponseTransformer(Dio dio) {
  (dio.transformer as BackgroundTransformer).jsonDecodeCallback = (data) {
    final parsed = json.decode(data);
    final result = parsed['result'];
    if (result is Map) return result;
    return {'result': result};
  };
}

@RestApi()
abstract class NZBGetAPI {
  factory NZBGetAPI({
    required String host,
    required String username,
    required String password,
    Map<String, dynamic> headers = const {},
  }) {
    Dio dio = Dio(BaseOptions(
      headers: headers,
      followRedirects: true,
      maxRedirects: 5,
      contentType: Headers.jsonContentType,
      responseType: ResponseType.json,
    ));
    _attachInterceptor(dio);
    _setResponseTransformer(dio);
    return _NZBGetAPI(dio, baseUrl: _baseUrl(host, username, password));
  }

  @POST('')
  Future<NZBGetVersion> getVersion({
    @Query('method') String method = 'version',
  });

  @POST('')
  Future<NZBGetStatus> getStatus({
    @Query('method') String method = 'status',
  });
}
