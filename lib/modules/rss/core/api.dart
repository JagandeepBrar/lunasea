import '../../../core.dart';
import 'parse/rss_feed.dart';
import 'types/rss_result_item_type.dart';
import 'types/rss_result_type.dart';

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

  Future<RssResult> getFeedResult(FeedHiveObject feed) async {
    Response response = await _dio.get(feed.url!);
    if (response.statusCode! >= 400) {
      throw Exception(response.statusMessage.toString());
    }
    RssFeed result = RssFeed.parse(response.data);

    List<RssResultItem> items = result.items!
        .where((item) =>
            feed.include!.isEmpty ||
            item.title!.contains(RegExp("(" + feed.include! + ")")))
        .where((item) =>
            feed.exclude!.isEmpty ||
            !item.title!.contains(RegExp("(" + feed.exclude! + ")")))
        .map((e) => RssResultItem(e))
        .toList();

    return RssResult(items);
  }
}
