import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class WakeOnLANConstants {
    WakeOnLANConstants._();

    static const MODULE_KEY = 'wake_on_lan';

    //ignore: non_constant_identifier_names
    static LunaModuleMetadata MODULE_METADATA = LunaModuleMetadata(
        name: 'Wake on LAN',
        description: 'Wake a Sleeping Machine',
        settingsDescription: 'Configure Wake on LAN',
        helpMessage: 'Wake on LAN is an industry standard protocol for waking computers up from a very low power mode remotely by sending a specially constructed packet to the machine.',
        icon: Icons.settings_remote,
        route: null,
        color: Color(LunaColours.ACCENT_COLOR),
        website: '',
        github: '',
        shortcutItem: null,
    );
}
