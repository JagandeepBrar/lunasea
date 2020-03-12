import 'package:flutter/material.dart';
import 'package:lunasea/widgets/ui/icon.dart';
import './api.dart';

class Constants {
    Constants._();
    //Services
    static const Map SERVICE_MAP = {
        'lidarr': {
            'name': 'Lidarr',
            'desc': 'Manage your music',
            'icon': CustomIcons.music,
            'route': '/lidarr',
        },
        'radarr': {
            'name': 'Radarr',
            'desc': 'Manage your movies',
            'icon': CustomIcons.movies,
            'route': '/radarr',
        },
        'sonarr': {
            'name': 'Sonarr',
            'desc': 'Manage your television series',
            'icon': CustomIcons.television,
            'route': '/sonarr',
        },
        'nzbget': {
            'name': 'NZBGet',
            'desc': 'Manage your downloads',
            'icon': CustomIcons.nzbget,
            'route': '/nzbget',
        },
        'sabnzbd': {
            'name': 'SABnzbd',
            'desc': 'Manage your downloads',
            'icon': CustomIcons.sabnzbd,
            'route': '/sabnzbd',
        },
        'search': {
            'name': 'Search',
            'desc': 'Search newznab indexers',
            'icon': Icons.search,
            'route': '/search',
        },
        'settings': {
            'name': 'Settings',
            'desc': 'Update your configuration',
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
    static const UI_ELEVATION = 4.0;
    static const UI_CARD_MARGIN = EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0);
    static const UI_LETTER_SPACING = -0.375;
    //General
    static const EMPTY_MAP = {};
    static const EMPTY_LIST = [];
    //Error Values
    static const CONFIGURATION_INVALID = '<<INVALID_CONFIGURATION>>';
    static const ENCRYPTION_FAILURE = '<<INVALID_ENCRYPTION>>';
    static const NO_SERVICES_ENABLED = '<<NO_SERVICES_ENABLED>>';
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
    // <<<< CLEAN UP BELOW >>>>
    //Automation
    static const Map historyReasonMessages = {
        'Upgrade': 'Upgraded File',
        'MissingFromDisk': 'Missing From Disk',
        'Manual': 'Manually Removed',
    };
    //Lidarr
    static const Map lidarrEventTypeMessages = {
        'trackFileRenamed': 'Track File Renamed',
        'trackFileDeleted': 'Track File Deleted',
        'trackFileImported': 'Track File Imported',
        'albumImportIncomplete': 'Album Import Incomplete',
        'downloadImported': 'Download Imported',
        'downloadFailed': 'Download Failed',
        'grabbed': 'Grabbed From',
    };
    //Radarr
    static final List<RadarrAvailabilityEntry> radarrMinAvailability = [
        RadarrAvailabilityEntry('preDB', 'PreDB'),
        RadarrAvailabilityEntry('announced', 'Announced'),
        RadarrAvailabilityEntry('inCinemas', 'In Cinemas'),
        RadarrAvailabilityEntry('released', 'Physical/Web'),
    ];
    static const Map radarrEventTypeMessages = {
        'movieFileRenamed': 'Movie File Renamed',
        'movieFileDeleted': 'Movie File Deleted',
        'downloadFolderImported': 'Imported Movie File',
        'downloadFailed': 'Download Failed',
        'grabbed': 'Grabbed From',
    };
    //Sonarr
    static const Map sonarrEventTypeMessages = {
        'episodeFileRenamed': 'Episode File Renamed',
        'episodeFileDeleted': 'Episode File Deleted',
        'downloadFolderImported': 'Imported Episode File',
        'downloadFailed': 'Download Failed',
        'grabbed': 'Grabbed From',
    };
    static const List sonarrSeriesTypes = [
        'anime',
        'daily',
        'standard',
    ];
}
