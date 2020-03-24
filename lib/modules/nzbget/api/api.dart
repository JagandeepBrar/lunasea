import 'dart:convert';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:lunasea/core.dart';
import '../../nzbget.dart';

class NZBGetAPI extends API {
    final Map<String, dynamic> _values;
    final Dio _dio;

    NZBGetAPI._internal(this._values, this._dio);
    factory NZBGetAPI.from(ProfileHiveObject profile) => NZBGetAPI._internal(
        profile.getNZBGet(),
        Dio(
            BaseOptions(
                baseUrl: profile.getNZBGet()['user'] != '' && profile.getNZBGet()['pass'] != ''
                    ? '${Uri.encodeFull(profile.getNZBGet()['host'])}/${profile.getNZBGet()['user']}:${profile.getNZBGet()['pass']}/jsonrpc'
                    : '${Uri.encodeFull(profile.getNZBGet()['host'])}/jsonrpc',
            )
        )
    );

    void logWarning(String methodName, String text) => Logger.warning('NZBGetAPI', methodName, 'NZBGet: $text');
    void logError(String methodName, String text, Object error) => Logger.error('NZBGetAPI', methodName, 'NZBGet: $text', error, StackTrace.current);

    bool get enabled => _values['enabled'];
    String get host => _values['host'];
    String get user => _values['user'];
    String get pass => _values['pass'];

