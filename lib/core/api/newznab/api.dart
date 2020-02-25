import 'package:lunasea/core.dart';
import 'package:lunasea/core/database/indexer.dart';

class NewznabAPI extends API {
    final Map<String, dynamic> _values;

    NewznabAPI._internal(this._values);
    factory NewznabAPI.from(IndexerHiveObject indexer) => NewznabAPI._internal(indexer.toMap());

    String get displayName => _values['displayName'];
    String get host => _values['host'];
    String get key => _values['key'];

    Future<bool> testConnection() async {
        return true;
    }

    void logWarning(String methodName, String text) => Logger.warning('package:lunasea/core/api/newznab/api.dart', methodName, 'Newznab: $text');
    void logError(String methodName, String text, Object error) => Logger.error('package:lunasea/core/api/newznab/api.dart', methodName, 'Newznab: $text', error, StackTrace.current);
}