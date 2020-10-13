import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:xml_parser/xml_parser.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/search.dart';

class NewznabAPI extends API {
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
                        if(indexer.key != '') 'apikey': indexer.key,
                    },
                    followRedirects: true,
                    maxRedirects: 5,
                ),
            ),
        );
    }

    String get displayName => _values['displayName'];
    String get host => _values['host'];
    String get key => _values['key'];

    void logWarning(String methodName, String text) => LunaLogger.warning(
        'package:lunasea/core/api/newznab/api.dart',
        methodName,
        'Newznab: $text',
    );

    void logError(String methodName, String text, Object error, StackTrace trace, {
        bool uploadToSentry = true,
    }) => LunaLogger.error(
        'package:lunasea/core/api/newznab/api.dart',
        methodName,
        'Newznab: $text',
        error,
        trace,
        uploadToSentry: uploadToSentry,
    );

    Future<bool> testConnection() async {
        try {
            Response response = await _dio.get('');
            if(response.statusCode == 200) return true;
        } catch (error, stack) {
            logError('testConnection', 'Connection test failed', error, stack, uploadToSentry: false);
        }
        return false;
    }

    Future<List<NewznabCategoryData>> getCategories() async {
        try {
            Response response = await _dio.get(
                '',
                queryParameters: {
                    't': 'caps',
                },
            );
            XmlDocument _xml = XmlDocument.fromString(response.data);
            List<NewznabCategoryData> _results = [];
            for(XmlElement _category in _xml?.root?.getChild('categories')?.getChildren('Category') ?? []) {
                NewznabCategoryData _data = NewznabCategoryData(
                    id: int.tryParse(_category.attributes.firstWhere((attr) => attr.name.toString() == 'id')?.value) ?? -1,
                    name: _category.attributes.firstWhere((attr) => attr.name.toString() == 'name')?.value ?? 'Unknown Category',
                );
                for(XmlElement _subcategory in _category?.getChildren('subcat') ?? []) {
                    _data.subcategories.add(NewznabSubcategoryData(
                        id: int.tryParse(_subcategory.attributes.firstWhere((attr) => attr.name.toString() == 'id')?.value) ?? -1,
                    name: _subcategory.attributes.firstWhere((attr) => attr.name.toString() == 'name')?.value ?? 'Unknown Subcategory',
                    ));
                }
                _results.add(_data);
            }
            return _results;
        } on DioError catch (error, stack) {
            logError('getCategories', 'Unable to fetch categories', error, stack, uploadToSentry: false);
            return Future.error(error);
        } catch (error, stack) {
            logError('getCategories', 'Unable to fetch categories', error, stack);
            return Future.error(error);
        }
    }

    Future<List<NewznabResultData>> getResults({ @required int categoryId, @required String query }) async {
        try {
            Response response = await _dio.get(
                '',
                queryParameters: {
                    't': 'search',
                    if(categoryId != -1) 'cat': categoryId,
                    if(query != '') 'q': query,
                    'limit': 100,
                    'extended': 1,
                },
            );
            XmlDocument _xml = XmlDocument.fromString(response.data);
            List<NewznabResultData> _results = [];
            for(XmlElement _item in _xml?.root?.getChild('channel')?.getChildren('item') ?? []) {
                _results.add(NewznabResultData(
                    title: _item.getChild('title')?.text ?? 'Unknown Result',
                    category: _item.getChild('category')?.text ?? 'Unknown Category',
                    size: int.tryParse(_item.getChild('enclosure')?.getAttribute('length')) ?? 0,
                    linkComments: _item?.getChild('comments')?.text ?? '',
                    linkDownload: _item?.getChild('link')?.text ?? '',
                    date: _item?.getChild('pubDate')?.text ?? 'Unknown Date',
                ));
            }
            return _results;
        } on DioError catch (error, stack) {
            logError('getResults', 'Unable to fetch results', error, stack, uploadToSentry: false);
            return Future.error(error);
        } catch (error, stack) {
            logError('getResults', 'Unable to fetch results', error, stack);
            return Future.error(error);
        }
    }
}