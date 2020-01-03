import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lunasea/configuration/values.dart';
import 'package:lunasea/logic/clients/sabnzbd/entry.dart';

class SABnzbdAPI {
    SABnzbdAPI._();
    
    static Future<bool> testConnection(List<dynamic> values) async {
        try {
            String uri = '${values[1]}/api?mode=fullstatus&output=json&apikey=${values[2]}';
            http.Response response = await http.get(
                Uri.encodeFull(uri),
            );
            if(response.statusCode == 200) {
                Map body = json.decode(response.body);
                if(body['status'] != false) {
                    return true;
                }
            }
        } catch (e) {
            return false;
        }
        return false;
    }

    static Future<SABnzbdStatisticsEntry> getStatistics() async {
        List<dynamic> values = Values.sabnzbdValues;
        if(values[0] == false) {
            return null;
        }
        try {
            String uriStatus = '${values[1]}/api?mode=fullstatus&skip_dashboard=1&output=json&apikey=${values[2]}';
            String uriStatistics = '${values[1]}/api?mode=server_stats&output=json&apikey=${values[2]}';
            http.Response status = await http.get(
                Uri.encodeFull(uriStatus),
            );
            http.Response statistics = await http.get(
                Uri.encodeFull(uriStatistics),
            );
            if(status.statusCode == 200 && statistics.statusCode == 200) {
                Map statusBody = json.decode(status.body);
                Map statisticsBody = json.decode(statistics.body);
                if(statusBody['status'] != false && statisticsBody['status'] == null) {
                    List<String> _servers = [];
                    for(var server in statusBody['status']['servers']) {
                        if(server['servername'] != null) {
                            _servers.add(server['servername']);
                        }
                    }
                    return SABnzbdStatisticsEntry(
                        _servers,
                        statusBody['status']['uptime'] ?? 'Unknown',
                        statusBody['status']['version'] ?? 'Unknown',
                        statusBody['status']['speedlimit_abs'] == '' ? -1 : double.tryParse(statusBody['status']['speedlimit_abs']),
                        int.tryParse(statusBody['status']['speedlimit']) ?? 100,
                        double.tryParse(statusBody['status']['diskspace1']) ?? 0.0,
                        statisticsBody['day'] ?? 0,
                        statisticsBody['week'] ?? 0,
                        statisticsBody['month'] ?? 0,
                        statisticsBody['total'] ?? 0,
                    );
                }
            }
        } catch (e) {
            return null;
        }
        return null;
    }

    static Future<bool> pauseQueue() async {
        List<dynamic> values = Values.sabnzbdValues;
        if(values[0] == false) {
            return false;
        }
        try {
            String uri = '${values[1]}/api?mode=pause&output=json&apikey=${values[2]}';
            http.Response response = await http.get(
                Uri.encodeFull(uri),
            );
            if(response.statusCode == 200) {
                Map body = json.decode(response.body);
                if(body['status'] != null && body['status']) {
                    return true;
                }
            }
        } catch (e) {
            return false;
        }
        return false;
    }

    static Future<bool> resumeQueue() async {
        List<dynamic> values = Values.sabnzbdValues;
        if(values[0] == false) {
            return false;
        }
        try {
            String uri = '${values[1]}/api?mode=resume&output=json&apikey=${values[2]}';
            http.Response response = await http.get(
                Uri.encodeFull(uri),
            );
            if(response.statusCode == 200) {
                Map body = json.decode(response.body);
                if(body['status'] != null && body['status']) {
                    return true;
                }
            }
        } catch (e) {
            return false;
        }
        return false;
    }

    static Future<bool> pauseSingleJob(String nzoId) async {
        List<dynamic> values = Values.sabnzbdValues;
        if(values[0] == false) {
            return false;
        }
        try {
            String uri = '${values[1]}/api?mode=queue&name=pause&value=$nzoId&output=json&apikey=${values[2]}';
            http.Response response = await http.get(
                Uri.encodeFull(uri),
            );
            if(response.statusCode == 200) {
                Map body = json.decode(response.body);
                if(body['status'] != null && body['status']) {
                    return true;
                }
            }
        } catch (e) {
            return false;
        }
        return false;
    }

