import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules.dart';

class Constants {
    Constants._();
    //Services
    static const Map SERVICE_MAP = {
        'lidarr': LidarrConstants.SERVICE_MAP,
        'radarr': RadarrConstants.SERVICE_MAP,
        'sonarr': SonarrConstants.SERVICE_MAP,
        'nzbget': {
            'name': 'NZBGet',
            'desc': 'Manage Usenet Downloads',
            'icon': CustomIcons.nzbget,
            'route': '/nzbget',
        },
        'sabnzbd': {
            'name': 'SABnzbd',
            'desc': 'Manage Usenet Downloads',
            'icon': CustomIcons.sabnzbd,
            'route': '/sabnzbd',
        },
        'search': {
            'name': 'Search',
            'desc': 'Search Newznab Indexers',
            'icon': Icons.search,
            'route': '/search',
        },
        'settings': {
            'name': 'Settings',
            'desc': 'Update Configuration',
            'icon': Icons.settings,
            'route': '/settings',
        }
    };
    //Colors
    static const PRIMARY_COLOR = 0xFF32323E;
    static const SECONDARY_COLOR = 0xFF282834;
    static const ACCENT_COLOR = 0xFF4ECCA3;
    static const SPLASH_COLOR = 0xFF2EA07B;
    static const LIST_COLOR_ICONS = [
        Colors.blue,
        Color(ACCENT_COLOR),
        Colors.orange,
        Colors.red,
        Colors.deepPurpleAccent,
        Colors.blueGrey,
    ];
    //UI
    static const UI_ELEVATION = 2.0;
    static const UI_CARD_MARGIN = EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0);
    static const UI_NAVIGATION_SPEED = 250;
    //General
    static const EMPTY_MAP = {};
    static const EMPTY_LIST = [];
    static const EMPTY_STRING = '';
    //Error Values
    static const CONFIGURATION_INVALID = '<<INVALID_CONFIGURATION>>';
    static const ENCRYPTION_FAILURE = '<<INVALID_ENCRYPTION>>';
    static const NO_SERVICES_ENABLED = '<<NO_SERVICES_ENABLED>>';
    static const CHECK_LOGS_MESSAGE = 'Please check the logs for more details';
    //Extensions
    static const BYTE_SIZES = ['B', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB'];
    //URLs
    static const URL_DOCUMENTATION = 'https://docs.lunasea.app';
    static const URL_GITHUB = 'https://github.com/JagandeepBrar/LunaSea';
    static const URL_REDDIT = 'https://www.reddit.com/r/LunaSeaApp';
    static const URL_WEBSITE = 'https://www.lunasea.app';
    static const USER_AGENT = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_4) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.1 Safari/605.1.15';
    //Changelog
    static const EMPTY_CHANGELOG = [{
        "version": "Changelog Error",
        "new": ['Unable to fetch changes'],
        "fixes": ['Unable to fetch changes'],
        "tweaks": ['Unable to fetch changes'],
    }];
    //Automation
    static const Map historyReasonMessages = {
        'Upgrade': 'Upgraded File',
        'MissingFromDisk': 'Missing From Disk',
        'Manual': 'Manually Removed',
    };
}
