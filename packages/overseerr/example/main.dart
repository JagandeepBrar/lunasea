import 'package:overseerr/overseerr.dart';

void main() async {
    // The host must include the protocol
    // If required, the host should include the port and the base URL as well
    String host = 'http://192.168.1.111:5055';
    // Your key can be fetched from the Overseerr web GUI
    String key = '<apikey>';
    // ignore: unused_local_variable
    Overseerr api = Overseerr(host: host, apiKey: key);
}
