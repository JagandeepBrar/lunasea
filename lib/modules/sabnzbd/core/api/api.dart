import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sabnzbd.dart';

class SABnzbdAPI {
  final Dio _dio;

  SABnzbdAPI._internal(this._dio);
  factory SABnzbdAPI.from(LunaProfile profile) {
    Dio _client = Dio(
      BaseOptions(
        baseUrl: profile.sabnzbdHost.endsWith('/')
            ? '${profile.sabnzbdHost}api'
            : '${profile.sabnzbdHost}/api',
        queryParameters: {
          if (profile.sabnzbdKey != '') 'apikey': profile.sabnzbdKey,
          'output': 'json',
        },
        headers: profile.sabnzbdHeaders,
        followRedirects: true,
        maxRedirects: 5,
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
      ),
    );

    return SABnzbdAPI._internal(_client);
  }

  void logError(String text, Object error, StackTrace trace) =>
      LunaLogger().error('SABnzbd: $text', error, trace);

  Future<dynamic> testConnection() async => _dio.get('', queryParameters: {
        'mode': 'fullstatus',
      });

  Future<SABnzbdStatisticsData> getStatistics() async {
    try {
      Response status = await _dio.get('', queryParameters: {
        'mode': 'fullstatus',
        'skip_dashboard': 1,
      });
      Response statistics = await _dio.get('', queryParameters: {
        'mode': 'server_stats',
      });
      //Parse individual servers
      List<SABnzbdServerStatisticsData> _servers = [];
      for (var server in statistics.data['servers'].keys) {
        _servers.add(SABnzbdServerStatisticsData(
          name: server.toString(),
          dailyUsage: statistics.data['servers'][server]['day'],
          weeklyUsage: statistics.data['servers'][server]['week'],
          monthlyUsage: statistics.data['servers'][server]['month'],
          totalUsage: statistics.data['servers'][server]['total'],
        ));
      }
      //Assemble final stats object
      return SABnzbdStatisticsData(
        servers: _servers,
        uptime: status.data['status']['uptime'] ?? 'Unknown',
        version: status.data['status']['version'] ?? 'Unknown',
        speedlimit: status.data['status']['speedlimit_abs'] == ''
            ? -1
            : double.tryParse(status.data['status']['speedlimit_abs']),
        speedlimitPercentage:
            int.tryParse(status.data['status']['speedlimit']) ?? 100,
        tempFreespace:
            double.tryParse(status.data['status']['diskspace1']) ?? 0.0,
        finalFreespace:
            double.tryParse(status.data['status']['diskspace2']) ?? 0.0,
        dailyUsage: statistics.data['day'] ?? 0,
        weeklyUsage: statistics.data['week'] ?? 0,
        monthlyUsage: statistics.data['month'] ?? 0,
        totalUsage: statistics.data['total'] ?? 0,
      );
    } on DioException catch (error, stack) {
      logError('Failed to fetch statistics', error, stack);
      return Future.error(error);
    } catch (error, stack) {
      logError('Failed to fetch statistics', error, stack);
      return Future.error(error);
    }
  }

  Future<bool> pauseQueue() async {
    try {
      Response response = await _dio.get(
        '',
        queryParameters: {
          'mode': 'pause',
        },
      );
      return response.data['status'] != null && response.data['status'];
    } on DioException catch (error, stack) {
      logError('Failed to pause queue', error, stack);
      return Future.error(error);
    } catch (error, stack) {
      logError('Failed to pause queue', error, stack);
      return Future.error(error);
    }
  }

  Future<bool> pauseQueueFor(int? minutes) async {
    try {
      Response response = await _dio.get('', queryParameters: {
        'mode': 'config',
        'name': 'set_pause',
        'value': minutes,
      });
      return response.data['status'] != null && response.data['status'];
    } on DioException catch (error, stack) {
      logError('Failed to pause queue for $minutes minutes', error, stack);
      return Future.error(error);
    } catch (error, stack) {
      logError('Failed to pause queue for $minutes minutes', error, stack);
      return Future.error(error);
    }
  }

  Future<bool> resumeQueue() async {
    try {
      Response response = await _dio.get('', queryParameters: {
        'mode': 'resume',
      });
      return response.data['status'] != null && response.data['status'];
    } on DioException catch (error, stack) {
      logError('Failed to resume queue', error, stack);
      return Future.error(error);
    } catch (error, stack) {
      logError('Failed to resume queue', error, stack);
      return Future.error(error);
    }
  }

