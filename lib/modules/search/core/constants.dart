import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/main.dart';
import 'package:lunasea/modules/search.dart';
import 'package:quick_actions/quick_actions.dart';

class SearchConstants {
    SearchConstants._();

    static const MODULE_KEY = 'search';

    //ignore: non_constant_identifier_names
    static LunaModuleMetadata MODULE_METADATA = LunaModuleMetadata(
        name: 'Search',
        description: 'Search Newznab Indexers',
        settingsDescription: 'Configure Search',
        helpMessage: '${Constants.APPLICATION_NAME} currently supports all indexers that support the newznab protocol, including NZBHydra2.',
        icon: Icons.search,
        route: '/search',
        color: Color(LunaColours.ACCENT_COLOR),
        website: '',
        github: 'https://github.com/theotherp/nzbhydra2',
        pushBaseRoute: () => LunaBIOS.navigatorKey.currentState.pushNamedAndRemoveUntil(Search.ROUTE_NAME, (Route<dynamic> route) => false),
        shortcutItem: ShortcutItem(type: MODULE_KEY, localizedTitle: 'Usenet Indexer Search'),
    );

    static const List<String> ADULT_CATEGORIES = ['xxx', 'adult', 'porn'];
}
