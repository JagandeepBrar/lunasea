import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class OmbiConstants {
    OmbiConstants._();

    static const _HELP_MESSAGE = 'Ombi is a self-hosted web application that automatically gives your shared Plex or Emby users the ability to request content by themselves! Ombi can be linked to multiple TV Show and Movie DVR tools to create a seamless end-to-end experience for your users.';
    static const String MODULE_KEY = 'ombi';

    static const LunaModuleMap MODULE_MAP = LunaModuleMap(
        name: 'Ombi',
        description: 'Manage Requests for Media',
        settingsDescription: 'Configure Ombi',
        helpMessage: _HELP_MESSAGE,
        icon: CustomIcons.tautulli,
        route: '/ombi',
        color: Color(0xFFD4782C),
        website: 'https://ombi.io',
        github: 'https://github.com/tidusjar/Ombi',
    );

    //ignore: non_constant_identifier_names
    static final ShortcutItem MODULE_QUICK_ACTION = ShortcutItem(
        type: MODULE_KEY,
        localizedTitle: MODULE_MAP.name,
    );
}
