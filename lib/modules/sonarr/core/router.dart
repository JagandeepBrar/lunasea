import 'package:fluro_fork/fluro_fork.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrRouter {
    static Router router = Router();

    SonarrRouter._();

    static void initialize() {
        SonarrHomeRouter.defineRoutes(router);
        // Details
        SonarrSeriesDetailsRouter.defineRoutes(router);
    }
}
