import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/search.dart';

class SearchCategoriesRouter extends SearchPageRouter {
    SearchCategoriesRouter() : super('/search/categories');

    @override
    void defineRoute(FluroRouter router) => super.noParameterRouteDefinition(router, _SearchCategoriesRoute());
}

class _SearchCategoriesRoute extends StatefulWidget {
    @override
    State<_SearchCategoriesRoute> createState() =>  _State();
}

class _State extends State<_SearchCategoriesRoute> with LunaLoadCallbackMixin, LunaScrollControllerMixin {
    static const ADULT_CATEGORIES = ['xxx', 'adult', 'porn'];
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey<RefreshIndicatorState>();

    @override
    Future<void> loadCallback() async => context.read<SearchState>().fetchCategories();

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            key: _scaffoldKey,
            appBar: _appBar(),
            body: _body(), 
        );
    }

    Widget _appBar() {
        return LunaAppBar(
            title: context.read<SearchState>().indexer?.displayName ?? 'search.Categories'.tr(),
            scrollControllers: [scrollController],
            actions: <Widget>[
                LunaIconButton(
                    icon: Icons.search,
                    onPressed: _enterSearch,
                ),
            ],
        );
    }

    Widget _body() {
        return LunaRefreshIndicator(
            context: context,
            key: _refreshKey,
            onRefresh: loadCallback,
            child: FutureBuilder(
                future: context.watch<SearchState>().categories,
                builder: (context, AsyncSnapshot<List<NewznabCategoryData>> snapshot) {
                    if(snapshot.hasError) {
                        LunaLogger().error('Unable to fetch categories', snapshot.error, snapshot.stackTrace);
                        return LunaMessage.error(onTap: _refreshKey.currentState.show);
                    }
                    if(snapshot.connectionState == ConnectionState.done && snapshot.hasData) return _list(snapshot.data);
                    return LunaLoader();
                },
            ),
        );
    }

    Widget _list(List<NewznabCategoryData> categories) {
        if((categories.length ?? 0) == 0) return LunaMessage.goBack(
            context: context,
            text: 'search.NoCategoriesFound'.tr(),
        );
        List<NewznabCategoryData> filtered = _filter(categories);
        return LunaListViewBuilder(
            controller: scrollController,
            itemCount: filtered.length,
            itemBuilder: (context, index) => SearchCategoryTile(category: filtered[index], index: index),
        );
    }

    List<NewznabCategoryData> _filter(List<NewznabCategoryData> categories) {
        return categories.where((category) {
            if(!SearchDatabaseValue.HIDE_XXX.data) return true;
            if(category.id >= 6000 && category.id <= 6999) return false;
            if(ADULT_CATEGORIES.contains(category.name.toLowerCase().trim())) return false;
            return true;
        }).toList();
    }

    Future<void> _enterSearch() async {
        context.read<SearchState>().activeCategory = null;
        context.read<SearchState>().activeSubcategory = null;
        SearchSearchRouter().navigateTo(context);
    }
}