    String getURL() {
        return (user != null && user != '' && pass != null && pass != '')
            ? '${Uri.encodeFull(host)}/$user:$pass/jsonrpc'
            : '${Uri.encodeFull(host)}/jsonrpc';
    }

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
            if(response.statusCode == 200) {
                return true;
            }
        } catch (error) {
            logError('testConnection', 'Connection test failed', error);
        }
        return false;
    }

    Future<List<dynamic>> getStatusAndQueue({ int limit = 100 }) async {
        try {
            NZBGetStatusData status = await getStatus();
            if(status != null) {
                List<NZBGetQueueData> queue = await getQueue(status.speed, limit);
                if(queue != null) {
                    return [status, queue];
                }
            }
        } catch (e) {
            logError('getStatusAndQueue', 'Failed to fetch status and queue', e);
            return null;
        }
        logWarning('getStatusAndQueue', 'Failed to fetch status and queue');
        return null;
    }

    Future<NZBGetStatusData> getStatus() async {
        try {
            http.Response response = await http.post(
                getURL(),
                body: getBody('status'),
            );
            if(response.statusCode == 200) {
                Map body = json.decode(response.body);
                if(body['result'] != null) {
                    return NZBGetStatusData(
                        paused: body['result']['DownloadPaused'] ?? true,
                        speed: body['result']['DownloadRate'] ?? 0,
                        remainingHigh: body['result']['RemainingSizeHi'] ?? 0,
                        remainingLow: body['result']['RemainingSizeLo'] ?? 0,
                        speedlimit: body['result']['DownloadLimit'] ?? 0,
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

    Future<NZBGetStatisticsData> getStatistics() async {
        try {
            http.Response response = await http.post(
                getURL(),
                body: getBody('status'),
            );
            if(response.statusCode == 200) {
                Map body = json.decode(response.body);
                if(body['result'] != null) {
                    return NZBGetStatisticsData(
                        freeSpaceHigh: body['result']['FreeDiskSpaceHi'] ?? 0,
                        freeSpaceLow: body['result']['FreeDiskSpaceLo'] ?? 0,
                        downloadedHigh: body['result']['DownloadedSizeHi'] ?? 0,
                        downloadedLow: body['result']['DownloadedSizeLo'] ?? 0,
                        uptimeSeconds: body['result']['UpTimeSec'] ?? 0,
                        speedLimit: body['result']['DownloadRate'] ?? 0,
                        serverPaused: body['result']['DownloadPaused'] ?? true,
                        postPaused: body['result']['PostPaused'] ?? true,
                        scanPaused: body['result']['ScanPaused'] ?? true,
                    );
                }
            } else {
                logError('getStatistics', '<POST> HTTP Status Code (${response.statusCode})', null);
            }
        } catch (e) {
            logError('getStatistics', 'Failed to fetch statistics', e);
            return null;
        }
        logWarning('getStatistics', 'Failed to fetch statistics');
        return null;
    }

    Future<List<NZBGetLogData>> getLogs({int amount = 25}) async {
        try {
            http.Response response = await http.post(
                getURL(),
                body: getBody(
                    'log',
                    params: [
                        0,
                        amount,
                    ]
                ),
            );
            if(response.statusCode == 200) {
                Map body = json.decode(response.body);
                if(body['result'] != null) {
                    List<NZBGetLogData> _entries = [];
                    for(var entry in body['result']) {
                        _entries.add(NZBGetLogData(
                            id: entry['ID'],
                            kind: entry['Kind'],
                            time: entry['Time'],
                            text: entry['Text'],
                        ));
                    }
                    return _entries;
                }
            } else {
                logError('getLogs', '<POST> HTTP Status Code (${response.statusCode})', null);
            }
        } catch (e) {
            logError('getLogs', 'Failed to fetch logs ($amount)', e);
            return null;
        }
        logWarning('getLogs', 'Failed to fetch logs ($amount)');
        return null;
    }

    Future<List<NZBGetQueueData>> getQueue(int speed, int limit) async {
        try {
            http.Response response = await http.post(
                getURL(),
                body: getBody('listgroups'),
            );
            if(response.statusCode == 200) {
                Map body = json.decode(response.body);
                if(body['result'] != null) {
                    List<NZBGetQueueData> _entries = [];
                    int queueSeconds = 0;
                    for(int i=0; i < min(limit, body['result'].length); i++) {
                        NZBGetQueueData _entry = NZBGetQueueData(
                            id: body['result'][i]['NZBID'] ?? -1,
                            name: body['result'][i]['NZBName'] ?? 'Unknown',
                            status: body['result'][i]['Status'] ?? 'UNKNOWN',
                            remaining: body['result'][i]['RemainingSizeMB'] ?? 0,
                            downloaded: body['result'][i]['DownloadedSizeMB'] ?? 0,
                            sizeTotal: body['result'][i]['FileSizeMB'] ?? 0,
                            category: body['result'][i]['Category'] ?? '',
                            speed: speed ?? -1,
                            queueSeconds: queueSeconds ?? 0,
                        );
                        if(_entry.status == 'QUEUED' || _entry.status == 'DOWNLOADING') {
                            queueSeconds += _entry.remainingTime;
                        }
                        _entries.add(_entry);
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

    Future<List<NZBGetHistoryData>> getHistory({bool hidden = false}) async {
        try {
            http.Response response = await http.post(
                getURL(),
                body: getBody(
                    'history',
                    params: [hidden],
                ),
            );
            if(response.statusCode == 200) {
                Map body = json.decode(response.body);
                if(body['result'] != null) {
                    List<NZBGetHistoryData> _entries = [];
                    for(var entry in body['result']) {
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
                }           
            } else {
                logError('getHistory', '<POST> HTTP Status Code (${response.statusCode})', null);
            }
        } catch (e) {
            logError('getHistory', 'Failed to fetch history', e);
            return null;
        }
        logWarning('getHistory', 'Failed to fetch history');
        return null;
    }

    Future<bool> pauseQueue() async {
        try {
            http.Response response = await http.post(
                getURL(),
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

    Future<bool> pauseQueueFor(int minutes) async {
        try {
            if(await pauseQueue()) {
                http.Response response = await http.post(
                    getURL(),
                    body: getBody(
                        'scheduleresume',
                        params: [minutes*60],
                    ),
                );
                if(response.statusCode == 200) {
                    Map body = json.decode(response.body);
                    if(body['result'] != null && body['result'] == true) {
                        return true;
                    }
                } else {
                    logError('pauseQueueFor', '<POST> HTTP Status Code (${response.statusCode})', null);
                }
            }
        } catch (e) {
            logError('pauseQueueFor', 'Failed to pause queue for $minutes minutes', e);
            return false;
        }
        logWarning('pauseQueueFor', 'Failed to pause queue for $minutes minutes');
        return false;
    }

    Future<bool> resumeQueue() async {
        try {
            http.Response response = await http.post(
                getURL(),
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

    Future<bool> moveQueue(int id, int offset) async {
        try {
            http.Response response = await http.post(
                getURL(),
                body: getBody(
                    'editqueue',
                    params: [
                        'GroupMoveOffset',
                        '$offset',
                        [id],
                    ]
                ),
            );
            if(response.statusCode == 200) {
                Map body = json.decode(response.body);
                if(body['result'] != null && body['result'] == true) {
                    return true;
                }
            } else {
                logError('moveQueue', '<POST> HTTP Status Code (${response.statusCode})', null);
            }
        } catch (e) {
            logError('moveQueue', 'Failed to move queue entry ($id, $offset)', e);
            return false;
        }
        logWarning('moveQueue', 'Failed to move queue entry ($id, $offset)');
        return false;
    }

    Future<bool> pauseSingleJob(int id) async {
        try {
            http.Response response = await http.post(
                getURL(),
                body: getBody(
                    'editqueue',
                    params: [
                        'GroupPause',
                        '',
                        [id],
                    ]
                ),
            );
            if(response.statusCode == 200) {
                Map body = json.decode(response.body);
                if(body['result'] != null && body['result'] == true) {
                    return true;
                }
            } else {
                logError('pauseSingleJob', '<POST> HTTP Status Code (${response.statusCode})', null);
            }
        } catch (e) {
            logError('pauseSingleJob', 'Failed to pause job ($id)', e);
            return false;
        }
        logWarning('pauseSingleJob', 'Failed to pause job ($id)');
        return false;
    }

    Future<bool> resumeSingleJob(int id) async {
        try {
            http.Response response = await http.post(
                getURL(),
                body: getBody(
                    'editqueue',
                    params: [
                        'GroupResume',
                        '',
                        [id],
                    ]
                ),
            );
            if(response.statusCode == 200) {
                Map body = json.decode(response.body);
                if(body['result'] != null && body['result'] == true) {
                    return true;
                }
            } else {
                logError('resumeSingleJob', '<POST> HTTP Status Code (${response.statusCode})', null);
            }
        } catch (e) {
            logError('resumeSingleJob', 'Failed to resume job ($id)', e);
            return false;
        }
        logWarning('resumeSingleJob', 'Failed to resume job ($id)');
        return false;
    }

    Future<bool> deleteJob(int id) async {
        try {
            http.Response response = await http.post(
                getURL(),
                body: getBody(
                    'editqueue',
                    params: [
                        'GroupFinalDelete',
                        '',
                        [id],
                    ]
                ),
            );
            if(response.statusCode == 200) {
                Map body = json.decode(response.body);
                if(body['result'] != null && body['result'] == true) {
                    return true;
                }
            } else {
                logError('deleteJob', '<POST> HTTP Status Code (${response.statusCode})', null);
            }
        } catch (e) {
            logError('deleteJob', 'Failed to delete job ($id)', e);
            return false;
        }
        logWarning('deleteJob', 'Failed to delete job ($id)');
        return false;
    }

    Future<bool> renameJob(int id, String name) async {
        try {
            http.Response response = await http.post(
                getURL(),
                body: getBody(
                    'editqueue',
                    params: [
                        'GroupSetName',
                        name,
                        [id],
                    ]
                ),
            );
            if(response.statusCode == 200) {
                Map body = json.decode(response.body);
                if(body['result'] != null && body['result'] == true) {
                    return true;
                }
            } else {
                logError('renameJob', '<POST> HTTP Status Code (${response.statusCode})', null);
            }
        } catch (e) {
            logError('renameJob', 'Failed to rename job ($id, $name)', e);
            return false;
        }
        logWarning('renameJob', 'Failed to rename job ($id, $name)');
        return false;
    }

    Future<bool> setJobPriority(int id, NZBGetPriority priority) async {
        try {
            http.Response response = await http.post(
                getURL(),
                body: getBody(
                    'editqueue',
                    params: [
                        'GroupSetPriority',
                        '${priority.value}',
                        [id],
                    ]
                ),
            );
            if(response.statusCode == 200) {
                Map body = json.decode(response.body);
                if(body['result'] != null && body['result'] == true) {
                    return true;
                }
            } else {
                logError('setJobPriority', '<POST> HTTP Status Code (${response.statusCode})', null);
            }
        } catch (e) {
            logError('setJobPriority', 'Failed to set job priority ($id, ${priority.name})', e);
            return false;
        }
        logWarning('setJobPriority', 'Failed to set job priority ($id, ${priority.name})');
        return false;
    }

    Future<bool> setJobCategory(int id, NZBGetCategoryData category) async {
        try {
            http.Response response = await http.post(
                getURL(),
                body: getBody(
                    'editqueue',
                    params: [
                        'GroupApplyCategory',
                        category.name,
                        [id],
                    ]
                ),
            );
            if(response.statusCode == 200) {
                Map body = json.decode(response.body);
                if(body['result'] != null && body['result'] == true) {
                    return true;
                }
            } else {
                logError('setJobCategory', '<POST> HTTP Status Code (${response.statusCode})', null);
            }
        } catch (e) {
            logError('setJobCategory', 'Failed to set job category ($id, ${category.name})', e);
            return false;
        }
        logWarning('setJobCategory', 'Failed to set job category ($id, ${category.name})');
        return false;
    }

    Future<bool> setJobPassword(int id, String password) async {
        try {
            http.Response response = await http.post(
                getURL(),
                body: getBody(
                    'editqueue',
                    params: [
                        'GroupSetParameter',
                        '*Unpack:Password=$password',
                        [id],
                    ]
                ),
            );
            if(response.statusCode == 200) {
                Map body = json.decode(response.body);
                if(body['result'] != null && body['result'] == true) {
                    return true;
                }
            } else {
                logError('setJobPassword', '<POST> HTTP Status Code (${response.statusCode})', null);
            }
        } catch (e) {
            logError('setJobPassword', 'Failed to set job password ($id, $password)', e);
            return false;
        }
        logWarning('setJobPassword', 'Failed to set job password ($id, $password)');
        return false;
    }

    Future<bool> deleteHistoryEntry(int id, { bool hide = false}) async {
        try {
            http.Response response = await http.post(
                getURL(),
                body: getBody(
                    'editqueue',
                    params: [
                        hide ? 'HistoryDelete' : 'HistoryFinalDelete',
                        '',
                        [id],
                    ]
                ),
            );
            if(response.statusCode == 200) {
                Map body = json.decode(response.body);
                if(body['result'] != null && body['result']) {
                    return true;
                }
            } else {
                logError('deleteHistoryEntry', '<POST> HTTP Status Code (${response.statusCode})', null);
            }
        } catch (e) {
            logError('deleteHistoryEntry', 'Failed to delete history entry ($id, $hide)', e);
            return false;
        }
        logWarning('deleteHistoryEntry', 'Failed to delete history entry ($id, $hide)');
        return false;
    }

    Future<bool> retryHistoryEntry(int id) async {
        try {
            http.Response response = await http.post(
                getURL(),
                body: getBody(
                    'editqueue',
                    params: [
                        'HistoryRedownload',
                        '',
                        [id],
                    ]
                ),
            );
            if(response.statusCode == 200) {
                Map body = json.decode(response.body);
                if(body['result'] != null && body['result']) {
                    return true;
                }
            } else {
                logError('retryHistoryEntry', '<POST> HTTP Status Code (${response.statusCode})', null);
            }
        } catch (e) {
            logError('retryHistoryEntry', 'Failed to retry history entry ($id)', e);
            return false;
        }
        logWarning('retryHistoryEntry', 'Failed to retry history entry ($id)');
        return false;
    }

    Future<List<NZBGetCategoryData>> getCategories() async {
        try {
            http.Response response = await http.post(
                getURL(),
                body: getBody('config'),
            );
            if(response.statusCode == 200) {
                Map body = json.decode(response.body);
                if(body['result'] != null) {
                    List<NZBGetCategoryData> _entries = [NZBGetCategoryData(name: '')];
                    for(var entry in body['result']) {
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
                }
            } else {
                logError('getCategories', '<POST> HTTP Status Code (${response.statusCode})', null);
            }
        } catch (e) {
            logError('getCategories', 'Failed to fetch categories', e);
            return null;
        }
        logWarning('getCategories', 'Failed to fetch categories');
        return null;
    }

    Future<bool> sortQueue(NZBGetSort sort) async {
        try {
            http.Response response = await http.post(
                getURL(),
                body: getBody(
                    'editqueue',
                    params: [
                        'GroupSort',
                        '${sort.value}',
                        [],
                    ]
                ),
            );
            if(response.statusCode == 200) {
                Map body = json.decode(response.body);
                if(body['result'] != null && body['result'] == true) {
                    return true;
                }
            } else {
                logError('sortQueue', '<POST> HTTP Status Code (${response.statusCode})', null);
            }
        } catch (e) {
            logError('sortQueue', 'Failed to sort queue (${sort.name})', e);
            return false;
        }
        logWarning('sortQueue', 'Failed to sort queue (${sort.name})');
        return false;
    }

    Future<bool> uploadURL(String url) async {
        try {
            http.Response response = await http.post(
                getURL(),
                body: getBody(
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
            if(response.statusCode == 200) {
                Map body = json.decode(response.body);
                if(body['result'] != null && body['result'] > 0) {
                    return true;
                }
            } else {
                logError('uploadURL', '<POST> HTTP Status Code (${response.statusCode})', null);
            }
        } catch (e) {
            logError('uploadURL', 'Failed to add NZB by URL ($url)', e);
            return false;
        }
        logWarning('uploadURL', 'Failed to add NZB by URL ($url)');
        return false;
    }

    Future<bool> uploadFile(String data, String name) async {
        try {
            String dataBase64 = utf8.fuse(base64).encode(data);
            http.Response response = await http.post(
                getURL(),
                body: getBody(
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
            if(response.statusCode == 200) {
                Map body = json.decode(response.body);
                if(body['result'] != null && body['result'] > 0) {
                    return true;
                }
            } else {
                logError('uploadFile', '<POST> HTTP Status Code (${response.statusCode})', null);
            }
        } catch (e) {
            logError('uploadFile', 'Failed to add NZB by file ($name)', e);
            return false;
        }
        logWarning('uploadFile', 'Failed to add NZB by file ($name)');
        return false;
    }

    Future<bool> setSpeedLimit(int limit) async {
        try {
            http.Response response = await http.post(
                getURL(),
                body: getBody(
                    'rate',
                    params: [limit],
                ),
            );
            if(response.statusCode == 200) {
                Map body = json.decode(response.body);
                if(body['result'] != null && body['result'] == true) {
                    return true;
                }
            } else {
                logError('setSpeedLimit', '<POST> HTTP Status Code (${response.statusCode})', null);
            }
        } catch (e) {
            logError('setSpeedLimit', 'Failed to set speed limit ($limit)', e);
            return false;
        }
        logWarning('setSpeedLimit', 'Failed to set speed limit ($limit)');
        return false;
    }
}
