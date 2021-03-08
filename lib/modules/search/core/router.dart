import 'package:fluro/fluro.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/search.dart';

class SearchRouter extends LunaModuleRouter {
    @override
    void defineAllRoutes(FluroRouter router) {
        SearchHomeRouter().defineRoute(router);
        SearchCategoriesRouter().defineRoute(router);
        SearchSubcategoriesRouter().defineRoute(router);
        SearchResultsRouter().defineRoute(router);
        SearchSearchRouter().defineRoute(router);
    }
}
