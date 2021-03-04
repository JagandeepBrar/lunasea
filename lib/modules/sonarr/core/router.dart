import 'package:fluro/fluro.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrRouter extends LunaModuleRouter {
    @override
    void defineAllRoutes(FluroRouter router) {
        SonarrHomeRouter().defineRoute(router);
        // Series
        SonarrSeriesAddRouter.defineRoutes(router);
        SonarrSeriesAddDetailsRouter.defineRoutes(router);
        SonarrSeriesEditRouter.defineRoutes(router);
        SonarrSeriesDetailsRouter().defineRoute(router);
        SonarrSeasonDetailsRouter().defineRoute(router);
        // Other
        SonarrQueueRouter().defineRoute(router);
        SonarrReleasesRouter.defineRoutes(router);
        SonarrTagsRouter().defineRoute(router);
    }
}
