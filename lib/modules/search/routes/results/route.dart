import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/search.dart';

class SearchResultsRouter extends SearchPageRouter {
  SearchResultsRouter() : super('/search/results');

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
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();
  final PagingController<int, NewznabResultData> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void dispose() {
    _pagingController?.dispose();
    super.dispose();
  }

  Future<void> _fetchPage(int pageKey) async {
    NewznabCategoryData? category = context.read<SearchState>().activeCategory;
    NewznabSubcategoryData? subcategory =
        context.read<SearchState>().activeSubcategory;
    await context
        .read<SearchState>()
        .api
        .getResults(
          categoryId: subcategory?.id ?? category?.id,
          offset: pageKey,
        )
        .then((data) {
      if (data.isEmpty) return _pagingController.appendLastPage([]);
      return _pagingController.appendPage(data, pageKey + 1);
    }).catchError((error, stack) {
      LunaLogger().error(
        'Unable to fetch search results page: $pageKey',
        error,
        stack,
      );
      _pagingController.error = error;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LunaScaffold(
      scaffoldKey: _scaffoldKey,
      appBar: _appBar() as PreferredSizeWidget?,
      body: _body(),
    );
  }

  Widget _appBar() {
    String? title = 'search.Results'.tr();
    NewznabCategoryData? category = context.read<SearchState>().activeCategory;
    NewznabSubcategoryData? subcategory =
        context.read<SearchState>().activeSubcategory;
    if (category != null) title = category.name;
    if (category != null && subcategory != null) {
      title = '$title > ${subcategory.name ?? 'lunasea.Unknown'.tr()}';
    }
    return LunaAppBar(
      title: title!,
      actions: [
        LunaIconButton(
          icon: Icons.search_rounded,
          onPressed: () async => SearchSearchRouter().navigateTo(context),
        ),
      ],
      scrollControllers: [scrollController],
    );
  }

  Widget _body() {
    return LunaPagedListView<NewznabResultData>(
      refreshKey: _refreshKey,
      pagingController: _pagingController,
      scrollController: scrollController,
      listener: _fetchPage,
      noItemsFoundMessage: 'search.NoResultsFound'.tr(),
      itemBuilder: (context, result, index) => SearchResultTile(data: result),
    );
  }
}
