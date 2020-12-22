import 'package:fluro/fluro.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/ombi.dart';

class OmbiRouter extends LunaModuleRouter {
    @override
    void defineAllRoutes(FluroRouter router) {
        OmbiHomeRouter.defineRoutes(router);
    }
}
