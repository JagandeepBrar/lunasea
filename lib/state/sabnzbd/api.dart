import 'package:lunasea/api/sabnzbd/api.dart';
import 'package:lunasea/database/box.dart';
import 'package:lunasea/state/sabnzbd/config.dart';
import 'package:lunasea/vendor.dart';

final apiProvider =
    Provider.autoDispose.family<SABnzbdAPI, String>((ref, uuid) {
  final db = ref.watch(configProvider(uuid));

  // A database update was triggered
  if (db.hasValue) {
    final config = db.value!;
    return SABnzbdAPI(
      host: config.host,
      apiKey: config.apiKey,
      headers: config.headers,
    );
  }

  // Initial load
  final config = LunaBox.profiles.read(uuid)!;
  return SABnzbdAPI(
    host: config.sabnzbdHost,
    apiKey: config.sabnzbdKey,
    headers: config.sabnzbdHeaders,
  );
});
