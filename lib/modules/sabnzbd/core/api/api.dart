import 'dart:io';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sabnzbd.dart';

class SABnzbdAPI extends API {
    final Map<String, dynamic> _values;
    final Dio _dio;

    SABnzbdAPI._internal(this._values, this._dio);
    factory SABnzbdAPI.from(ProfileHiveObject profile) {
        Map<String, dynamic> _headers = Map<String, dynamic>.from(profile.getSABnzbd()['headers']);
        Dio _client = Dio(
            BaseOptions(
                baseUrl: '${profile.getSABnzbd()['host']}/api',
                queryParameters: {
                    if(profile.getSABnzbd()['key'] != '') 'apikey': profile.getSABnzbd()['key'],
                    'output': 'json',
                },
                headers: _headers,
                followRedirects: true,
                maxRedirects: 5,
            ),
        );
        if(!profile.getSABnzbd()['strict_tls']) {
            (_client.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (client) {
                client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
            };
        }
        return SABnzbdAPI._internal(
            profile.getSABnzbd(),
            _client,
        );
    }

    void logWarning(String methodName, String text) => Logger.warning('SABnzbdAPI', methodName, 'SABnzbd: $text');
    void logError(String methodName, String text, Object error) => Logger.error('SABnzbdAPI', methodName, 'SABnzbd: $text', error, StackTrace.current);

    bool get enabled => _values['enabled'];
    String get host => _values['host'];
    String get key => _values['key'];
    
    Future<bool> testConnection() async {
        try {
            Response response = await _dio.get(
                '',
                queryParameters: {
                    'mode': 'fullstatus',
                },
            );
            if(response.data['status'] != false) return true;
        } catch (error) {
            logError('testConnection', 'Connection test failed', error);
        }
        return false;
    }

    Future<SABnzbdStatisticsData> getStatistics() async {
        try {
            Response status = await _dio.get(
                '',
                queryParameters: {
                    'mode': 'fullstatus',
                    'skip_dashboard': 1,
                }
            );
            Response statistics = await _dio.get(
                '',
                queryParameters: {
                    'mode': 'server_stats',
                }
            );
            //Parse individual servers
            List<SABnzbdServerStatisticsData> _servers = [];
            for(var server in statistics.data['servers'].keys) {
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
                speedlimit: status.data['status']['speedlimit_abs'] == '' ? -1 : double.tryParse(status.data['status']['speedlimit_abs']),
                speedlimitPercentage: int.tryParse(status.data['status']['speedlimit']) ?? 100,
                freespace: double.tryParse(status.data['status']['diskspace1']) ?? 0.0,
                dailyUsage: statistics.data['day'] ?? 0,
                weeklyUsage: statistics.data['week'] ?? 0,
                monthlyUsage: statistics.data['month'] ?? 0,
                totalUsage: statistics.data['total'] ?? 0,
            );
        } catch (error) {
            logError('getStatistics', 'Failed to fetch statistics', error);
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
            return response.data['status'] != null && response.data['status']
                ? true
                : Future.error(null);
        } catch (error) {
            logError('pauseQueue', 'Failed to pause queue', error);
            return Future.error(error);
        }
    }

    Future<bool> pauseQueueFor(int minutes) async {
        try {
            Response response = await _dio.get(
                '',
                queryParameters: {
                    'mode': 'config',
                    'name': 'set_pause',
                    'value': minutes,
                }
            );
            return response.data['status'] != null && response.data['status']
                ? true
                : Future.error(null);
        } catch (error) {
            logError('pauseQueueFor', 'Failed to pause queue for $minutes minutes', error);
            return Future.error(error);
        }
    }

    Future<bool> resumeQueue() async {
        try {
            Response response = await _dio.get(
                '',
                queryParameters: {
                    'mode': 'resume',
                }
            );
            return response.data['status'] != null && response.data['status']
                ? true
                : Future.error(null);
        } catch (error) {
            logError('resumeQueue', 'Failed to resume queue', error);
            return Future.error(error);
        }
    }

    Future<bool> pauseSingleJob(String nzoId) async {
        try {
            Response response = await _dio.get(
                '',
                queryParameters: {
                    'mode': 'queue',
                    'name': 'pause',
                    'value': nzoId,
                }
            );
            return response.data['status'] != null && response.data['status']
                ? true
                : Future.error(null);
        } catch (error) {
            logError('pauseSingleJob', 'Failed to pause job ($nzoId)', error);
            return Future.error(error);
        }
    }

    Future<bool> resumeSingleJob(String nzoId) async {
        try {
            Response response = await _dio.get(
                '',
                queryParameters: {
                    'mode': 'queue',
                    'name': 'resume',
                    'value': nzoId,
                }
            );
            return response.data['status'] != null && response.data['status']
                ? true
                : Future.error(null);
        } catch (error) {
            logError('resumeSingleJob', 'Failed to resume job ($nzoId)', error);
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
            return response.data['status'] != null && response.data['status']
                ? true
                : Future.error(null);
        } catch (error) {
            logError('deleteJob', 'Failed to delete job ($nzoId)', error);
            return Future.error(error);
        }
    }

    Future<bool> renameJob(String nzoId, String name) async {
        try {
            Response response = await _dio.get(
                '',
                queryParameters: {
                    'mode': 'queue',
                    'name': 'rename',
                    'value': nzoId,
                    'value2': name,
                }
            );
            return response.data['status'] != null && response.data['status']
                ? true
                : Future.error(null);
        } catch (error) {
            logError('renameJob', 'Failed to rename job ($nzoId, $name)', error);
            return Future.error(error);
        }
    }

    Future<bool> setJobPassword(String nzoId, String name, String password) async {
        try {
            Response response = await _dio.get(
                '',
                queryParameters: {
                    'mode': 'queue',
                    'name': 'rename',
                    'value': nzoId,
                    'value2': name,
                    'value3': password,
                }
            );
            return response.data['status'] != null && response.data['status']
                ? true
                : Future.error(null);
        } catch (error) {
            logError('setJobPassword', 'Failed to set job password ($nzoId, $password)', error);
            return Future.error(error);
        }
    }

    Future<bool> setJobPriority(String nzoId, int priority) async {
        try {
            await _dio.get(
                '',
                queryParameters: {
                    'mode': 'queue',
                    'name': 'priority',
                    'value': nzoId,
                    'value2': priority,
                }
            );
            return true;
        } catch (error) {
            logError('setJobPriority', 'Failed to set job priority ($nzoId, $priority)', error);
            return Future.error(error);
        }
    }

    Future<bool> deleteHistory(String nzoId) async {
        try {
            Response response = await _dio.get(
                '',
                queryParameters: {
                    'mode': 'history',
                    'name': 'delete',
                    'del_files': 1,
                    'value': nzoId,
                }
            );
            return response.data['status'] != null && response.data['status']
                ? true
                : Future.error(null);
        } catch (error) {
            logError('deleteHistory', 'Failed to delete history entry ($nzoId)', error);
            return Future.error(error);
        }
    }

    Future<List<dynamic>> getStatusAndQueue({ int limit = 100 }) async {
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
            for(var entry in response.data['queue']['slots']) {
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
        } catch (error) {
            logError('getStatusAndQueue', 'Failed to fetch status and queue', error);
            return Future.error(error);
        }
    }

    Future<List<SABnzbdHistoryData>> getHistory() async {
        try {
            Response response = await _dio.get(
                '',
                queryParameters: {
                    'mode': 'history',
                    'limit': 200,
                }
            );
            List<SABnzbdHistoryData> entries = [];
            for(var entry in response.data['history']['slots']) {
                entries.add(SABnzbdHistoryData(
                    nzoId: entry['nzo_id'] ?? Constants.EMPTY_STRING,
                    name: entry['name'] ?? Constants.EMPTY_STRING,
                    size: entry['bytes'] ?? 0,
                    status: entry['status'] ?? Constants.EMPTY_STRING,
                    failureMessage: entry['fail_message'] ?? Constants.EMPTY_STRING,
                    timestamp: entry['completed'] ?? 0,
                    actionLine: entry['action_line'] ?? Constants.EMPTY_STRING,
                    category: entry['category'] == '*' ? 'Default' : entry['category'],
                    downloadTime: entry['download_time'] ?? 0,
                    stageLog: entry['stage_log'] ?? Constants.EMPTY_LIST,
                    storageLocation: entry['storage'] ?? Constants.EMPTY_STRING,
                ));
            }
            return entries;
        } catch (error) {
            logError('getHistory', 'Failed to fetch history', error);
            return Future.error(error);
        }
    }

    Future<bool> moveQueue(String nzoId, int index) async {
        try {
            Response response = await _dio.get(
                '',
                queryParameters: {
                    'mode': 'switch',
                    'value': nzoId,
                    'value2': index,
                }
            );
            return response.data['result'] != null && response.data['result']['position'] != null
                ? true
                : Future.error(null);
        } catch (error) {
            logError('moveQueue', 'Failed to move queue entry ($nzoId, $index)', error);
            return Future.error(error);
        }
    }

    Future<bool> sortQueue(String sort, String dir) async {
        try {
            Response response = await _dio.get(
                '',
                queryParameters: {
                    'mode': 'queue',
                    'name': 'sort',
                    'sort': sort,
                    'dir': dir,
                }
            );
            return response.data['status'] != null && response.data['status']
                ? true
                : Future.error(null);
        } catch (error) {
            logError('sortQueue', 'Failed to sort queue ($sort, $dir)', error);
            return Future.error(error);
        }
    }

    Future<List<SABnzbdCategoryData>> getCategories() async {
        try {
            Response response = await _dio.get(
                '',
                queryParameters: {
                    'mode': 'get_cats',
                }
            );
            List<SABnzbdCategoryData> entries = [];
            for(var entry in response.data['categories']) {
                entries.add(SABnzbdCategoryData(category: entry == '*' ? 'Default': entry));
            }
            return entries;
        } catch (error) {
            logError('getCategories', 'Failed to fetch categories', error);
            return Future.error(error);
        }
    }

    Future<bool> setCategory(String nzoId, String category) async {
        try {
            Response response = await _dio.get(
                '',
                queryParameters: {
                    'mode': 'change_cat',
                    'value': nzoId,
                    'value2': category,
                }
            );
            return response.data['status'] != null && response.data['status']
                ? true
                : Future.error(null);
        } catch (error) {
            logError('setCategory', 'Failed to set category ($nzoId, $category)', error);
            return Future.error(error);
        }
    }

    Future<bool> setSpeedLimit(int limit) async {
        try {
            Response response = await _dio.get(
                '',
                queryParameters: {
                    'mode': 'config',
                    'name': 'speedlimit',
                    'value': limit,
                }
            );
            return response.data['status'] != null && response.data['status']
                ? true
                : Future.error(null);
        } catch (error) {
            logError('setSpeedLimit', 'Failed to set speed limit ($limit)', error);
            return Future.error(error);
        }
    }

    Future<bool> uploadURL(String url) async {
        try {
            Response response = await _dio.get(
                '',
                queryParameters: {
                    'mode': 'addurl',
                    'name': url,
                }
            );
            return response.data['status'] != null && response.data['status']
                ? true
                : Future.error(null);
        } catch (error) {
            logError('uploadURL', 'Failed to upload NZB by URL ($url)', error);
            return Future.error(error);
        }
    }

    Future<bool> uploadFile(String data, String name) async {
        try {
            Response response = await _dio.post(
                '',
                queryParameters: {
                    'mode': 'addfile',
                },
                data: FormData.fromMap({
                    'name': MultipartFile.fromString(data, filename: name),
                }),
            );
            return response.data['status'] != null && response.data['status']
                ? true
                : Future.error(null);
        } catch (error) {
            logError('uploadFile', 'Failed to upload nzb file ($name)', error);
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
            return response.data['status'] != null && response.data['status']
                ? true
                : Future.error(null);
        } catch (error) {
            logError('setOnCompleteAction', 'Failed to set on-complete action ($action)', error);
            return Future.error(error);
        }
    }

    Future<bool> clearHistory(String action, bool delete) async {
        try {
            Response response = await _dio.get(
                '',
                queryParameters: {
                    'mode': 'history',
                    'name': 'delete',
                    'value': action,
                    if(delete) 'del_files': 1,
                }
            );
            return response.data['status'] != null && response.data['status']
                ? true
                : Future.error(null);
        } catch (error) {
            logError('clearHistory', 'Failed to clear history ($action, $delete)', error);
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
            return response.data['status'] != null && response.data['status']
                ? true
                : Future.error(null);
        } catch (error) {
            logError('retryFailedJob', 'Failed to retry job ($nzoId)', error);
            return Future.error(error);
        }
    }

    Future<bool> retryFailedJobPassword(String nzoId, String password) async {
        try {
            Response response = await _dio.get(
                '',
                queryParameters: {
                    'mode': 'retry',
                    'value': nzoId,
                    'password': password,
                }
            );
            return response.data['status'] != null && response.data['status']
                ? true
                : Future.error(null);
        } catch (error) {
            logError('retryFailedJobPassword', 'Failed to retry job with new password ($nzoId, $password)', error);
            return Future.error(error);
        }
    }
}
