import 'package:dio/dio.dart';
import 'package:xml/xml.dart' as xml;
import 'package:lunasea/core.dart';

class NewznabAPI extends API {
    final Map<String, dynamic> _values;
    final Dio _dio;

    NewznabAPI._internal(this._values, this._dio);
    factory NewznabAPI.from(IndexerHiveObject indexer) => NewznabAPI._internal(
        indexer.toMap(),
        Dio(BaseOptions(
            method: 'GET',
            baseUrl: '${indexer.host}/api',
        ),
    ));

    String get displayName => _values['displayName'];
    String get host => _values['host'];
    String get key => _values['key'];

    void logWarning(String methodName, String text) => Logger.warning('package:lunasea/core/api/newznab/api.dart', methodName, 'Newznab: $text');
    void logError(String methodName, String text, Object error) => Logger.error('package:lunasea/core/api/newznab/api.dart', methodName, 'Newznab: $text', error, StackTrace.current);

    Future<bool> testConnection() async => true;

    Future<List<NewznabCategoryData>> getCategories() async {
        try {
            Response response = await _dio.get(
                '',
                queryParameters: {
                    't': 'caps'
                },
            );
            xml.XmlDocument _xml = xml.parse(response.data);
            Iterable<xml.XmlElement> _categories = _xml.findAllElements('category');
            List<NewznabCategoryData> _results = [];
            for(xml.XmlNode _category in _categories) {
                if(_category.attributes.length != 0) {
                    NewznabCategoryData _data = NewznabCategoryData(  
                        id: int.tryParse(_category.attributes.firstWhere((attr) => attr.name.toString() == 'id')?.value) ?? 0,
                        name: _category.attributes.firstWhere((attr) => attr.name.toString() == 'name')?.value ?? '',
                    );
                    for(xml.XmlNode _subcategory in _category.children) {
                        if(_subcategory.attributes.length != 0) _data.subcategories.add(NewznabSubcategoryData(
                            id: int.tryParse(_subcategory.attributes.firstWhere((attr) => attr.name.toString() == 'id')?.value) ?? 0,
                            name: _subcategory.attributes.firstWhere((attr) => attr.name.toString() == 'name')?.value ?? '',
                        ));
                    }
                    _results.add(_data);
                }
            }
            return _results;
        } catch (error) {
            logError('getCategories', 'Unable to fetch categories', error);
            return null;
        }
    }
}