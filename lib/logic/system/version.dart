import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:lunasea/system/constants.dart';

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
}