import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/nzbget.dart';

class NZBGetAPI extends API {
    final Map<String, dynamic> _values;
    final Dio _dio;

    NZBGetAPI._internal(this._values, this._dio);
    factory NZBGetAPI.from(ProfileHiveObject profile) {
        String _baseURL = Uri.encodeFull(profile.getNZBGet()['host']);
        Map<String, dynamic> _headers = Map<String, dynamic>.from(profile.getNZBGet()['headers']);
        if(profile.getNZBGet()['basic_auth']) {
            String _auth = base64.encode(utf8.encode('${profile.getNZBGet()['user']}:${profile.getNZBGet()['pass']}'));
            _headers['Authorization'] = 'Basic $_auth';
            _baseURL += '/jsonrpc';
        } else {
            _baseURL += profile.getNZBGet()['user'] != '' && profile.getNZBGet()['pass'] != ''
                ? '/${profile.getNZBGet()['user']}:${profile.getNZBGet()['pass']}/jsonrpc'
                : '/jsonrpc';
        }
        Dio _client = Dio(
            BaseOptions(
                baseUrl: _baseURL,
                headers: _headers,
                followRedirects: true,
                maxRedirects: 5,
            ),
        );
        if(!profile.getNZBGet()['strict_tls']) {
            (_client.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (client) {
                client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
            };
        }
        return NZBGetAPI._internal(
            profile.getNZBGet(),
            _client,
        );
    }

    void logWarning(String methodName, String text) => Logger.warning('NZBGetAPI', methodName, 'NZBGet: $text');
    void logError(String methodName, String text, Object error) => Logger.error('NZBGetAPI', methodName, 'NZBGet: $text', error, StackTrace.current);

    bool get enabled => _values['enabled'];
    String get host => _values['host'];
    String get user => _values['user'];
    String get pass => _values['pass'];

    String getBody(String method, {List<dynamic> params = Constants.EMPTY_LIST}) {
        return json.encode({
            "jsonrpc": "2.0",
            "method": method,
            "params": params,
            "id": 1,
        });
    }

    Future<bool> testConnection() async {
        try {
            Response response = await _dio.post(
                '',
                data: getBody('version'),
            );
            if(response.statusCode == 200) return true;
        } catch (error) {
            logError('testConnection', 'Connection test failed', error);
        }
        return false;
    }

    Future<NZBGetStatusData> getStatus() async {
        try {
            Response response = await _dio.post(
                '',
                data: getBody('status'),
            );
            return NZBGetStatusData(
                paused: response.data['result']['DownloadPaused'] ?? true,
                speed: response.data['result']['DownloadRate'] ?? 0,
                remainingHigh: response.data['result']['RemainingSizeHi'] ?? 0,
                remainingLow: response.data['result']['RemainingSizeLo'] ?? 0,
                speedlimit: response.data['result']['DownloadLimit'] ?? 0,
            );
        } catch (error) {
            logError('getStatus', 'Failed to fetch status', error);
            return Future.error(error);
        }
    }

    Future<NZBGetStatisticsData> getStatistics() async {
        try {
            Response response = await _dio.post(
                '',
                data: getBody('status'),
            );
            return NZBGetStatisticsData(
                freeSpaceHigh: response.data['result']['FreeDiskSpaceHi'] ?? 0,
                freeSpaceLow: response.data['result']['FreeDiskSpaceLo'] ?? 0,
                downloadedHigh: response.data['result']['DownloadedSizeHi'] ?? 0,
                downloadedLow: response.data['result']['DownloadedSizeLo'] ?? 0,
                uptimeSeconds: response.data['result']['UpTimeSec'] ?? 0,
                speedLimit: response.data['result']['DownloadRate'] ?? 0,
                serverPaused: response.data['result']['DownloadPaused'] ?? true,
                postPaused: response.data['result']['PostPaused'] ?? true,
                scanPaused: response.data['result']['ScanPaused'] ?? true,
            );
        } catch (error) {
            logError('getStatistics', 'Failed to fetch statistics', error);
            return Future.error(error);
        }
    }

    Future<List<NZBGetLogData>> getLogs({int amount = 25}) async {
        try {
            Response response = await _dio.post(
                '',
                data: getBody(
                    'log',
                    params: [
                        0,
                        amount,
                    ],
                ),
            );
            List<NZBGetLogData> _entries = [];
            for(var entry in response.data['result']) {
                _entries.add(NZBGetLogData(
                    id: entry['ID'],
                    kind: entry['Kind'],
                    time: entry['Time'],
                    text: entry['Text'],
                ));
            }
            return _entries;
        } catch (error) {
            logError('getLogs', 'Failed to fetch logs ($amount)', error);
            return Future.error(error);
        }
    }

    Future<List<NZBGetQueueData>> getQueue(int speed, int limit) async {
        try {
            Response response = await _dio.post(
                '',
                data: getBody('listgroups'),
            );
            List<NZBGetQueueData> _entries = [];
            int queueSeconds = 0;
            for(int i=0; i < min(limit, response.data['result'].length); i++) {
                NZBGetQueueData _entry = NZBGetQueueData(
                    id: response.data['result'][i]['NZBID'] ?? -1,
                    name: response.data['result'][i]['NZBName'] ?? 'Unknown',
                    status: response.data['result'][i]['Status'] ?? 'UNKNOWN',
                    remaining: response.data['result'][i]['RemainingSizeMB'] ?? 0,
                    downloaded: response.data['result'][i]['DownloadedSizeMB'] ?? 0,
                    sizeTotal: response.data['result'][i]['FileSizeMB'] ?? 0,
                    category: response.data['result'][i]['Category'] ?? '',
                    speed: speed ?? -1,
                    queueSeconds: queueSeconds ?? 0,
                );
                if(_entry.status == 'QUEUED' || _entry.status == 'DOWNLOADING') queueSeconds += _entry.remainingTime;
                _entries.add(_entry);
            }
            return _entries;
        } catch (error) {
            logError('getQueue', 'Failed to fetch queue', error);
            return Future.error(error);
        }
    }

    Future<List<NZBGetHistoryData>> getHistory({bool hidden = false}) async {
        try {
            Response response = await _dio.post(
                '',
                data: getBody(
                    'history',
                    params: [hidden],
                ),
            );
            List<NZBGetHistoryData> _entries = [];
            for(var entry in response.data['result']) {
                _entries.add(NZBGetHistoryData(
                    id: entry['NZBID'] ?? -1,
                    name: entry['Name'] ?? 'Unknown',
                    status: entry['Status'] ?? 'Unkown',
                    timestamp: entry['HistoryTime'] ?? -1,
                    downloadedLow: entry['FileSizeLo'] ?? 0,
                    downloadedHigh: entry['FileSizeHi'] ?? 0,
                    category: entry['Category'] ?? 'Unknown',
                    storageLocation: entry['DestDir'] ?? 'Unknown',
                    downloadTime: entry['DownloadTimeSec'] ?? 0,
                    health: entry['Health'] ?? 0,
                ));
            }
            return _entries;
        } catch (error) {
            logError('getHistory', 'Failed to fetch history', error);
            return Future.error(error);
        }
    }

    Future<bool> pauseQueue() async {
        try {
            Response response = await _dio.post(
                '',
                data: getBody('pausedownload'),
            );
            if(response.data['result'] != null && response.data['result'] == true) return true;
            throw(Error());
        } catch (error) {
            logError('pauseQueue', 'Failed to pause queue', error);
            return Future.error(error);
        }
    }

    Future<bool> pauseQueueFor(int minutes) async {
        try {
            await pauseQueue().catchError((error) { return Future.error(error); });
            Response response = await _dio.post(
                '',
                data: getBody(
                    'scheduleresume',
                    params: [minutes*60],
                ),
            );
            if(response.data['result'] != null && response.data['result'] == true) return true;
            throw(Error());
        } catch (error) {
            logError('pauseQueueFor', 'Failed to pause queue for $minutes minutes', error);
            return Future.error(error);
        }
    }

    Future<bool> resumeQueue() async {
        try {
            Response response = await _dio.post(
                '',
                data: getBody('resumedownload'),
            );
            if(response.data['result'] != null && response.data['result'] == true) return true;
            throw(Error());
        } catch (error) {
            //logError('resumeQueue', 'Failed to resume queue', error);
            return Future.error(error);
        }
    }

    Future<bool> moveQueue(int id, int offset) async {
        try {
            Response response = await _dio.post(
                '',
                data: getBody(
                    'editqueue',
                    params: [
                        'GroupMoveOffset',
                        '$offset',
                        [id],
                    ]
                ),
            );
            if(response.data['result'] != null && response.data['result'] == true) return true;
            throw(Error());
        } catch (error) {
            logError('moveQueue', 'Failed to move queue entry ($id, $offset)', error);
            return Future.error(error);
        }
    }

    Future<bool> pauseSingleJob(int id) async {
        try {
            Response response = await _dio.post(
                '',
                data: getBody(
                    'editqueue',
                    params: [
                        'GroupPause',
                        '',
                        [id],
                    ]
                ),
            );
            if(response.data['result'] != null && response.data['result'] == true) return true;
            throw(Error());
        } catch (error) {
            logError('pauseSingleJob', 'Failed to pause job ($id)', error);
            return Future.error(error);
        }
    }

    Future<bool> resumeSingleJob(int id) async {
        try {
            Response response = await _dio.post(
                '',
                data: getBody(
                    'editqueue',
                    params: [
                        'GroupResume',
                        '',
                        [id],
                    ]
                ),
            );
            if(response.data['result'] != null && response.data['result'] == true) return true;
            throw(Error());
        } catch (error) {
            logError('resumeSingleJob', 'Failed to resume job ($id)', error);
            return Future.error(error);
        }
    }

    Future<bool> deleteJob(int id) async {
        try {
            Response response = await _dio.post(
                '',
                data: getBody(
                    'editqueue',
                    params: [
                        'GroupFinalDelete',
                        '',
                        [id],
                    ]
                ),
            );
            if(response.data['result'] != null && response.data['result'] == true) return true;
            throw(Error());
        } catch (error) {
            logError('deleteJob', 'Failed to delete job ($id)', error);
            return Future.error(error);
        }
    }

    Future<bool> renameJob(int id, String name) async {
        try {
            Response response = await _dio.post(
                '',
                data: getBody(
                    'editqueue',
                    params: [
                        'GroupSetName',
                        name,
                        [id],
                    ]
                ),
            );
            if(response.data['result'] != null && response.data['result'] == true) return true;
            throw(Error());
        } catch (error) {
            logError('renameJob', 'Failed to rename job ($id, $name)', error);
            return Future.error(error);
        }
    }

    Future<bool> setJobPriority(int id, NZBGetPriority priority) async {
        try {
            Response response = await _dio.post(
                '',
                data: getBody(
                    'editqueue',
                    params: [
                        'GroupSetPriority',
                        '${priority.value}',
                        [id],
                    ]
                ),
            );
            if(response.data['result'] != null && response.data['result'] == true) return true;
            throw(Error());
        } catch (error) {
            logError('setJobPriority', 'Failed to set job priority ($id, ${priority.name})', error);
            return Future.error(error);
        }
    }

    Future<bool> setJobCategory(int id, NZBGetCategoryData category) async {
        try {
            Response response = await _dio.post(
                '',
                data: getBody(
                    'editqueue',
                    params: [
                        'GroupApplyCategory',
                        category.name,
                        [id],
                    ]
                ),
            );
            if(response.data['result'] != null && response.data['result'] == true) return true;
            throw(Error());
        } catch (error) {
            logError('setJobCategory', 'Failed to set job category ($id, ${category.name})', error);
            return Future.error(error);
        }
    }

    Future<bool> setJobPassword(int id, String password) async {
        try {
            Response response = await _dio.post(
                '',
                data: getBody(
                    'editqueue',
                    params: [
                        'GroupSetParameter',
                        '*Unpack:Password=$password',
                        [id],
                    ]
                ),
            );
            if(response.data['result'] != null && response.data['result'] == true) return true;
            throw(Error());
        } catch (error) {
            logError('setJobPassword', 'Failed to set job password ($id, $password)', error);
            return Future.error(error);
        }
    }

    Future<bool> deleteHistoryEntry(int id, { bool hide = false}) async {
        try {
            Response response = await _dio.post(
                '',
                data: getBody(
                    'editqueue',
                    params: [
                        hide ? 'HistoryDelete' : 'HistoryFinalDelete',
                        '',
                        [id],
                    ]
                ),
            );
            if(response.data['result'] != null && response.data['result'] == true) return true;
            throw(Error());
        } catch (error) {
            logError('deleteHistoryEntry', 'Failed to delete history entry ($id, $hide)', error);
            return Future.error(error);
        }
    }

    Future<bool> retryHistoryEntry(int id) async {
        try {
            Response response = await _dio.post(
                '',
                data: getBody(
                    'editqueue',
                    params: [
                        'HistoryRedownload',
                        '',
                        [id],
                    ]
                ),
            );
            if(response.data['result'] != null && response.data['result'] == true) return true;
            throw(Error());
        } catch (error) {
            logError('retryHistoryEntry', 'Failed to retry history entry ($id)', error);
            return Future.error(error);
        }
    }

    Future<List<NZBGetCategoryData>> getCategories() async {
        try {
            Response response = await _dio.post(
                '',
                data: getBody('config'),
            );
            List<NZBGetCategoryData> _entries = [NZBGetCategoryData(name: '')];
            for(var entry in response.data['result']) {
                if(
                    entry['Name'] != null &&
                    entry['Name'].length >= 8 &&
                    entry['Name'].substring(0, 8) == 'Category' &&
                    entry['Name'].indexOf('.Name') != -1
                ) _entries.add(NZBGetCategoryData(
                    name: entry['Value'] ?? 'Unknown',
                ));
            }
            return _entries;
        } catch (error) {
            logError('getCategories', 'Failed to fetch categories', error);
            return Future.error(error);
        }
    }

    Future<bool> sortQueue(NZBGetSort sort) async {
        try {
            Response response = await _dio.post(
                '',
                data: getBody(
                    'editqueue',
                    params: [
                        'GroupSort',
                        '${sort.value}',
                        [],
                    ]
                ),
            );
            if(response.data['result'] != null && response.data['result'] == true) return true;
            throw(Error());
        } catch (error) {
            logError('sortQueue', 'Failed to sort queue (${sort.name})', error);
            return Future.error(error);
        }
    }

    Future<bool> uploadURL(String url) async {
        try {
            Response response = await _dio.post(
                '',
                data: getBody(
                    'append',
                    params: [
                        '',         //NZBFileName
                        url,        //Content
                        '',         //Category
                        0,          //Priority
                        false,      //AddToTop
                        false,      //AddPaused
                        url,        //DupeKey
                        0,          //DupeScore
                        'All',      //DupeMode
                        [],         //PPParameters
                    ],
                ),
            );
            if(response.data['result'] != null && response.data['result'] > 0) return true;
            throw(Error());
        } catch (error) {
            logError('uploadURL', 'Failed to add NZB by URL ($url)', error);
            return Future.error(error);
        }
    }

    Future<bool> uploadFile(String data, String name) async {
        try {
            String dataBase64 = utf8.fuse(base64).encode(data);
            Response response = await _dio.post(
                '',
                data: getBody(
                    'append',
                    params: [
                        name,       //NZBFileName
                        dataBase64, //Content
                        '',         //Category
                        0,          //Priority
                        false,      //AddToTop
                        false,      //AddPaused
                        name,       //DupeKey
                        0,          //DupeScore
                        'All',      //DupeMode
                        [],         //PPParameters
                    ],
                ),
            );
            if(response.data['result'] != null && response.data['result'] > 0) return true;
            throw(Error());
        } catch (error) {
            logError('uploadFile', 'Failed to add NZB by file ($name)', error);
            return Future.error(error);
        }
    }

    Future<bool> setSpeedLimit(int limit) async {
        try {
            Response response = await _dio.post(
                '',
                data: getBody(
                    'rate',
                    params: [limit],
                ),
            );
            if(response.data['result'] != null && response.data['result'] == true) return true;
            throw(Error());
        } catch (error) {
            logError('setSpeedLimit', 'Failed to set speed limit ($limit)', error);
            return Future.error(error);
        }
    }
}
