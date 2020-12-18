import 'package:fluro/fluro.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliRouter extends LunaModuleRouter {
    @override
    void defineAllRoutes(FluroRouter router) {
        TautulliHomeRouter.defineRoutes(router);
        // Details
        TautulliActivityDetailsRouter.defineRoutes(router);
        TautulliIPAddressDetailsRouter.defineRoutes(router);
        TautulliLibrariesDetailsRouter.defineRoutes(router);
        TautulliHistoryDetailsRouter.defineRoutes(router);
        TautulliUserDetailsRouter.defineRoutes(router);
        TautulliMediaDetailsRouter.defineRoutes(router);
        // More/*
        TautulliCheckForUpdatesRouter.defineRoutes(router);
        TautulliSearchRouter.defineRoutes(router);
        TautulliGraphsRouter.defineRoutes(router);
        TautulliLibrariesRouter.defineRoutes(router);
        TautulliSyncedItemsRouter.defineRoutes(router);
        TautulliStatisticsRouter.defineRoutes(router);
        TautulliRecentlyAddedRouter.defineRoutes(router);
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
