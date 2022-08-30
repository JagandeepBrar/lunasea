import 'package:flutter/material.dart';
import 'package:lunasea/modules.dart';
import 'package:lunasea/modules/search/routes/categories/route.dart';
import 'package:lunasea/modules/search/routes/indexers/route.dart';
import 'package:lunasea/modules/search/routes/results/route.dart';
import 'package:lunasea/modules/search/routes/search/route.dart';
import 'package:lunasea/modules/search/routes/subcategories/route.dart';
import 'package:lunasea/router/routes.dart';
import 'package:lunasea/vendor.dart';

enum SearchRoutes with LunaRoutesMixin {
  HOME('/search'),
  CATEGORIES('categories'),
  RESULTS('results'),
  SEARCH('search'),
  SUBCATEGORIES('subcategories');

  @override
  final String path;

  const SearchRoutes(this.path);

  @override
  LunaModule get module => LunaModule.SEARCH;

  @override
  bool isModuleEnabled(BuildContext context) => true;

  @override
  GoRoute get routes {
    switch (this) {
      case SearchRoutes.HOME:
        return route(widget: const SearchRoute());
      case SearchRoutes.CATEGORIES:
        return route(widget: const CategoriesRoute());
      case SearchRoutes.RESULTS:
        return route(widget: const ResultsRoute());
      case SearchRoutes.SEARCH:
        return route(widget: const SearchIndexerRoute());
      case SearchRoutes.SUBCATEGORIES:
        return route(widget: const SubcategoriesRoute());
    }
  }

  @override
  List<GoRoute> get subroutes {
    switch (this) {
      case SearchRoutes.HOME:
        return [
          SearchRoutes.CATEGORIES.routes,
          SearchRoutes.RESULTS.routes,
          SearchRoutes.SEARCH.routes,
          SearchRoutes.SUBCATEGORIES.routes,
        ];
      default:
        return const [];
    }
  }
}
