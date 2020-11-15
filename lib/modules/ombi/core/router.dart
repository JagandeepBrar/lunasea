import 'package:fluro/fluro.dart';
import 'package:lunasea/modules/ombi.dart';

class OmbiRouter {
    OmbiRouter._();

    static void initialize(FluroRouter router) {
        OmbiHomeRouter.defineRoutes(router);
    }
}
