import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliConstants {
    TautulliConstants._();

    static const String MODULE_KEY = 'tautulli';

    //ignore: non_constant_identifier_names
    static LunaModuleMetadata MODULE_METADATA = LunaModuleMetadata(
        name: 'Tautulli',
        description: 'View Plex Activity',
        settingsDescription: 'Configure Tautulli',
        helpMessage: 'Tautulli is an application that you can run alongside your Plex Media Server to monitor activity and track various statistics. Most importantly, these statistics include what has been watched, who watched it, when and where they watched it, and how it was watched.',
        icon: CustomIcons.tautulli,
        route: TautulliHomeRouter.route(),
        color: Color(0xFFDBA23A),
        website: 'https://tautulli.com',
        github: 'https://github.com/Tautulli/Tautulli',
        shortcutItem: ShortcutItem(type: MODULE_KEY, localizedTitle: 'Tautulli'),
    );
}
