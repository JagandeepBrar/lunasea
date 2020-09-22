import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class SearchConstants {
    SearchConstants._();

    static const String MODULE_KEY = 'search';

    static const ModuleMap MODULE_MAP = ModuleMap(
        name: 'Search',
        description: 'Search Newznab Indexers',
        settingsDescription: 'Configure Search',
        icon: Icons.search,
        route: '/search',
        color: Color(LunaColours.ACCENT_COLOR),
    );

    //ignore: non_constant_identifier_names
    static final ShortcutItem MODULE_QUICK_ACTION = ShortcutItem(
        type: MODULE_KEY,
        localizedTitle: MODULE_MAP.name,
    );

    static const List<String> ADULT_CATEGORIES = ['xxx', 'adult', 'porn'];
}
