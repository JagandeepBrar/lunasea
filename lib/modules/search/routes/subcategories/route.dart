import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/search.dart';

class SearchSubcategoriesRouter extends LunaPageRouter {
    SearchSubcategoriesRouter() : super('/search/subcategories');

    @override
    void defineRoute(FluroRouter router) => super.noParameterRouteDefinition(router, _SearchSubategoriesRoute());
}

class _SearchSubategoriesRoute extends StatefulWidget {
    @override
    State<_SearchSubategoriesRoute> createState() =>  _State();
}

class _State extends State<_SearchSubategoriesRoute> with LunaScrollControllerMixin {
    final _scaffoldKey = GlobalKey<ScaffoldState>();

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            key: _scaffoldKey,
            appBar: _appBar(),
            body: _body, 
        );
    }

    Widget _appBar() {
        return LunaAppBar(
            title: context.read<SearchState>().activeCategory?.name ?? 'search.Subcategories'.tr(),
            scrollControllers: [scrollController],
            actions: [
                LunaIconButton(
                    icon: Icons.search,
                    onPressed: _enterSearch,
                ),
            ],
        );
    }

    Widget get _body => Consumer<SearchState>(
        builder: (context, _state, child) => LunaListViewBuilder(
            controller: scrollController,
            itemCount: (_state?.activeCategory?.subcategories?.length ?? 0)+1,
            itemBuilder: (context, index) => SearchSubcategoryTile(
                category: _state?.activeCategory,
                index: index-1,
                allSubcategories: index == 0,
            ),
        ),
    );

    Future<void> _enterSearch() async {
        final model = Provider.of<SearchState>(context, listen: false);
        model.searchTitle = '${model?.activeCategory?.name ?? ''}';
        model.searchCategoryID = model?.activeCategory?.id ?? 0;
        model.searchQuery = '';
        await Navigator.of(context).pushNamed(SearchSearch.ROUTE_NAME);
    }
}
