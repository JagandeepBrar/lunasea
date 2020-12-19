import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/lidarr/core.dart' show LidarrConstants;
import 'package:lunasea/modules/radarr/core.dart' show RadarrConstants;
import 'package:lunasea/modules/sonarr/core.dart' show SonarrConstants;
import 'package:lunasea/modules/nzbget/core.dart' show NZBGetConstants;
import 'package:lunasea/modules/sabnzbd/core.dart' show SABnzbdConstants;
import 'package:lunasea/modules/search/core.dart' show SearchConstants;
import 'package:lunasea/modules/settings/core.dart' show SettingsConstants;
import 'package:lunasea/modules/wake_on_lan/core.dart' show WakeOnLANConstants;
import 'package:lunasea/modules/tautulli/core.dart' show TautulliConstants;

class Constants {
    Constants._();

    static const APPLICATION_NAME = 'LunaSea';
    static const Map<String, LunaModuleMetadata> MODULE_METADATA = {
        LidarrConstants.MODULE_KEY: LidarrConstants.MODULE_METADATA,
        RadarrConstants.MODULE_KEY: RadarrConstants.MODULE_METADATA,
        SonarrConstants.MODULE_KEY: SonarrConstants.MODULE_METADATA,
        NZBGetConstants.MODULE_KEY: NZBGetConstants.MODULE_METADATA,
        SABnzbdConstants.MODULE_KEY: SABnzbdConstants.MODULE_METADATA,
        SearchConstants.MODULE_KEY: SearchConstants.MODULE_METADATA,
        SettingsConstants.MODULE_KEY: SettingsConstants.MODULE_METADATA,
        WakeOnLANConstants.MODULE_KEY: WakeOnLANConstants.MODULE_METADATA,
        TautulliConstants.MODULE_KEY: TautulliConstants.MODULE_METADATA,
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

    static const NO_SERVICES_ENABLED = '<<NO_SERVICES_ENABLED>>';

    static const URL_DOCUMENTATION = 'https://docs.lunasea.app';
    static const URL_GITHUB = 'https://github.com/CometTools/LunaSea';
    static const URL_REDDIT = 'https://www.reddit.com/r/LunaSeaApp';
    static const URL_WEBSITE = 'https://www.lunasea.app';
    static const URL_FEEDBACK = 'https://feedback.lunasea.app';
    static const URL_CHANGELOG = 'https://github.com/CometTools/LunaSea/blob/master/CHANGELOG.md';
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
