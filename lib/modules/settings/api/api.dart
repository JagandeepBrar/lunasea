import 'package:dio/dio.dart';
import 'package:lunasea/core/constants.dart';

class SettingsAPI {
    SettingsAPI._();

    static Future<List> getChangelog() async {
        try {
            Response response = await Dio().get(Uri.encodeFull('https://www.lunasea.app/changelog.json'));
            return response.data;
        } catch (error) {}
        return Constants.EMPTY_CHANGELOG;
    }
}
