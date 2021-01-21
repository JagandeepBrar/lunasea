import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sabnzbd.dart';

class SABnzbdConstants {
    SABnzbdConstants._();

    static const String MODULE_KEY = 'sabnzbd';

    //ignore: non_constant_identifier_names
    static LunaModuleMetadata MODULE_METADATA = LunaModuleMetadata(
        name: 'SABnzbd',
        description: 'Manage Usenet Downloads',
        settingsDescription: 'Configure SABnzbd',
        helpMessage: 'SABnzbd is a multi-platform binary newsgroup downloader. The program works in the background and simplifies the downloading verifying and extracting of files from Usenet.',
        icon: CustomIcons.sabnzbd,
        route: SABnzbd.ROUTE_NAME,
        color: Color(0xFFFECC2B),
        website: 'https://sabnzbd.org',
        github: 'https://github.com/sabnzbd/sabnzbd',
        shortcutItem: ShortcutItem(type: MODULE_KEY, localizedTitle: 'SABnzbd'),
    );
}
