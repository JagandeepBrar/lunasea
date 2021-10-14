import 'package:wake_on_lan/wake_on_lan.dart';

void main() async {
    // Create the IPv4  broadcast address
    String ip = '192.168.1.255';
    String mac = 'AA:BB:CC:DD:EE:FF';
    // Validate that the two strings are formatted correctly
    if(!IPv4Address.validate(ip)) {
        print('Invalid IPv4 Address String');
        return;
    }
    if(!MACAddress.validate(mac)) {
        print('Invalid MAC Address String');
        return;
    }
    // Create the IPv4 and MAC objects
    IPv4Address ipv4Address = IPv4Address.from(ip);
    MACAddress macAddress = MACAddress.from(mac);
    // Send the WOL packet
    // Port parameter is optional, set to 55 here as an example, but defaults to port 9
    WakeOnLAN.from(ipv4Address, macAddress, port: 55).wake();
}
