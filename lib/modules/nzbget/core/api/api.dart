import 'package:lunasea/core.dart';
import 'package:lunasea/modules/nzbget.dart';

class NZBGetAPI {
  final Dio _dio;

  NZBGetAPI._internal(this._dio);
  factory NZBGetAPI.from(LunaProfile profile) {
    String _baseURL = Uri.encodeFull(profile.nzbgetHost);
    _baseURL += profile.nzbgetUser.isNotEmpty && profile.nzbgetPass.isNotEmpty
        ? '/${profile.nzbgetUser}:${profile.nzbgetPass}/jsonrpc'
        : '/jsonrpc';

    Dio _client = Dio(
      BaseOptions(
        baseUrl: _baseURL,
        headers: profile.nzbgetHeaders,
        followRedirects: true,
        maxRedirects: 5,
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
      ),
    );

    return NZBGetAPI._internal(_client);
  }

  void logError(String text, Object error, StackTrace trace) =>
      LunaLogger().error('NZBGet: $text', error, trace);

  String getBody(String method, {List<dynamic>? params}) {
    return json.encode({
      "jsonrpc": "2.0",
      "method": method,
      "params": params ?? [],
      "id": 1,
    });
  }

  Future<dynamic> testConnection() async => _dio.post(
        '',
        data: getBody('version'),
      );

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
    } catch (error, stack) {
      logError('Failed to fetch status', error, stack);
      return Future.error(error, stack);
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
    } on DioException catch (error, stack) {
      logError('Failed to fetch statistics', error, stack);
      return Future.error(error, stack);
    } catch (error, stack) {
      logError('Failed to fetch statistics', error, stack);
      return Future.error(error, stack);
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
      for (var entry in response.data['result']) {
        _entries.add(NZBGetLogData(
          id: entry['ID'],
          kind: entry['Kind'],
          time: entry['Time'],
          text: entry['Text'],
        ));
      }
      return _entries;
    } on DioException catch (error, stack) {
      logError('Failed to fetch logs ($amount)', error, stack);
      return Future.error(error, stack);
    } catch (error, stack) {
      logError('Failed to fetch logs ($amount)', error, stack);
      return Future.error(error, stack);
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
      for (int i = 0; i < min(limit, response.data['result'].length); i++) {
        NZBGetQueueData _entry = NZBGetQueueData(
          id: response.data['result'][i]['NZBID'] ?? -1,
          name: response.data['result'][i]['NZBName'] ?? 'Unknown',
          status: response.data['result'][i]['Status'] ?? 'UNKNOWN',
          remaining: response.data['result'][i]['RemainingSizeMB'] ?? 0,
          downloaded: response.data['result'][i]['DownloadedSizeMB'] ?? 0,
          sizeTotal: response.data['result'][i]['FileSizeMB'] ?? 0,
          category: response.data['result'][i]['Category'] ?? '',
          speed: speed,
          queueSeconds: queueSeconds,
        );
        if (_entry.status == 'QUEUED' || _entry.status == 'DOWNLOADING')
          queueSeconds += _entry.remainingTime;
        _entries.add(_entry);
      }
      return _entries;
    } on DioException catch (error, stack) {
      logError('Failed to fetch queue', error, stack);
      return Future.error(error, stack);
    } catch (error, stack) {
      logError('Failed to fetch queue', error, stack);
      return Future.error(error, stack);
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
      for (var entry in response.data['result']) {
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
    } on DioException catch (error, stack) {
      logError('Failed to fetch history', error, stack);
      return Future.error(error, stack);
    } catch (error, stack) {
      logError('Failed to fetch history', error, stack);
      return Future.error(error, stack);
    }
  }

  Future<bool> pauseQueue() async {
    try {
      Response response = await _dio.post(
        '',
        data: getBody('pausedownload'),
      );
      if (response.data['result'] != null && response.data['result'] == true)
        return true;
      throw (Error());
    } on DioException catch (error, stack) {
      logError('Failed to pause queue', error, stack);
      return Future.error(error, stack);
    } catch (error, stack) {
      logError('Failed to pause queue', error, stack);
      return Future.error(error, stack);
    }
  }

  Future<bool> pauseQueueFor(int minutes) async {
    try {
      await pauseQueue();
      Response response = await _dio.post(
        '',
        data: getBody(
          'scheduleresume',
          params: [minutes * 60],
        ),
      );
      if (response.data['result'] != null && response.data['result'] == true)
        return true;
      throw (Error());
    } on DioException catch (error, stack) {
      logError('Failed to pause queue for $minutes minutes', error, stack);
      return Future.error(error, stack);
    } catch (error, stack) {
      logError('Failed to pause queue for $minutes minutes', error, stack);
      return Future.error(error, stack);
    }
  }

  Future<bool> resumeQueue() async {
    try {
      Response response = await _dio.post(
        '',
        data: getBody('resumedownload'),
      );
      if (response.data['result'] != null && response.data['result'] == true)
        return true;
      throw (Error());
    } on DioException catch (error, stack) {
      logError('Failed to resume queue', error, stack);
      return Future.error(error, stack);
    } catch (error, stack) {
      logError('Failed to resume queue', error, stack);
      return Future.error(error, stack);
    }
  }

  Future<bool> moveQueue(int id, int offset) async {
    try {
      Response response = await _dio.post(
        '',
        data: getBody('editqueue', params: [
          'GroupMoveOffset',
          '$offset',
          [id],
        ]),
      );
      if (response.data['result'] != null && response.data['result'] == true)
        return true;
      throw (Error());
    } on DioException catch (error, stack) {
      logError('Failed to move queue entry ($id, $offset)', error, stack);
      return Future.error(error, stack);
    } catch (error, stack) {
      logError('Failed to move queue entry ($id, $offset)', error, stack);
      return Future.error(error, stack);
    }
  }

  Future<bool> pauseSingleJob(int id) async {
    try {
      Response response = await _dio.post(
        '',
        data: getBody('editqueue', params: [
          'GroupPause',
          '',
          [id],
        ]),
      );
      if (response.data['result'] != null && response.data['result'] == true)
        return true;
      throw (Error());
    } on DioException catch (error, stack) {
      logError('Failed to pause job ($id)', error, stack);
      return Future.error(error, stack);
    } catch (error, stack) {
      logError('Failed to pause job ($id)', error, stack);
      return Future.error(error, stack);
    }
  }

  Future<bool> resumeSingleJob(int id) async {
    try {
      Response response = await _dio.post(
        '',
        data: getBody('editqueue', params: [
          'GroupResume',
          '',
          [id],
        ]),
      );
      if (response.data['result'] != null && response.data['result'] == true)
        return true;
      throw (Error());
    } on DioException catch (error, stack) {
      logError('Failed to resume job ($id)', error, stack);
      return Future.error(error, stack);
    } catch (error, stack) {
      logError('Failed to resume job ($id)', error, stack);
      return Future.error(error, stack);
    }
  }

  Future<bool> deleteJob(int id) async {
    try {
      Response response = await _dio.post(
        '',
        data: getBody('editqueue', params: [
          'GroupFinalDelete',
          '',
          [id],
        ]),
      );
      if (response.data['result'] != null && response.data['result'] == true)
        return true;
      throw (Error());
    } on DioException catch (error, stack) {
      logError('Failed to delete job ($id)', error, stack);
      return Future.error(error, stack);
    } catch (error, stack) {
      logError('Failed to delete job ($id)', error, stack);
      return Future.error(error, stack);
    }
  }

  Future<bool> renameJob(int id, String name) async {
    try {
      Response response = await _dio.post(
        '',
        data: getBody('editqueue', params: [
          'GroupSetName',
          name,
          [id],
        ]),
      );
      if (response.data['result'] != null && response.data['result'] == true)
        return true;
      throw (Error());
    } on DioException catch (error, stack) {
      logError('Failed to rename job ($id, $name)', error, stack);
      return Future.error(error, stack);
    } catch (error, stack) {
      logError('Failed to rename job ($id, $name)', error, stack);
      return Future.error(error, stack);
    }
  }

  Future<bool> setJobPriority(int id, NZBGetPriority? priority) async {
    try {
      Response response = await _dio.post(
        '',
        data: getBody('editqueue', params: [
          'GroupSetPriority',
          '${priority.value}',
          [id],
        ]),
      );
      if (response.data['result'] != null && response.data['result'] == true)
        return true;
      throw (Error());
    } on DioException catch (error, stack) {
      logError(
          'Failed to set job priority ($id, ${priority.name})', error, stack);
      return Future.error(error, stack);
    } catch (error, stack) {
      logError(
          'Failed to set job priority ($id, ${priority.name})', error, stack);
      return Future.error(error, stack);
    }
  }

  Future<bool> setJobCategory(int id, NZBGetCategoryData category) async {
    try {
      Response response = await _dio.post(
        '',
        data: getBody('editqueue', params: [
          'GroupApplyCategory',
          category.name,
          [id],
        ]),
      );
      if (response.data['result'] != null && response.data['result'] == true)
        return true;
      throw (Error());
    } on DioException catch (error, stack) {
      logError(
          'Failed to set job category ($id, ${category.name})', error, stack);
      return Future.error(error, stack);
    } catch (error, stack) {
      logError(
          'Failed to set job category ($id, ${category.name})', error, stack);
      return Future.error(error, stack);
    }
  }

  Future<bool> setJobPassword(int id, String password) async {
    try {
      Response response = await _dio.post(
        '',
        data: getBody('editqueue', params: [
          'GroupSetParameter',
          '*Unpack:Password=$password',
          [id],
        ]),
      );
      if (response.data['result'] != null && response.data['result'] == true)
        return true;
      throw (Error());
    } on DioException catch (error, stack) {
      logError('Failed to set job password ($id, $password)', error, stack);
      return Future.error(error, stack);
    } catch (error, stack) {
      logError('Failed to set job password ($id, $password)', error, stack);
      return Future.error(error, stack);
    }
  }

  Future<bool> deleteHistoryEntry(int id, {bool hide = false}) async {
    try {
      Response response = await _dio.post(
        '',
        data: getBody('editqueue', params: [
          hide ? 'HistoryDelete' : 'HistoryFinalDelete',
          '',
          [id],
        ]),
      );
      if (response.data['result'] != null && response.data['result'] == true)
        return true;
      throw (Error());
    } on DioException catch (error, stack) {
      logError('Failed to delete history entry ($id, $hide)', error, stack);
      return Future.error(error, stack);
    } catch (error, stack) {
      logError('Failed to delete history entry ($id, $hide)', error, stack);
      return Future.error(error, stack);
    }
  }

  Future<bool> retryHistoryEntry(int id) async {
    try {
      Response response = await _dio.post(
        '',
        data: getBody('editqueue', params: [
          'HistoryRedownload',
          '',
          [id],
        ]),
      );
      if (response.data['result'] != null && response.data['result'] == true)
        return true;
      throw (Error());
    } on DioException catch (error, stack) {
      logError('Failed to retry history entry ($id)', error, stack);
      return Future.error(error, stack);
    } catch (error, stack) {
      logError('Failed to retry history entry ($id)', error, stack);
      return Future.error(error, stack);
    }
  }

  Future<List<NZBGetCategoryData>> getCategories() async {
    try {
      Response response = await _dio.post(
        '',
        data: getBody('config'),
      );
      List<NZBGetCategoryData> _entries = [NZBGetCategoryData(name: '')];
      for (var entry in response.data['result']) {
        if (entry['Name'] != null &&
            entry['Name'].length >= 8 &&
            entry['Name'].substring(0, 8) == 'Category' &&
            entry['Name'].indexOf('.Name') != -1)
          _entries.add(NZBGetCategoryData(
            name: entry['Value'] ?? 'Unknown',
          ));
      }
      return _entries;
    } on DioException catch (error, stack) {
      logError('Failed to fetch categories', error, stack);
      return Future.error(error, stack);
    } catch (error, stack) {
      logError('Failed to fetch categories', error, stack);
      return Future.error(error, stack);
    }
  }

  Future<bool> sortQueue(NZBGetSort? sort) async {
    try {
      Response response = await _dio.post(
        '',
        data: getBody('editqueue', params: [
          'GroupSort',
          (sort.value),
          [],
        ]),
      );
      if (response.data['result'] != null && response.data['result'] == true)
        return true;
      throw (Error());
    } on DioException catch (error, stack) {
      logError('Failed to sort queue (${sort.name})', error, stack);
      return Future.error(error, stack);
    } catch (error, stack) {
      logError('Failed to sort queue (${sort.name})', error, stack);
      return Future.error(error, stack);
    }
  }

  Future<bool> uploadURL(String url) async {
    try {
      Response response = await _dio.post(
        '',
        data: getBody(
          'append',
          params: [
            '', //NZBFileName
            url, //Content
            '', //Category
            0, //Priority
            false, //AddToTop
            false, //AddPaused
            url, //DupeKey
            0, //DupeScore
            'All', //DupeMode
            [], //PPParameters
          ],
        ),
      );
      if (response.data['result'] != null && response.data['result'] > 0)
        return true;
      throw (Error());
    } on DioException catch (error, stack) {
      logError('Failed to add NZB by URL ($url)', error, stack);
      return Future.error(error, stack);
    } catch (error, stack) {
      logError('Failed to add NZB by URL ($url)', error, stack);
      return Future.error(error, stack);
    }
  }

  Future<bool> uploadFile(List<int> data, String name) async {
    try {
      String dataBase64 = base64.encode(data);
      Response response = await _dio.post(
        '',
        data: getBody(
          'append',
          params: [
            name, //NZBFileName
            dataBase64, //Content
            '', //Category
            0, //Priority
            false, //AddToTop
            false, //AddPaused
            name, //DupeKey
            0, //DupeScore
            'All', //DupeMode
            [], //PPParameters
          ],
        ),
      );
      if (response.data['result'] != null && response.data['result'] > 0)
        return true;
      throw (Error());
    } on DioException catch (error, stack) {
      logError('Failed to add NZB by file ($name)', error, stack);
      return Future.error(error, stack);
    } catch (error, stack) {
      logError('Failed to add NZB by file ($name)', error, stack);
      return Future.error(error, stack);
    }
  }

  Future<bool> setSpeedLimit(int? limit) async {
    try {
      Response response = await _dio.post(
        '',
        data: getBody(
          'rate',
          params: [limit],
        ),
      );
      if (response.data['result'] != null && response.data['result'] == true)
        return true;
      throw (Error());
    } on DioException catch (error, stack) {
      logError('Failed to set speed limit ($limit)', error, stack);
      return Future.error(error, stack);
    } catch (error, stack) {
      logError('Failed to set speed limit ($limit)', error, stack);
      return Future.error(error, stack);
    }
  }
}