  Future<bool> pauseSingleJob(String nzoId) async {
    try {
      Response response = await _dio.get('', queryParameters: {
        'mode': 'queue',
        'name': 'pause',
        'value': nzoId,
      });
      return response.data['status'] != null && response.data['status'];
    } on DioException catch (error, stack) {
      logError('Failed to pause job ($nzoId)', error, stack);
      return Future.error(error);
    } catch (error, stack) {
      logError('Failed to pause job ($nzoId)', error, stack);
      return Future.error(error);
    }
  }

  Future<bool> resumeSingleJob(String nzoId) async {
    try {
      Response response = await _dio.get('', queryParameters: {
        'mode': 'queue',
        'name': 'resume',
        'value': nzoId,
      });
      return response.data['status'] != null && response.data['status'];
    } on DioException catch (error, stack) {
      logError('Failed to resume job ($nzoId)', error, stack);
      return Future.error(error);
    } catch (error, stack) {
      logError('Failed to resume job ($nzoId)', error, stack);
      return Future.error(error);
    }
  }

  Future<bool> deleteJob(String nzoId) async {
    try {
      Response response = await _dio.get(
        '',
        queryParameters: {
          'mode': 'queue',
          'name': 'delete',
          'value': nzoId,
          'del_files': 1,
        },
      );
      return response.data['status'] != null && response.data['status'];
    } on DioException catch (error, stack) {
      logError('Failed to delete job ($nzoId)', error, stack);
      return Future.error(error);
    } catch (error, stack) {
      logError('Failed to delete job ($nzoId)', error, stack);
      return Future.error(error);
    }
  }

  Future<bool> renameJob(String nzoId, String name) async {
    try {
      Response response = await _dio.get('', queryParameters: {
        'mode': 'queue',
        'name': 'rename',
        'value': nzoId,
        'value2': name,
      });
      return response.data['status'] != null && response.data['status'];
    } on DioException catch (error, stack) {
      logError('Failed to rename job ($nzoId, $name)', error, stack);
      return Future.error(error);
    } catch (error, stack) {
      logError('Failed to rename job ($nzoId, $name)', error, stack);
      return Future.error(error);
    }
  }

  Future<bool> setJobPassword(
      String nzoId, String name, String password) async {
    try {
      Response response = await _dio.get('', queryParameters: {
        'mode': 'queue',
        'name': 'rename',
        'value': nzoId,
        'value2': name,
        'value3': password,
      });
      return response.data['status'] != null && response.data['status'];
    } on DioException catch (error, stack) {
      logError('Failed to set job password ($nzoId, $password)', error, stack);
      return Future.error(error);
    } catch (error, stack) {
      logError('Failed to set job password ($nzoId, $password)', error, stack);
      return Future.error(error);
    }
  }

  Future<bool> setJobPriority(String nzoId, int priority) async {
    try {
      await _dio.get('', queryParameters: {
        'mode': 'queue',
        'name': 'priority',
        'value': nzoId,
        'value2': priority,
      });
      return true;
    } on DioException catch (error, stack) {
      logError('Failed to set job priority ($nzoId, $priority)', error, stack);
      return Future.error(error);
    } catch (error, stack) {
      logError('Failed to set job priority ($nzoId, $priority)', error, stack);
      return Future.error(error);
    }
  }

  Future<bool> deleteHistory(String nzoId) async {
    try {
      Response response = await _dio.get('', queryParameters: {
        'mode': 'history',
        'name': 'delete',
        'del_files': 1,
        'value': nzoId,
      });
      return response.data['status'] != null && response.data['status'];
    } on DioException catch (error, stack) {
      logError('Failed to delete history entry ($nzoId)', error, stack);
      return Future.error(error);
    } catch (error, stack) {
      logError('Failed to delete history entry ($nzoId)', error, stack);
      return Future.error(error);
    }
  }

