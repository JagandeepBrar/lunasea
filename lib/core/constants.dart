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

    //ignore: non_constant_identifier_names
    static Map<String, LunaModuleMetadata> MODULE_METADATA = {
        LidarrConstants.MODULE_KEY: LidarrConstants.MODULE_METADATA,
        LunaModule.RADARR.key: RadarrConstants.MODULE_METADATA,
        SonarrConstants.MODULE_KEY: SonarrConstants.MODULE_METADATA,
        NZBGetConstants.MODULE_KEY: NZBGetConstants.MODULE_METADATA,
        SABnzbdConstants.MODULE_KEY: SABnzbdConstants.MODULE_METADATA,
        SearchConstants.MODULE_KEY: SearchConstants.MODULE_METADATA,
        LunaModule.SETTINGS.key: SettingsConstants.MODULE_METADATA,
        WakeOnLANConstants.MODULE_KEY: WakeOnLANConstants.MODULE_METADATA,
        TautulliConstants.MODULE_KEY: TautulliConstants.MODULE_METADATA,
    };

    static const TEXT_EMDASH = '—';
    static const TEXT_BULLET = '•';
    static const TEXT_ELLIPSIS = '…';

    static const UI_BORDER_RADIUS = 10.0;
    static const UI_FONT_SIZE_HEADER = 18.0;
    static const UI_FONT_SIZE_STICKYHEADER = 14.0;
    static const UI_FONT_SIZE_SUBHEADER = 12.0;
    static const UI_FONT_SIZE_TITLE = 16.0;
    static const UI_FONT_SIZE_SUBTITLE = 13.0;
    static const UI_FONT_SIZE_GRAPH_LEGEND = 10.0;

    static const NO_SERVICES_ENABLED = '<<NO_SERVICES_ENABLED>>';

    static const URL_CHANGELOG = 'https://feedback.lunasea.app/changelog';
    static const URL_DISCORD = 'https://www.lunasea.app/discord';
    static const URL_DOCUMENTATION = 'https://www.lunasea.app/docs';
    static const URL_FEEDBACK = 'https://www.lunasea.app/feedback';
    static const URL_GITHUB = 'https://www.lunasea.app/github';
    static const URL_REDDIT = 'https://www.lunasea.app/reddit';
    static const URL_SENTRY = 'https://sentry.io';
    static const URL_TESTFLIGHT = 'https://www.lunasea.app/testflight';
    static const URL_WEBSITE = 'https://www.lunasea.app';
    static const USER_AGENT = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_4) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.1 Safari/605.1.15';

    static const Map historyReasonMessages = {
        'Upgrade': 'Upgraded File',
        'MissingFromDisk': 'Missing From Disk',
        'Manual': 'Manually Removed',
    };
}
