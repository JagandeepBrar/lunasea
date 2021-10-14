import 'package:tautulli/tautulli.dart';

void main() async {
    // The host must include the protocol
    // If required, the host should include the port and the base URL as well
    String host = 'http://192.168.1.111:8181/tautulli';
    // Your key can be fetched from the Tautulli web GUI
    String key = '<apikey>';
    Tautulli api = Tautulli(host: host, apiKey: key);
    // Some example commands to call
    await printArnoldQuote(api);
    await backupSystem(api);
    await printActivity(api);
    await printHistory(api);
}

/// Print an Arnold Schwarzenegger quote
Future<void> printArnoldQuote(Tautulli api) async {
    api.miscellaneous.arnold().then((quote) => print(quote));
}

/// Backup both the configuration and database
Future<void> backupSystem(Tautulli api) async {
    api.system.backupConfig();
    api.system.backupDB();
}

/// Print basic information on all active sessions
Future<void> printActivity(Tautulli api) async {
    // Fetch the current activity
    api.activity.getActivity().then((activity) {
        // Loop over all sessions and print "user / content / ip address"
        activity?.sessions?.forEach((session) => print('${session.user} / ${session.fullTitle} / ${session.ipAddressPublic}'));
    });
}

/// Print the last five sessions from history
Future<void> printHistory(Tautulli api) async {
    api.history.getHistory(length: 5).then((history) {
        /// Loop over all history records and print "user / content / date"
        history.records?.forEach((record) => print('${record.user} / ${record.fullTitle} / ${record.date}'));
    });
}
