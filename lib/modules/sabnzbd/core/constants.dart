import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class SABnzbdConstants {
    SABnzbdConstants._();

    static const _HELP_MESSAGE = 'SABnzbd is a multi-platform binary newsgroup downloader. The program works in the background and simplifies the downloading verifying and extracting of files from Usenet.';
    static const String MODULE_KEY = 'sabnzbd';

    static const LunaModuleMap MODULE_MAP = LunaModuleMap(
        name: 'SABnzbd',
        description: 'Manage Usenet Downloads',
        settingsDescription: 'Configure SABnzbd',
        helpMessage: _HELP_MESSAGE,
        icon: CustomIcons.sabnzbd,
        route: '/sabnzbd',
        color: Color(0xFFFECC2B),
        website: 'https://sabnzbd.org',
        github: 'https://github.com/sabnzbd/sabnzbd',
    );

    //ignore: non_constant_identifier_names
    static final ShortcutItem MODULE_QUICK_ACTION = ShortcutItem(
        type: MODULE_KEY,
        localizedTitle: MODULE_MAP.name,
    );
}
