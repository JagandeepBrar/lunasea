import 'package:fluro_fork/fluro_fork.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliRouter {
    static Router router = Router();
    static TransitionType _transitionType = TransitionType.native;

    /// All routes start with /:profile/... for switching to specific profile by route
    static void initialize() {
        _tautulli();
        _tautulliActivityDetails();
        _tautulliHistoryDetails();
        _tautulliUserDetails();
        _tautulliLogs();
        _tautulliStatistics();
        _tautulliSyncedItems();
        router.notFoundHandler = _tautulliErrorHandler;
    }

    /// /tautulli
    static void _tautulli() => router?.define(
        TautulliRoute.ROUTE,
        handler: _tautulliHandler,
        transitionType: _transitionType,
    );
    static Handler get _tautulliHandler => Handler(handlerFunc: (context, params) => TautulliRoute());

    /// /tautulli/activity/details/:sessionid
    static void _tautulliActivityDetails() => router?.define(
        TautulliActivityDetailsRoute.ROUTE,
        handler: _tautulliActivityDetailsHandler,
        transitionType: _transitionType,
    );
    static Handler get _tautulliActivityDetailsHandler => Handler(handlerFunc: (context, params) => TautulliActivityDetailsRoute(
        sessionId: params['sessionid'][0],
    ));

    /// /tautulli/history/details/:userid/:key/:value
    static void _tautulliHistoryDetails() => router?.define(
        TautulliHistoryDetailsRoute.ROUTE,
        handler: _tautulliHistoryDetailsHandler,
        transitionType: _transitionType,
    );
    static Handler get _tautulliHistoryDetailsHandler => Handler(handlerFunc: (context, params) => TautulliHistoryDetailsRoute(
        userId: int.tryParse(params['userid'][0]),
        sessionKey: params['key'][0] == 'sessionkey' ? int.tryParse(params['value'][0]) : null,
        referenceId: params['key'][0] == 'referenceid' ? int.tryParse(params['value'][0]) : null,
    ));

    /// /tautulli/user/details/:userid
    static void _tautulliUserDetails() => router?.define(
        TautulliUserDetailsRoute.ROUTE,
        handler: _tautulliUserDetailsHandler,
        transitionType: _transitionType,
    );
    static Handler get _tautulliUserDetailsHandler => Handler(handlerFunc: (context, params) => TautulliUserDetailsRoute(
        userId: int.tryParse(params['userid'][0]),
    ));

    /// /tautulli/logs
    static void _tautulliLogs() => router?.define(
        TautulliLogsRoute.ROUTE,
        handler: _tautulliLogsHandler,
        transitionType: _transitionType,
    );
    static Handler get _tautulliLogsHandler => Handler(handlerFunc: (context, params) => TautulliLogsRoute());

    /// /tautulli/statistics
    static void _tautulliStatistics() => router?.define(
        TautulliStatisticsRoute.ROUTE,
        handler: _tautulliStatisticsHandler,
        transitionType: _transitionType,
    );
    static Handler get _tautulliStatisticsHandler => Handler(handlerFunc: (context, params) => TautulliStatisticsRoute());

    /// /tautulli/synceditems
    static void _tautulliSyncedItems() => router?.define(
        TautulliSyncedItemsRoute.ROUTE,
        handler: _tautulliSyncedItemsHandler,
        transitionType: _transitionType,
    );
    static Handler get _tautulliSyncedItemsHandler => Handler(handlerFunc: (context, params) => TautulliSyncedItemsRoute());

    /// /tautulli/error
    static Handler get _tautulliErrorHandler => Handler(handlerFunc: (context, params) => TautulliErrorRoute());
}
