import 'package:fluro_fork/fluro_fork.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliRouter {
    static Router router = Router();

    TautulliRouter._();

    static void initialize() {
        TautulliRoute.defineRoute(router);
        // Details
        TautulliActivityDetailsRouter.defineRoutes(router);
        TautulliHistoryDetailsRoute.defineRoute(router);
        TautulliIPAddressDetailsRouter.defineRoutes(router);
        TautulliLibrariesDetailsRouter.defineRoutes(router);
        TautulliMediaDetailsRoute.defineRoute(router);
        TautulliUserDetailsRoute.defineRoute(router);
        // More/*
        TautulliCheckForUpdatesRouter.defineRoutes(router);
        TautulliGraphsRoute.defineRoute(router);
        TautulliLibrariesRoute.defineRoute(router);
        TautulliSearchRouter.defineRoutes(router);
        TautulliStatisticsRoute.defineRoute(router);
        TautulliSyncedItemsRoute.defineRoute(router);
        TautulliRecentlyAddedRoute.defineRoute(router);
        // Logs
        TautulliLogsRoute.defineRoute(router);
        TautulliLogsLoginsRoute.defineRoute(router);
        TautulliLogsNewslettersRoute.defineRoute(router);
        TautulliLogsNotificationsRoute.defineRoute(router);
        TautulliLogsPlexMediaScannerRoute.defineRoute(router);
        TautulliLogsPlexMediaServerRoute.defineRoute(router);
        TautulliLogsTautulliRoute.defineRoute(router);
    }
}
