import 'package:fluro_fork/fluro_fork.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliRouter {
    static Router router = Router();

    TautulliRouter._();

    static void initialize() {
        TautulliHomeRouter.defineRoutes(router);
        // Details
        TautulliActivityDetailsRouter.defineRoutes(router);
        TautulliIPAddressDetailsRouter.defineRoutes(router);
        TautulliLibrariesDetailsRouter.defineRoutes(router);
        TautulliHistoryDetailsRouter.defineRoutes(router);
        TautulliUserDetailsRouter.defineRoutes(router);
        
        TautulliMediaDetailsRoute.defineRoute(router);
        // More/*
        TautulliCheckForUpdatesRouter.defineRoutes(router);
        TautulliSearchRouter.defineRoutes(router);
        TautulliGraphsRouter.defineRoutes(router);
        TautulliLibrariesRouter.defineRoutes(router);
        
        TautulliStatisticsRoute.defineRoute(router);
        TautulliSyncedItemsRoute.defineRoute(router);
        TautulliRecentlyAddedRoute.defineRoute(router);
        // Logs
        TautulliLogsRouter.defineRoutes(router);
        TautulliLogsLoginsRouter.defineRoutes(router);
        TautulliLogsNewslettersRouter.defineRoutes(router);
        TautulliLogsNotificationsRouter.defineRoutes(router);
        TautulliLogsPlexMediaScannerRouter.defineRoutes(router);
        TautulliLogsPlexMediaServerRouter.defineRoutes(router);
        TautulliLogsTautulliRouter.defineRoutes(router);
    }
}
