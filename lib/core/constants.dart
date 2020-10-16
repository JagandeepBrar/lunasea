import 'package:flutter/material.dart';
import 'package:lunasea/core/module_map.dart';
import 'package:lunasea/modules.dart' show
    LidarrConstants,
    RadarrConstants,
    SonarrConstants,
    NZBGetConstants,
    SABnzbdConstants,
    SearchConstants,
    SettingsConstants,
    WakeOnLANConstants,
    TautulliConstants;

class Constants {
    Constants._();

    static const APPLICATION_NAME = 'LunaSea';
    static const SENTRY_DSN = 'https://511f76efcf714ecfb5ed6b26b5819bd6@o426090.ingest.sentry.io/5367513';

    static const Map<String, LunaModuleMap> MODULE_MAP = {
        LidarrConstants.MODULE_KEY: LidarrConstants.MODULE_MAP,
        RadarrConstants.MODULE_KEY: RadarrConstants.MODULE_MAP,
        SonarrConstants.MODULE_KEY: SonarrConstants.MODULE_MAP,
        NZBGetConstants.MODULE_KEY: NZBGetConstants.MODULE_MAP,
        SABnzbdConstants.MODULE_KEY: SABnzbdConstants.MODULE_MAP,
        SearchConstants.MODULE_KEY: SearchConstants.MODULE_MAP,
        SettingsConstants.MODULE_KEY: SettingsConstants.MODULE_MAP,
        WakeOnLANConstants.MODULE_KEY: WakeOnLANConstants.MODULE_MAP,
        TautulliConstants.MODULE_KEY: TautulliConstants.MODULE_MAP,
    };

    static const EMPTY_MAP = {};
    static const EMPTY_LIST = [];
    static const EMPTY_STRING = '';

    static const TEXT_EMDASH = '—';
    static const TEXT_BULLET = '•';
    static const TEXT_RARROW = '→';
    static const TEXT_LARROW = '←';
    static const TEXT_ELLIPSIS = '…';

    static const UI_ELEVATION = 0.0;
    static const UI_CARD_MARGIN = EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0);
    static const UI_NAVIGATION_SPEED = 250;
    static const UI_IMAGE_FADEIN_SPEED = 125;
    static const UI_BORDER_RADIUS = 10.0;
    static const UI_FONT_SIZE_HEADER = 18.0;
    static const UI_FONT_SIZE_STICKYHEADER = 14.0;
    static const UI_FONT_SIZE_SUBHEADER = 12.0;
    static const UI_FONT_SIZE_TITLE = 16.0;
    static const UI_FONT_SIZE_SUBTITLE = 13.0;
    static const UI_FONT_SIZE_GRAPH_LEGEND = 10.0;

    static const CONFIGURATION_INVALID = '<<INVALID_CONFIGURATION>>';
    static const ENCRYPTION_FAILURE = '<<INVALID_ENCRYPTION>>';
    static const NO_SERVICES_ENABLED = '<<NO_SERVICES_ENABLED>>';
    static const CHECK_LOGS_MESSAGE = 'Check the logs for more details';

    static const BIT_SIZES = ['b', 'Kb', 'Mb', 'Gb', 'Tb', 'Pb', 'Eb'];
    static const BYTE_SIZES = ['B', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB'];

    static const URL_DOCUMENTATION = 'https://docs.lunasea.app';
    static const URL_GITHUB = 'https://github.com/JagandeepBrar/LunaSea';
    static const URL_REDDIT = 'https://www.reddit.com/r/LunaSeaApp';
    static const URL_WEBSITE = 'https://www.lunasea.app';
    static const URL_FEEDBACK = 'https://feedback.lunasea.app';
    static const URL_LICENSES = 'https://docs.lunasea.app/other-resources/licenses';
    static const URL_CHANGELOG = 'https://docs.lunasea.app/development/changelog';
    static const URL_DISCORD = 'https://discord.com/invite/8MH2N3h';
    static const URL_SENTRY = 'https://sentry.io';
    static const URL_TESTFLIGHT = 'https://testflight.apple.com/join/WWXaybra';
    static const USER_AGENT = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_4) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.1 Safari/605.1.15';

    static const Map historyReasonMessages = {
        'Upgrade': 'Upgraded File',
        'MissingFromDisk': 'Missing From Disk',
        'Manual': 'Manually Removed',
    };
}
