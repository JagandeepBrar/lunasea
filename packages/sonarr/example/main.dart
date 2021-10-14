import 'package:sonarr/sonarr.dart';

void main() async {
    // The host must include the protocol
    // If required, the host should include the port and the base URL as well
    String host = 'http://192.168.1.111:8989';
    // Your key can be fetched from the Sonarr web GUI
    String key = '<apikey>';
    Sonarr api = Sonarr(host: host, apiKey: key);
    // Run your commands
    api.series.getSeries(seriesId: 1).then((data) => print(data));
}
