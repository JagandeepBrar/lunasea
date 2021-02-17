import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsConstants {
    SettingsConstants._();

    static const MODULE_KEY = 'settings';

    //ignore: non_constant_identifier_names
    static LunaModuleMetadata MODULE_METADATA = LunaModuleMetadata(
        name: 'Settings',
        description: 'Update Configuration',
        settingsDescription: '',
        helpMessage: '',
        icon: CustomIcons.settings,
        route: SettingsHomeRouter().route(),
        color: LunaColours.accent,
        website: '',
        github: '',
        shortcutItem: ShortcutItem(type: MODULE_KEY, localizedTitle: 'Settings'),
    );
}
