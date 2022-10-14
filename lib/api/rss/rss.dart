import 'package:dio/dio.dart';
import 'package:lunasea/api/rss/models/rss_feed.dart';
import 'package:lunasea/api/rss/models/rss_feed_options.dart';

class RssAPI {
  static const _USER_AGENT =
      'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_4) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.1 Safari/605.1.15';
  final Dio _dio;

  RssAPI._internal(this._dio);

  factory RssAPI.create() {
    Dio _dio = Dio(
      BaseOptions(
        method: 'GET',
        headers: {
          'User-Agent': _USER_AGENT,
        },
        followRedirects: true,
        maxRedirects: 5,
      ),
    );
    return RssAPI._internal(_dio);
  }

  Future<RssFeed> getFeedResult(String url, {RssFeedOptions? options}) async {
    Response response =
        await _dio.get(url, options: Options(headers: options!.headers));
    if (response.statusCode! >= 400) {
      throw Exception(response.statusMessage.toString());
    }
    RssFeed result = RssFeed.parse(response.data);

    if (result.items!.isEmpty) {
      throw Exception("Empty feed");
    }

    return result;
  }
}
