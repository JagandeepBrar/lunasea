import 'package:fluro/fluro.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrRouter extends LunaModuleRouter {
    @override
    void defineAllRoutes(FluroRouter router) {
        RadarrHomeRouter().defineRoute(router);
        RadarrMoviesAddRouter().defineRoute(router);
        RadarrMoviesDetailsRouter().defineRoute(router);
        RadarrTagsRouter().defineRoute(router);
    }
}
