import 'package:lunasea/database/box.dart';
import 'package:lunasea/database/models/profile.dart';
import 'package:lunasea/vendor.dart';

class _DB {
  final bool enabled;
  final String host;
  final String apiKey;
  final Map<String, String> headers;

  _DB(
    this.enabled, {
    this.host = '',
    this.apiKey = '',
    this.headers = const {},
  });
}

final configProvider = StreamProvider.family<_DB, String>((ref, uuid) async* {
  final box = LunaBox.profiles.watch(uuid);
  await for (final event in box) {
    if (event.deleted) yield _DB(false);

    LunaProfile profile = event.value;
    yield _DB(
      profile.sabnzbdEnabled,
      host: profile.sabnzbdHost,
      apiKey: profile.sabnzbdKey,
      headers: profile.sabnzbdHeaders,
    );
  }
});