    static Future<bool> resumeSingleJob(String nzoId) async {
        List<dynamic> values = Values.sabnzbdValues;
        if(values[0] == false) {
            return false;
        }
        try {
            String uri = '${values[1]}/api?mode=queue&name=resume&value=$nzoId&output=json&apikey=${values[2]}';
            http.Response response = await http.get(
                Uri.encodeFull(uri),
            );
            if(response.statusCode == 200) {
                Map body = json.decode(response.body);
                if(body['status'] != null && body['status']) {
                    return true;
                }
            }
        } catch (e) {
            return false;
        }
        return false;
    }

    static Future<bool> deleteJob(String nzoId) async {
        List<dynamic> values = Values.sabnzbdValues;
        if(values[0] == false) {
            return false;
        }
        try {
            String uri = '${values[1]}/api?mode=queue&name=delete&value=$nzoId&del_files=1&output=json&apikey=${values[2]}';
            http.Response response = await http.get(
                Uri.encodeFull(uri),
            );
            if(response.statusCode == 200) {
                Map body = json.decode(response.body);
                if(body['status'] != null && body['status']) {
                    return true;
                }
            }
        } catch (e) {
            return false;
        }
        return false;
    }

    static Future<bool> renameJob(String nzoId, String name) async {
        List<dynamic> values = Values.sabnzbdValues;
        if(values[0] == false) {
            return false;
        }
        try {
            String uri = '${values[1]}/api?mode=queue&name=rename&value=$nzoId&value2=$name&output=json&apikey=${values[2]}';
            http.Response response = await http.get(
                Uri.encodeFull(uri),
            );
            if(response.statusCode == 200) {
                Map body = json.decode(response.body);
                if(body['status'] != null && body['status']) {
                    return true;
                }
            }
        } catch (e) {
            return false;
        }
        return false;
    }

    static Future<bool> setJobPassword(String nzoId, String name, String password) async {
        List<dynamic> values = Values.sabnzbdValues;
        if(values[0] == false) {
            return false;
        }
        try {
            String uri = '${values[1]}/api?mode=queue&name=rename&value=$nzoId&value2=$name&value3=$password&output=json&apikey=${values[2]}';
            http.Response response = await http.get(
                Uri.encodeFull(uri),
            );
            if(response.statusCode == 200) {
                Map body = json.decode(response.body);
                if(body['status'] != null && body['status']) {
                    return true;
                }
            }
        } catch (e) {
            return false;
        }
        return false;
    }

    static Future<bool> setJobPriority(String nzoId, int priority) async {
        List<dynamic> values = Values.sabnzbdValues;
        if(values[0] == false) {
            return false;
        }
        try {
            String uri = '${values[1]}/api?mode=queue&name=priority&value=$nzoId&value2=$priority&output=json&apikey=${values[2]}';
            http.Response response = await http.get(
                Uri.encodeFull(uri),
            );
            if(response.statusCode == 200) {
                Map body = json.decode(response.body);
                if(body['status'] || body['position'] != null) {
                    return true;
                }
            }
        } catch (e) {
            return false;
        }
        return false;
    }

    static Future<bool> deleteHistory(String nzoId) async {
        List<dynamic> values = Values.sabnzbdValues;
        if(values[0] == false) {
            return false;
        }
        try {
            String uri = '${values[1]}/api?mode=history&name=delete&del_files=1&value=$nzoId&output=json&apikey=${values[2]}';
            http.Response response = await http.get(
                Uri.encodeFull(uri),
            );
            if(response.statusCode == 200) {
                Map body = json.decode(response.body);
                if(body['status'] != null && body['status']) {
                    return true;
                }
            }
        } catch (e) {
            return false;
        }
        return false;
    }

    static Future<List<dynamic>> getStatusAndQueue() async {
        List<dynamic> values = Values.sabnzbdValues;
        if(values[0] == false) {
            return null;
        }
        try {
            String uri = '${values[1]}/api?mode=queue&output=json&apikey=${values[2]}';
            http.Response response = await http.get(
                Uri.encodeFull(uri),
            );
            if(response.statusCode == 200) {
                Map body = json.decode(response.body);
                if(body['status'] == null || body['status']) {
                    SABnzbdStatusEntry status = SABnzbdStatusEntry(
                        body['queue']['paused'] ?? false,
                        double.tryParse(body['queue']['kbpersec']) ?? 0.0,
                        double.tryParse(body['queue']['mbleft']) ?? 0.0,
                        body['queue']['timeleft'] ?? '00:00:00',
                        int.tryParse(body['queue']['speedlimit']) ?? 0,
                    );
                    List<SABnzbdQueueEntry> queue = [];
                    for(var entry in body['queue']['slots']) {
                        queue.add(SABnzbdQueueEntry(
                            entry['filename'] ?? '',
                            entry['nzo_id'] ?? '',
                            double.tryParse(entry['mb'])?.round() ?? 0,
                            double.tryParse(entry['mbleft'])?.round() ?? 0,
                            entry['status'] ?? 'Unknown Status',
                            entry['timeleft'] ?? 'Unknown Time Left',
                            entry['cat'] ?? 'Unknown Category',
                        ));
                    }
                    return [
                        status,
                        queue,
                    ];
                }
            }
        } catch (e) {
            return null;
        }
        return null;
    }

