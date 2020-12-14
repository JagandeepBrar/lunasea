import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class WakeOnLANConstants {
    WakeOnLANConstants._();

    static const _HELP_MESSAGE = 'Wake-on-LAN (sometimes abbreviated WoL) is an industry standard protocol for waking computers up from a very low power mode remotely.';
    static const MODULE_KEY = 'wake_on_lan';

    static const LunaModuleMap MODULE_MAP = LunaModuleMap(
        name: 'Wake on LAN',
        description: 'Wake a Sleeping Machine',
        settingsDescription: 'Configure Wake on LAN',
        helpMessage: _HELP_MESSAGE,
        icon: Icons.settings_remote,
        route: null,
        color: Color(LunaColours.ACCENT_COLOR),
        website: '',
        github: '',
    );
}
