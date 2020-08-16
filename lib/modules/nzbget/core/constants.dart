import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class NZBGetConstants {
    NZBGetConstants._();

    static const String MODULE_KEY = 'nzbget';

    static const Map MODULE_MAP = {
        'name': 'NZBGet',
        'desc': 'Manage Usenet Downloads',
        'icon': CustomIcons.nzbget,
        'route': '/nzbget',
        'color': Color(0xFF42D535),
    };
}