    static Future<List<SABnzbdHistoryEntry>> getHistory() async {
        List<dynamic> values = Values.sabnzbdValues;
        if(values[0] == false) {
            return null;
        }
        try {
            String uri = '${values[1]}/api?mode=history&limit=200&output=json&apikey=${values[2]}';
            http.Response response = await http.get(
                Uri.encodeFull(uri),
            );
            if(response.statusCode == 200) {
                Map body = json.decode(response.body);
                if(body['status'] == null || body['status']) {
                    List<SABnzbdHistoryEntry> entries = [];
                    for(var entry in body['history']['slots']) {
                        entries.add(SABnzbdHistoryEntry(
                            entry['nzo_id'] ?? '',
                            entry['name'] ?? '',
                            entry['bytes'] ?? 0,
                            entry['status'] ?? '',
                            entry['fail_message'] ?? '',
                            entry['completed'] ?? 0,
                            entry['action_line'] ?? '',
                            entry['category'] == '*' ? 'Default' : entry['category'],
                            entry['download_time'] ?? 0,
                            entry['stage_log'] ?? [],
                            entry['storage'] ?? '',
                        ));
                    }
                    return entries;
                }
            }
        } catch (e) {
            return null;
        }
        return null;
    }

    static Future<bool> moveQueue(String nzoId, int index) async {
        List<dynamic> values = Values.sabnzbdValues;
        if(values[0] == false) {
            return false;
        }
        try {
            String uri = '${values[1]}/api?mode=switch&value=$nzoId&value2=$index&output=json&apikey=${values[2]}';
            http.Response response = await http.get(
                Uri.encodeFull(uri),
            );
            if(response.statusCode == 200) {
                Map body = json.decode(response.body);
                if(body['status'] == null || body['status']) {
                    if(body.containsKey('result')) {
                        return true;
                    }
                }
            }
        } catch (e) {
            return false;
        }
        return false;
    }

    static Future<bool> sortQueue(String sort, String dir) async {
        List<dynamic> values = Values.sabnzbdValues;
        if(values[0] == false) {
            return false;
        }
        try {
            String uri = '${values[1]}/api?mode=queue&name=sort&sort=$sort&dir=$dir&output=json&apikey=${values[2]}';
            http.Response response = await http.get(
                Uri.encodeFull(uri),
            );
            if(response.statusCode == 200) {
                Map body = json.decode(response.body);
                if(body['status'] != null && body['status']) {
                    return true;
                }
            }
        } catch (e) {
            return false;
        }
        return false;
    }

    static Future<List<SABnzbdCategoryEntry>> getCategories() async {
        List<dynamic> values = Values.sabnzbdValues;
        if(values[0] == false) {
            return null;
        }
        try {
            String uri = '${values[1]}/api?mode=get_cats&output=json&apikey=${values[2]}';
            http.Response response = await http.get(
                Uri.encodeFull(uri),
            );
            if(response.statusCode == 200) {
                Map body = json.decode(response.body);
                if(body['status'] == null || body['status']) {
                    List<SABnzbdCategoryEntry> entries = [];
                    for(var entry in body['categories']) {
                        entries.add(SABnzbdCategoryEntry(
                            entry == '*' ? 'Default': entry,
                        ));
                    }
                    return entries;
                }
            }
        } catch (e) {
            return null;
        }
        return null;
    }

    static Future<bool> setCategory(String nzoId, String category) async {
        List<dynamic> values = Values.sabnzbdValues;
        if(values[0] == false) {
            return false;
        }
        try {
            String uri = '${values[1]}/api?mode=change_cat&value=$nzoId&value2=$category&output=json&apikey=${values[2]}';
            http.Response response = await http.get(
                Uri.encodeFull(uri),
            );
            if(response.statusCode == 200) {
                Map body = json.decode(response.body);
                if(body['status'] != null && body['status']) {
                    return true;
                }
            }
        } catch (e) {
            return false;
        }
        return false;
    }

