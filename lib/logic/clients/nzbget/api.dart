import 'package:http/http.dart' as http;
import 'package:lunasea/configuration/values.dart';
import 'dart:convert';
import 'package:lunasea/system/logger.dart';

class NZBGetAPI {
    NZBGetAPI._();

    static void logWarning(String methodName, String text) {
        Logger.warning('package:lunasea/logic/clients/nzbget/api.dart', methodName, 'NZBGet: $text');
    }

    static void logError(String methodName, String text, Object error) {
        Logger.error('package:lunasea/logic/clients/nzbget/api.dart', methodName, 'NZBGet: $text', error, StackTrace.current);
    }

    static String getBase64Authentication(String username, String password) {
        return 'Basic ' + base64Encode(utf8.encode('$username:$password'));
    }

    static Future<bool> testConnection(List<dynamic> values) async {
        print(values);
        try {
            String uri = '${values[1]}/jsonrpc';
            http.Response response = await http.get(
                Uri.encodeFull(uri),
                headers: {
                    'authorization': getBase64Authentication(values[2], values[3]),
                },
            );
            if(response.statusCode == 200) {
                return true;
            }
        } catch (e) {
            logError('testConnection', 'Connection test failed', e);
            return false;
        }
        logWarning('testConnection', 'Connection test failed');
        return false;
    }
}
