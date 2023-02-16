import 'package:lunasea/core.dart';
import 'package:lunasea/database/models/indexer.dart';
import 'package:lunasea/modules/search.dart';

class NewznabAPI {
  static const _USER_AGENT =
      'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_4) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.1 Safari/605.1.15';
  final Dio _dio;
  final LunaIndexer indexer;

  NewznabAPI._internal(this._dio, this.indexer);

  factory NewznabAPI.fromIndexer(LunaIndexer indexer) {
    Dio _dio = Dio(
      BaseOptions(
        method: 'GET',
        baseUrl: '${indexer.host}/api',
        headers: {
          'User-Agent': _USER_AGENT,
          if (indexer.headers.isNotEmpty) ...indexer.headers,
        },
        queryParameters: {
          if (indexer.apiKey != '') 'apikey': indexer.apiKey,
        },
        responseType: ResponseType.plain,
        followRedirects: true,
        maxRedirects: 5,
      ),
    );
    return NewznabAPI._internal(_dio, indexer);
  }

  Future<List<NewznabCategoryData>> getCategories() async {
    Response response = await _dio.get(
      '',
      queryParameters: {
        't': 'caps',
      },
    );
    List<NewznabCategoryData> results = [];
    XmlDocument xml = XmlDocument.parse(response.data);
    xml
        .getElement('caps')!
        .getElement('categories')!
        .findElements('category')
        .forEach((cat) {
      String? catName = cat.getAttribute('name');
      int? catId = int.tryParse(cat.getAttribute('id') ?? 'noid');
      if ((catName?.isNotEmpty ?? false) && (catId != null)) {
        NewznabCategoryData data =
            NewznabCategoryData(id: catId, name: catName);
        cat.findElements('subcat').forEach((subcat) {
          String? subcatName = subcat.getAttribute('name');
          int? subcatId = int.tryParse(subcat.getAttribute('id') ?? 'noid');
          if ((subcatName?.isNotEmpty ?? false) && (subcatId != null))
            data.subcategories.add(NewznabSubcategoryData(
              id: subcatId,
              name: subcatName,
            ));
        });
        results.add(data);
      }
    });
    return results;
  }

  Future<List<NewznabResultData>> getResults(
      {int? categoryId, String? query, int offset = 0}) async {
    if (categoryId == null)
      assert(query != null, 'both categoryId and query cannot be null');
    Response response = await _dio.get(
      '',
      queryParameters: {
        't': 'search',
        if (categoryId != null) 'cat': categoryId,
        if (query != null && query.isNotEmpty) 'q': query,
        'limit': 50,
        'extended': 1,
        'offset': 50 * offset,
      },
    );
    List<NewznabResultData> results = [];
    XmlDocument xml = XmlDocument.parse(response.data);
    xml
        .getElement('rss')
        ?.getElement('channel')
        ?.findElements('item')
        .forEach((item) {
      int? size = int.tryParse(
          item.getElement('enclosure')?.getAttribute('length') ?? 'nosize');
      NewznabResultData data = NewznabResultData(
        title: item.getElement('title')?.innerText ?? 'Unknown Title',
        category: item.getElement('category')?.innerText ?? 'Unknown Category',
        size: size ?? 0,
        linkComments: item.getElement('comments')?.innerText ?? '',
        linkDownload: item.getElement('link')?.innerText ?? '',
        date: item.getElement('pubDate')?.innerText ?? 'Unknown Date',
      );
      results.add(data);
    });
    return results;
  }

  Future<String?> downloadRelease(NewznabResultData data) async {
    Response response = await Dio(
      BaseOptions(
        headers: {
          'user-agent': _USER_AGENT,
        },
        followRedirects: true,
        maxRedirects: 5,
        responseType: ResponseType.plain,
      ),
    ).get(data.linkDownload);
    return response.data;
  }
}
