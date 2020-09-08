import 'package:fluro_fork/fluro_fork.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliRouter {
    static Router router = Router();
    static TransitionType _transitionType = TransitionType.native;

    TautulliRouter._();

    /// All routes start with /:profile/... for switching to specific profile by route
    static void initialize() {
        _root();
        _activityDetails();
        _historyDetails();
        _userDetails();
        _logs();
        _logsLogins();
        _logsNewsletters();
        _logsNotifications();
        _logsPlexMediaScanner();
        _logsPlexMediaServer();
        _logsTautulli();
        _statistics();
        _syncedItems();
        _recentlyAdded();
        router.notFoundHandler = _noFoundHandler;
    }

    /// /tautulli
    static void _root() => router?.define(
        TautulliRoute.ROUTE_NAME,
        handler: _rootHandler,
        transitionType: _transitionType,
    );
    static Handler get _rootHandler => Handler(handlerFunc: (context, params) => TautulliRoute());

    /// /tautulli/activity/details/:sessionid
    static void _activityDetails() => router?.define(
        TautulliActivityDetailsRoute.ROUTE_NAME,
        handler: _activityDetailsHandler,
        transitionType: _transitionType,
    );
    static Handler get _activityDetailsHandler => Handler(handlerFunc: (context, params) => TautulliActivityDetailsRoute(
        sessionId: params['sessionid'][0],
    ));

    /// /tautulli/history/details/:userid/:key/:value
    static void _historyDetails() => router?.define(
        TautulliHistoryDetailsRoute.ROUTE_NAME,
        handler: _historyDetailsHandler,
        transitionType: _transitionType,
    );
    static Handler get _historyDetailsHandler => Handler(handlerFunc: (context, params) => TautulliHistoryDetailsRoute(
        userId: int.tryParse(params['userid'][0]),
        sessionKey: params['key'][0] == 'sessionkey' ? int.tryParse(params['value'][0]) : null,
        referenceId: params['key'][0] == 'referenceid' ? int.tryParse(params['value'][0]) : null,
    ));

    /// /tautulli/user/details/:userid
    static void _userDetails() => router?.define(
        TautulliUserDetailsRoute.ROUTE_NAME,
        handler: _userDetailsHandler,
        transitionType: _transitionType,
    );
    static Handler get _userDetailsHandler => Handler(handlerFunc: (context, params) => TautulliUserDetailsRoute(
        userId: int.tryParse(params['userid'][0]),
    ));

    /// /tautulli/logs
    static void _logs() => router?.define(
        TautulliLogsRoute.ROUTE_NAME,
        handler: _logsHandler,
        transitionType: _transitionType,
    );
    static Handler get _logsHandler => Handler(handlerFunc: (context, params) => TautulliLogsRoute());

    /// /tautulli/logs/logins
    static void _logsLogins() => router?.define(
        TautulliLogsLoginsRoute.ROUTE_NAME,
        handler: _logsLoginsHandler,
        transitionType: _transitionType,
    );
    static Handler get _logsLoginsHandler => Handler(handlerFunc: (context, params) => TautulliLogsLoginsRoute());

    /// /tautulli/logs/newsletters
    static void _logsNewsletters() => router?.define(
        TautulliLogsNewslettersRoute.ROUTE_NAME,
        handler: _logsNewslettersHandler,
        transitionType: _transitionType,
    );
    static Handler get _logsNewslettersHandler => Handler(handlerFunc: (context, params) => TautulliLogsNewslettersRoute());

    /// /tautulli/logs/notifications
    static void _logsNotifications() => router?.define(
        TautulliLogsNotificationsRoute.ROUTE_NAME,
        handler: _logsNotificationsHandler,
        transitionType: _transitionType,
    );
    static Handler get _logsNotificationsHandler => Handler(handlerFunc: (context, params) => TautulliLogsNotificationsRoute());

    /// /tautulli/logs/plexmediascanner
    static void _logsPlexMediaScanner() => router?.define(
        TautulliLogsPlexMediaScannerRoute.ROUTE_NAME,
        handler: _logsPlexMediaScannerHandler,
        transitionType: _transitionType,
    );
    static Handler get _logsPlexMediaScannerHandler => Handler(handlerFunc: (context, params) => TautulliLogsPlexMediaScannerRoute());

    /// /tautulli/logs/plexmediaserver
    static void _logsPlexMediaServer() => router?.define(
        TautulliLogsPlexMediaServerRoute.ROUTE_NAME,
        handler: _logsPlexMediaServerHandler,
        transitionType: _transitionType,
    );
    static Handler get _logsPlexMediaServerHandler => Handler(handlerFunc: (context, params) => TautulliLogsPlexMediaServerRoute());

    /// /tautulli/logs/tautulli
    static void _logsTautulli() => router?.define(
        TautulliLogsTautulliRoute.ROUTE_NAME,
        handler: _logsTautulliHandler,
        transitionType: _transitionType,
    );
    static Handler get _logsTautulliHandler => Handler(handlerFunc: (context, params) => TautulliLogsTautulliRoute());

    /// /tautulli/statistics
    static void _statistics() => router?.define(
        TautulliStatisticsRoute.ROUTE_NAME,
        handler: _statisticsHandler,
        transitionType: _transitionType,
    );
    static Handler get _statisticsHandler => Handler(handlerFunc: (context, params) => TautulliStatisticsRoute());

    /// /tautulli/synceditems
    static void _syncedItems() => router?.define(
        TautulliSyncedItemsRoute.ROUTE_NAME,
        handler: _syncedItemsHandler,
        transitionType: _transitionType,
    );
    static Handler get _syncedItemsHandler => Handler(handlerFunc: (context, params) => TautulliSyncedItemsRoute());

    /// /tautulli/recentlyadded
    static void _recentlyAdded() => router?.define(
        TautulliRecentlyAddedRoute.ROUTE_NAME,
        handler: _recentlyAddedHandler,
        transitionType: _transitionType,
    );
    static Handler get _recentlyAddedHandler => Handler(handlerFunc: (context, params) => TautulliRecentlyAddedRoute());

    /// /tautulli/error
    static Handler get _noFoundHandler => Handler(handlerFunc: (context, params) => TautulliErrorRoute());
}
