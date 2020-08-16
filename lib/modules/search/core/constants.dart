import 'package:flutter/material.dart';
import 'package:lunasea/core/constants.dart';

class SearchConstants {
    SearchConstants._();

    static const String MODULE_KEY = 'search';

    static const Map MODULE_MAP = {
        'name': 'Search',
        'desc': 'Search Newznab Indexers',
        'icon': Icons.search,
        'route': '/search',
        'color': Color(Constants.ACCENT_COLOR),
    };
}
