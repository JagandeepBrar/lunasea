import 'package:fluro_fork/fluro_fork.dart';
import 'package:lunasea/modules/ombi.dart';

class OmbiRouter {
    OmbiRouter._();

    static void initialize(Router router) {
        OmbiHomeRouter.defineRoutes(router);
    }
}
