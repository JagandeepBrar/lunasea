import 'package:fluro_fork/fluro_fork.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrRouter {
    static Router router = Router();

    SonarrRouter._();

    static void initialize() {
        SonarrHomeRouter.defineRoutes(router);
        // Series
        SonarrSeriesAddRouter.defineRoutes(router);
        SonarrSeriesEditRouter.defineRoutes(router);
        SonarrSeriesDetailsRouter.defineRoutes(router);
        SonarrSeriesSeasonDetailsRouter.defineRoutes(router);
        // Other
        SonarrQueueRouter.defineRoutes(router);
        SonarrReleasesRouter.defineRoutes(router);
    }
}
