import 'package:fluro/fluro.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrRouter extends LunaModuleRouter {
    @override
    void defineAllRoutes(FluroRouter router) {
        RadarrHomeRouter().defineRoute(router);
        RadarrHealthCheckRouter().defineRoute(router);
        RadarrHistoryRouter().defineRoute(router);
        RadarrMoviesAddRouter().defineRoute(router);
        RadarrMoviesAddDetailsRouter().defineRoute(router);
        RadarrMoviesDetailsRouter().defineRoute(router);
        RadarrMoviesEditRouter().defineRoute(router);
        RadarrReleasesRouter().defineRoute(router);
        RadarrQueueRouter().defineRoute(router);
        RadarrSystemStatusRouter().defineRoute(router);
        RadarrTagsRouter().defineRoute(router);
    }
}