    static Future<bool> setSpeedLimit(int limit) async {
        List<dynamic> values = Values.sabnzbdValues;
        if(values[0] == false) {
            return false;
        }
        try {
            String uri = '${values[1]}/api?mode=config&name=speedlimit&value=$limit&output=json&apikey=${values[2]}';
            http.Response response = await http.get(
                Uri.encodeFull(uri),
            );
            if(response.statusCode == 200) {
                Map body = json.decode(response.body);
                if(body['status'] != null && body['status']) {
                    return true;
                }
            }
        } catch (e) {
            return false;
        }
        return false;
    }

    static Future<bool> uploadURL(String url) async {
        List<dynamic> values = Values.sabnzbdValues;
        if(values[0] == false) {
            return false;
        }
        try {
            String urlEncoded = Uri.encodeComponent(url);
            String uri = '${values[1]}/api?mode=addurl&output=json&apikey=${values[2]}';
            http.Response response = await http.get(
                Uri.encodeFull(uri) + '&name=$urlEncoded',  
            );
            if(response.statusCode == 200) {
                Map body = json.decode(response.body);
                if(body['status'] != null && body['status']) {
                    return true;
                }
            }
        } catch(e) {}
        return false;
    }

    static Future<bool> uploadFile(String data, String name) async {
        List<dynamic> values = Values.sabnzbdValues;
        if(values[0] == false) {
            return false;
        }
        try {
            http.MultipartRequest request = http.MultipartRequest("POST", Uri.parse('${values[1]}/api?mode=addfile&output=json&apikey=${values[2]}'));
            request.files.add(http.MultipartFile.fromString('name', data, filename: name));
            http.StreamedResponse response = await request.send();
            if(response.statusCode == 200) {
                Map body = json.decode(await response.stream.bytesToString()) ?? {};
                if(body['status'] != null && body['status']) {
                    return true;
                }
            }
        } catch (e) {
            return false;
        }
        return false;
    }

    static Future<bool> setOnCompleteAction(String action) async {
        List<dynamic> values = Values.sabnzbdValues;
        if(values[0] == false) {
            return false;
        }
        try {
            String uri = '${values[1]}/api?mode=queue&name=change_complete_action&value=$action&output=json&apikey=${values[2]}';
            http.Response response = await http.get(
                Uri.encodeFull(uri),
            );
            if(response.statusCode == 200) {
                Map body = json.decode(response.body);
                if(body['status'] != null && body['status']) {
                    return true;
                }
            }
        } catch (e) {
            return false;
        }
        return false;
    }

    static Future<bool> clearHistory(String action) async {
        List<dynamic> values = Values.sabnzbdValues;
        if(values[0] == false) {
            return false;
        }
        try {
            String uri = '${values[1]}/api?mode=history&name=delete&value=$action&output=json&apikey=${values[2]}';
            http.Response response = await http.get(
                Uri.encodeFull(uri),
            );
            if(response.statusCode == 200) {
                Map body = json.decode(response.body);
                if(body['status'] != null && body['status']) {
                    return true;
                }
            }
        } catch (e) {
            return false;
        }
        return false;
    }

    static Future<bool> retryFailedJob(String nzoId) async {
        List<dynamic> values = Values.sabnzbdValues;
        if(values[0] == false) {
            return false;
        }
        try {
            String uri = '${values[1]}/api?mode=retry&value=$nzoId&output=json&apikey=${values[2]}';
            http.Response response = await http.get(
                Uri.encodeFull(uri),
            );
            if(response.statusCode == 200) {
                Map body = json.decode(response.body);
                if(body['status'] != null && body['status']) {
                    return true;
                }
            }
        } catch (e) {
            return false;
        }
        return false;
    }

    static Future<bool> retryFailedJobPassword(String nzoId, String password) async {
        List<dynamic> values = Values.sabnzbdValues;
        if(values[0] == false) {
            return false;
        }
        try {
            String uri = '${values[1]}/api?mode=retry&value=$nzoId&password=$password&output=json&apikey=${values[2]}';
            http.Response response = await http.get(
                Uri.encodeFull(uri),
            );
            if(response.statusCode == 200) {
                Map body = json.decode(response.body);
                if(body['status'] != null && body['status']) {
                    return true;
                }
            }
        } catch (e) {
            return false;
        }
        return false;
    }
}
