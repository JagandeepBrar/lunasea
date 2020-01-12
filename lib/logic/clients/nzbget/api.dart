import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lunasea/configuration/values.dart';
import 'package:lunasea/logic/clients/nzbget/entry.dart';
import 'package:lunasea/system/constants.dart';
import 'package:lunasea/system/logger.dart';

class NZBGetAPI {
    NZBGetAPI._();

    static void logWarning(String methodName, String text) {
        Logger.warning('package:lunasea/logic/clients/nzbget/api.dart', methodName, 'NZBGet: $text');
    }

    static void logError(String methodName, String text, Object error) {
        Logger.error('package:lunasea/logic/clients/nzbget/api.dart', methodName, 'NZBGet: $text', error, StackTrace.current);
    }

    static String getURL(String uri) {
        return Uri.encodeFull('$uri/jsonrpc');
    }

    static Map<String, String> getHeader(String username, String password) {
        return {
            'authorization': 'Basic ' + base64Encode(utf8.encode('$username:$password')),
        };
    }

    static String getBody(String method, {Map params = Constants.EMPTY_MAP}) {
        return json.encode({
            "jsonrpc": "2.0",
            "method": method,
            "params": params,
            "id": 1,
        });
    }

    static Future<bool> testConnection(List<dynamic> values) async {
        try {
            http.Response response = await http.post(
                getURL(values[1]),
                headers: getHeader(values[2], values[3]),
                body: getBody('version'),
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

    static Future<NZBGetStatusEntry> getStatus() async {
        List<dynamic> values = Values.nzbgetValues;
        if(values[0] == false) {
            return null;
        }
        try {
            http.Response response = await http.post(
                getURL(values[1]),
                headers: getHeader(values[2], values[3]),
                body: getBody('status'),
            );
            if(response.statusCode == 200) {
                Map body = json.decode(response.body);
                if(body['result'] != null) {
                    return NZBGetStatusEntry(
                        body['result']['DownloadPaused'] ?? true,
                        body['result']['DownloadRate'] ?? 0,
                        body['result']['RemainingSizeHi'] ?? 0,
                        body['result']['RemainingSizeLo'] ?? 0,
                        body['result']['DownloadLimit'] ?? 0,
                    );
                }
            } else {
                logError('getStatus', '<POST> HTTP Status Code (${response.statusCode})', null);
            }
        } catch (e) {
            logError('getStatus', 'Failed to fetch status', e);
            return null;
        }
        logWarning('getStatus', 'Failed to fetch status');
        return null;
    }

    static Future<List<NZBGetQueueEntry>> getQueue() async {
        List<dynamic> values = Values.nzbgetValues;
        if(values[0] == false) {
            return null;
        }
        try {
            http.Response response = await http.post(
                getURL(values[1]),
                headers: getHeader(values[2], values[3]),
                body: getBody('listgroups'),
            );
            if(response.statusCode == 200) {
                Map body = json.decode(response.body);
                if(body['result'] != null) {
                    List<NZBGetQueueEntry> _entries = [];
                    for(var entry in body['result']) {
                        _entries.add(NZBGetQueueEntry(
                            entry['NZBID'] ?? -1,
                            entry['NZBName'] ?? 'Unknown',
                            entry['Status'] ?? 'UNKNOWN',
                        ));
                    }
                    return _entries;
                }
            } else {
                logError('getQueue', '<POST> HTTP Status Code (${response.statusCode})', null);
            }
        } catch (e) {
            logError('getQueue', 'Failed to fetch queue', e);
            return null;
        }
        logWarning('getQueue', 'Failed to fetch queue');
        return null;
    }

    static Future<bool> pauseQueue() async {
        List<dynamic> values = Values.nzbgetValues;
        if(values[0] == false) {
            return false;
        }
        try {
            http.Response response = await http.post(
                getURL(values[1]),
                headers: getHeader(values[2], values[3]),
                body: getBody('pausedownload'),
            );
            if(response.statusCode == 200) {
                Map body = json.decode(response.body);
                if(body['result'] != null && body['result'] == true) {
                    return true;
                }
            } else {
                logError('pauseQueue', '<POST> HTTP Status Code (${response.statusCode})', null);
            }
        } catch (e) {
            logError('pauseQueue', 'Failed to pause queue', e);
            return false;
        }
        logWarning('pauseQueue', 'Failed to pause queue');
        return false;
    }

    static Future<bool> resumeQueue() async {
        List<dynamic> values = Values.nzbgetValues;
        if(values[0] == false) {
            return false;
        }
        try {
            http.Response response = await http.post(
                getURL(values[1]),
                headers: getHeader(values[2], values[3]),
                body: getBody('resumedownload'),
            );
            if(response.statusCode == 200) {
                Map body = json.decode(response.body);
                if(body['result'] != null && body['result'] == true) {
                    return true;
                }
            } else {
                logError('resumeQueue', '<POST> HTTP Status Code (${response.statusCode})', null);
            }
        } catch (e) {
            logError('resumeQueue', 'Failed to resume queue', e);
            return false;
        }
        logWarning('resumeQueue', 'Failed to resume queue');
        return false;
    }
}
