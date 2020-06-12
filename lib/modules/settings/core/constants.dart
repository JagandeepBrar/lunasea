import 'package:flutter/material.dart';

class SettingsConstants {
    SettingsConstants._();

    static const String MODULE_KEY = 'settings';

    static const Map MODULE_MAP = {
        'name': 'Settings',
        'desc': 'Update Configuration',
        'icon': Icons.settings,
        'route': '/settings',
    };
}