  Future<List<dynamic>> getStatusAndQueue({int limit = 100}) async {
    try {
      Response response = await _dio.get(
        '',
        queryParameters: {
          'mode': 'queue',
          'limit': limit,
        },
      );
      SABnzbdStatusData status = SABnzbdStatusData(
        paused: response.data['queue']['paused'] ?? false,
        speed: double.tryParse(response.data['queue']['kbpersec']) ?? 0.0,
        sizeLeft: double.tryParse(response.data['queue']['mbleft']) ?? 0.0,
        timeLeft: response.data['queue']['timeleft'] ?? '00:00:00',
        speedlimit: int.tryParse(response.data['queue']['speedlimit']) ?? 0,
      );
      List<SABnzbdQueueData> queue = [];
      for (var entry in response.data['queue']['slots']) {
        queue.add(SABnzbdQueueData(
          name: entry['filename'] ?? '',
          nzoId: entry['nzo_id'] ?? '',
          sizeTotal: double.tryParse(entry['mb'])?.round() ?? 0,
          sizeLeft: double.tryParse(entry['mbleft'])?.round() ?? 0,
          status: entry['status'] ?? 'Unknown Status',
          timeLeft: entry['timeleft'] ?? 'Unknown Time Left',
          category: entry['cat'] ?? 'Unknown Category',
        ));
      }
      return [
        status,
        queue,
      ];
    } on DioException catch (error, stack) {
      logError('Failed to fetch status and queue', error, stack);
      return Future.error(error);
    } catch (error, stack) {
      logError('Failed to fetch status and queue', error, stack);
      return Future.error(error);
    }
  }

  Future<List<SABnzbdHistoryData>> getHistory() async {
    try {
      Response response = await _dio.get('', queryParameters: {
        'mode': 'history',
        'limit': 200,
      });
      List<SABnzbdHistoryData> entries = [];
      for (var entry in response.data['history']['slots']) {
        entries.add(SABnzbdHistoryData(
          nzoId: entry['nzo_id'] ?? '',
          name: entry['name'] ?? '',
          size: entry['bytes'] ?? 0,
          status: entry['status'] ?? '',
          failureMessage: entry['fail_message'] ?? '',
          timestamp: entry['completed'] ?? 0,
          actionLine: entry['action_line'] ?? '',
          category: entry['category'] == '*' ? 'Default' : entry['category'],
          downloadTime: entry['download_time'] ?? 0,
          stageLog: entry['stage_log'] ?? [],
          storageLocation: entry['storage'] ?? '',
        ));
      }
      return entries;
    } on DioException catch (error, stack) {
      logError('Failed to fetch history', error, stack);
      return Future.error(error);
    } catch (error, stack) {
      logError('Failed to fetch history', error, stack);
      return Future.error(error);
    }
  }

  Future<bool> moveQueue(String nzoId, int index) async {
    try {
      Response response = await _dio.get('', queryParameters: {
        'mode': 'switch',
        'value': nzoId,
        'value2': index,
      });
      return response.data['result'] != null &&
          response.data['result']['position'] != null;
    } on DioException catch (error, stack) {
      logError('Failed to move queue entry ($nzoId, $index)', error, stack);
      return Future.error(error);
    } catch (error, stack) {
      logError('Failed to move queue entry ($nzoId, $index)', error, stack);
      return Future.error(error);
    }
  }

  Future<bool> sortQueue(String sort, String dir) async {
    try {
      Response response = await _dio.get('', queryParameters: {
        'mode': 'queue',
        'name': 'sort',
        'sort': sort,
        'dir': dir,
      });
      return response.data['status'] != null && response.data['status'];
    } on DioException catch (error, stack) {
      logError('Failed to sort queue ($sort, $dir)', error, stack);
      return Future.error(error);
    } catch (error, stack) {
      logError('Failed to sort queue ($sort, $dir)', error, stack);
      return Future.error(error);
    }
  }

  Future<List<SABnzbdCategoryData>> getCategories() async {
    try {
      Response response = await _dio.get('', queryParameters: {
        'mode': 'get_cats',
      });
      List<SABnzbdCategoryData> entries = [];
      for (var entry in response.data['categories']) {
        entries.add(
            SABnzbdCategoryData(category: entry == '*' ? 'Default' : entry));
      }
      return entries;
    } on DioException catch (error, stack) {
      logError('Failed to fetch categories', error, stack);
      return Future.error(error);
    } catch (error, stack) {
      logError('Failed to fetch categories', error, stack);
      return Future.error(error);
    }
  }

