import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class SearchConstants {
    SearchConstants._();

    static const _HELP_MESSAGE = 'LunaSea currently supports all indexers that support the newznab protocol, including NZBHydra2.';
    static const String MODULE_KEY = 'search';

    static const LunaModuleMap MODULE_MAP = LunaModuleMap(
        name: 'Search',
        description: 'Search Newznab Indexers',
        settingsDescription: 'Configure Search',
        helpMessage: _HELP_MESSAGE,
        icon: Icons.search,
        route: '/search',
        color: Color(LunaColours.ACCENT_COLOR),
        website: '',
        github: '',
    );

    //ignore: non_constant_identifier_names
    static final ShortcutItem MODULE_QUICK_ACTION = ShortcutItem(
        type: MODULE_KEY,
        localizedTitle: MODULE_MAP.name,
    );

    static const List<String> ADULT_CATEGORIES = ['xxx', 'adult', 'porn'];
}
