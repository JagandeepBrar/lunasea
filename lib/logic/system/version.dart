import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:lunasea/system/constants.dart';
import 'package:package_info/package_info.dart';

class System {
    System._();
    
    static Future<Map> getLatestVersion() async {
        try {
            http.Response response = await http.get(
                Uri.encodeFull('https://www.lunasea.app/version.json'),
            );
            if(response.statusCode == 200) {
                return json.decode(response.body);
            }
        } catch (e) {}
        return Constants.LOWEST_VERSION;
    }

    static Future<List> getChangelog() async {
        try {
            http.Response response = await http.get(
                Uri.encodeFull('https://www.lunasea.app/changelog.json'),
            );
            if(response.statusCode == 200) {
                return json.decode(response.body);
            }
        } catch (e) {}
        return Constants.EMPTY_CHANGELOG;
    }

    static Future<bool> checkVersion() async {
        PackageInfo info = await PackageInfo.fromPlatform();
        String _version = info.version;
        String _buildNumber = info.buildNumber;
        try {
            Map latest = await getLatestVersion();
            List<String> splitVersion = _version.split('.');
            if(
                int.parse(splitVersion[0]) != latest['major'] ||
                int.parse(splitVersion[1]) != latest['minor'] ||
                int.parse(splitVersion[2]) != latest['revision'] ||
                int.parse(_buildNumber) != latest['code']
            ) {
                return true;
            }
        } catch (e) {}
        return false;
    }
}