import 'package:lunasea/core.dart';
import 'package:lunasea/modules/home.dart';

class HomeConstants {
    HomeConstants._();

    static const MODULE_KEY = 'home';

    //ignore: non_constant_identifier_names
    static LunaModuleMetadata MODULE_METADATA = LunaModuleMetadata(
        name: 'Home',
        description: 'Home',
        settingsDescription: 'Configure the Home Screen',
        helpMessage: '',
        icon: CustomIcons.home,
        route: Home.ROUTE_NAME,
        color: LunaColours.accent,
        website: '',
        github: '',
        shortcutItem: ShortcutItem(type: MODULE_KEY, localizedTitle: 'Home'),
    );
}
