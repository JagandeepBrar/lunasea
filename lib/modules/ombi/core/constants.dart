import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/ombi.dart';

class OmbiConstants {
    OmbiConstants._();

    static const String MODULE_KEY = 'ombi';

    //ignore: non_constant_identifier_names
    static LunaModuleMetadata MODULE_METADATA = LunaModuleMetadata(
        name: 'Ombi',
        description: 'Manage Requests for Media',
        settingsDescription: 'Configure Ombi',
        helpMessage: 'Ombi is a self-hosted web application that automatically gives your shared Plex or Emby users the ability to request content by themselves! Ombi can be linked to multiple TV Show and Movie DVR tools to create a seamless end-to-end experience for your users.',
        icon: CustomIcons.tautulli,
        route: OmbiHomeRouter.route(),
        color: Color(0xFFD4782C),
        website: 'https://ombi.io',
        github: 'https://github.com/tidusjar/Ombi',
        shortcutItem: ShortcutItem(type: MODULE_KEY, localizedTitle: 'Ombi'),
    );
}
