import 'package:radarr/radarr.dart';

void main() async {
    // The host must include the protocol
    // If required, the host should include the port and the base URL as well
    String host = 'http://192.168.1.111:7878';
    // Your key can be fetched from the Radarr web GUI
    String key = '<apikey>';
    Radarr api = Radarr(host: host, apiKey: key);
    // Run your commands
    // Example to get and print the title of the movie with identifier 1
    api.movie.get(movieId: 1).then((data) => print(data.title));
}