  Future<bool> setCategory(String nzoId, String? category) async {
    try {
      Response response = await _dio.get('', queryParameters: {
        'mode': 'change_cat',
        'value': nzoId,
        'value2': category,
      });
      return response.data['status'] != null && response.data['status'];
    } on DioException catch (error, stack) {
      logError('Failed to set category ($nzoId, $category)', error, stack);
      return Future.error(error);
    } catch (error, stack) {
      logError('Failed to set category ($nzoId, $category)', error, stack);
      return Future.error(error);
    }
  }

  Future<bool> setSpeedLimit(int? limit) async {
    try {
      Response response = await _dio.get('', queryParameters: {
        'mode': 'config',
        'name': 'speedlimit',
        'value': limit,
      });
      return response.data['status'] != null && response.data['status'];
    } on DioException catch (error, stack) {
      logError('Failed to set speed limit ($limit)', error, stack);
      return Future.error(error);
    } catch (error, stack) {
      logError('Failed to set speed limit ($limit)', error, stack);
      return Future.error(error);
    }
  }

  Future<bool> uploadURL(String url) async {
    try {
      Response response = await _dio.get('', queryParameters: {
        'mode': 'addurl',
        'name': url,
      });
      return response.data['status'] != null && response.data['status'];
    } on DioException catch (error, stack) {
      logError('Failed to upload NZB by URL ($url)', error, stack);
      return Future.error(error);
    } catch (error, stack) {
      logError('Failed to upload NZB by URL ($url)', error, stack);
      return Future.error(error);
    }
  }

  Future<bool> uploadFile(List<int> data, String name) async {
    try {
      Response response = await _dio.post(
        '',
        queryParameters: {
          'mode': 'addfile',
        },
        data: FormData.fromMap({
          'name': MultipartFile.fromBytes(data, filename: name),
        }),
      );
      return response.data['status'] != null && response.data['status'];
    } on DioException catch (error, stack) {
      logError('Failed to upload nzb file ($name)', error, stack);
      return Future.error(error);
    } catch (error, stack) {
      logError('Failed to upload nzb file ($name)', error, stack);
      return Future.error(error);
    }
  }

  Future<bool> setOnCompleteAction(String action) async {
    try {
      Response response = await _dio.get(
        '',
        queryParameters: {
          'mode': 'queue',
          'name': 'change_complete_action',
          'value': action,
        },
      );
      return response.data['status'] != null && response.data['status'];
    } on DioException catch (error, stack) {
      logError('Failed to set on-complete action ($action)', error, stack);
      return Future.error(error);
    } catch (error, stack) {
      logError('Failed to set on-complete action ($action)', error, stack);
      return Future.error(error);
    }
  }

  Future<bool> clearHistory(String action, bool delete) async {
    try {
      Response response = await _dio.get('', queryParameters: {
        'mode': 'history',
        'name': 'delete',
        'value': action,
        if (delete) 'del_files': 1,
      });
      return response.data['status'] != null && response.data['status'];
    } on DioException catch (error, stack) {
      logError('Failed to clear history ($action, $delete)', error, stack);
      return Future.error(error);
    } catch (error, stack) {
      logError('Failed to clear history ($action, $delete)', error, stack);
      return Future.error(error);
    }
  }

  Future<bool> retryFailedJob(String nzoId) async {
    try {
      Response response = await _dio.get(
        '',
        queryParameters: {
          'mode': 'retry',
          'value': nzoId,
        },
      );
      return response.data['status'] != null && response.data['status'];
    } on DioException catch (error, stack) {
      logError('Failed to retry job ($nzoId)', error, stack);
      return Future.error(error);
    } catch (error, stack) {
      logError('Failed to retry job ($nzoId)', error, stack);
      return Future.error(error);
    }
  }

  Future<bool> retryFailedJobPassword(String nzoId, String password) async {
    try {
      Response response = await _dio.get('', queryParameters: {
        'mode': 'retry',
        'value': nzoId,
        'password': password,
      });
      return response.data['status'] != null && response.data['status'];
    } on DioException catch (error, stack) {
      logError('Failed to retry job with new password ($nzoId, $password)',
          error, stack);
      return Future.error(error);
    } catch (error, stack) {
      logError('Failed to retry job with new password ($nzoId, $password)',
          error, stack);
      return Future.error(error);
    }
  }
}
