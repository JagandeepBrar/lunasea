import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/search.dart';

class SearchSubcategoriesRouter extends SearchPageRouter {
  SearchSubcategoriesRouter() : super('/search/subcategories');

  @override
  Widget widget() => _Widget();

  @override
  void defineRoute(FluroRouter router) {
    super.noParameterRouteDefinition(router);
  }
}

class _Widget extends StatefulWidget {
  @override
  State<_Widget> createState() => _State();
}

class _State extends State<_Widget> with LunaScrollControllerMixin {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return LunaScaffold(
      scaffoldKey: _scaffoldKey,
      appBar: _appBar(),
      body: _body(),
    );
  }

  Widget _appBar() {
    return LunaAppBar(
      title: context.read<SearchState>().activeCategory?.name ??
          'search.Subcategories'.tr(),
      scrollControllers: [scrollController],
      actions: [
        LunaIconButton(
          icon: Icons.search,
          onPressed: () async {
            context.read<SearchState>().activeSubcategory = null;
            SearchSearchRouter().navigateTo(context);
          },
        ),
      ],
    );
  }

  Widget _body() {
    return Selector<SearchState, NewznabCategoryData>(
      selector: (_, state) => state.activeCategory,
      builder: (context, category, child) {
        List<NewznabSubcategoryData> subcategories =
            category?.subcategories ?? [];
        return LunaListView(
          controller: scrollController,
          children: [
            const SearchSubcategoryAllTile(),
            ...List.generate(
              subcategories.length,
              (index) => SearchSubcategoryTile(index: index),
            ),
          ],
        );
      },
    );
  }
}
