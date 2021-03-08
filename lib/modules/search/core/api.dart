import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
//import 'package:xml_parser/xml_parser.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/search.dart';
import 'package:xml/xml.dart';

class NewznabAPI {
    final Map<String, dynamic> _values;
    final Dio _dio;

    NewznabAPI._internal(this._values, this._dio);
    factory NewznabAPI.from(IndexerHiveObject indexer) {
        Map<String, dynamic> _headers = (indexer.headers ?? {}).cast<String, dynamic>();
        return NewznabAPI._internal(
            indexer.toMap(),
            Dio(
                BaseOptions(
                    method: 'GET',
                    baseUrl: '${indexer.host}/api',
                    headers: {
                        'User-Agent': Constants.USER_AGENT,
                        ..._headers,
                    },
                    queryParameters: {
                        if(indexer.apiKey != '') 'apikey': indexer.apiKey,
                    },
                    followRedirects: true,
                    maxRedirects: 5,
                ),
            ),
        );
    }

    String get displayName => _values['displayName'];
    String get host => _values['host'];
    String get apiKey => _values['apiKey'];

    void logError(String text, Object error, StackTrace trace) => LunaLogger().error('Newznab: $text', error, trace);

    Future<bool> testConnection() async {
        try {
            Response response = await _dio.get('');
            if(response.statusCode == 200) return true;
        } catch (error, stack) {
            logError('Connection test failed', error, stack);
        }
        return false;
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
        xml.getElement('caps').getElement('categories').findElements('category').forEach((cat) {
            String catName = cat.getAttribute('name');
            int catId  = int.tryParse(cat.getAttribute('id') ?? 'noid');
            if((catName?.isNotEmpty ?? false) && (catId != null)) {
                NewznabCategoryData data = NewznabCategoryData(id: catId, name: catName);
                cat.findElements('subcat').forEach((subcat) {
                    String subcatName = subcat.getAttribute('name');
                    int subcatId = int.tryParse(subcat.getAttribute('id') ?? 'noid');
                    if((subcatName?.isNotEmpty ?? false) && (subcatId != null)) data.subcategories.add(NewznabSubcategoryData(
                        id: subcatId,
                        name: subcatName,
                    ));
                });
                results.add(data);
            }
        });
        return results;
    }

    Future<List<NewznabResultData>> getResults({ @required int categoryId, @required String query, int offset = 0 }) async {
        Response response = await _dio.get(
            '',
            queryParameters: {
                't': 'search',
                if(categoryId != -1) 'cat': categoryId,
                if(query != '') 'q': query,
                'limit': 50,
                'extended': 1,
                'offset': 50*offset,
            },
        );
        List<NewznabResultData> results = [];
        XmlDocument xml = XmlDocument.parse(response.data);
        xml.getElement('rss')?.getElement('channel')?.findElements('item')?.forEach((item) {
            int size = int.tryParse(item.getElement('enclosure')?.getAttribute('length') ?? 'nosize');
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
}
