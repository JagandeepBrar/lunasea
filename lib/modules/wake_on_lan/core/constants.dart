import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class WakeOnLANConstants {
    WakeOnLANConstants._();

    static const MODULE_KEY = 'wake_on_lan';

    static const ModuleMap MODULE_MAP = ModuleMap(
        name: 'Wake on LAN',
        description: 'Wake a Sleeping Machine',
        settingsDescription: 'Configure Wake on LAN',
        icon: Icons.settings_remote,
        route: null,
        color: Color(LunaColours.ACCENT_COLOR),
    );
}
