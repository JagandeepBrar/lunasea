import 'package:lunasea/core.dart';

class SABnzbdConstants {
    SABnzbdConstants._();

    static const String MODULE_KEY = 'sabnzbd';

    static const Map MODULE_MAP = {
        'name': 'SABnzbd',
        'desc': 'Manage Usenet Downloads',
        'icon': CustomIcons.sabnzbd,
        'route': '/sabnzbd',
    };
}
