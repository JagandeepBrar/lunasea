import 'package:fluro_fork/fluro_fork.dart';
import 'package:lunasea/modules/ombi.dart';

class OmbiRouter {
    static Router router = Router();

    OmbiRouter._();

    static void initialize() {
        OmbiHomeRouter.defineRoutes(router);
    }
}
