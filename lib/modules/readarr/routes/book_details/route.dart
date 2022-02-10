import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/readarr.dart';

class ReadarrBookDetailsRouter extends ReadarrPageRouter {
  ReadarrBookDetailsRouter() : super('/readarr/book/:bookid');

  @override
  Widget widget([
    int bookId = -1,
  ]) {
    return _Widget(bookId: bookId);
  }

  @override
  Future<void> navigateTo(
    BuildContext context, [
    int bookId = -1,
  ]) async {
    LunaRouter.router.navigateTo(context, route(bookId));
  }

  @override
  String route([
    int bookId = -1,
  ]) {
    return fullRoute.replaceFirst(':bookid', bookId.toString());
  }

  @override
  void defineRoute(FluroRouter router) {
    super.withParameterRouteDefinition(
      router,
      (context, params) {
        int bookId = params['bookid'] == null || params['bookid']!.isEmpty
            ? -1
            : (int.tryParse(params['bookid']![0]) ?? -1);
        return _Widget(bookId: bookId);
      },
    );
  }
}

class _Widget extends StatefulWidget {
  final int bookId;

  const _Widget({
    Key? key,
    required this.bookId,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<_Widget> with LunaLoadCallbackMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  ReadarrBook? book;
  PageController? _pageController;

  @override
  Future<void> loadCallback() async {
    if (widget.bookId > 0) {
      ReadarrBook? result =
          (await context.read<ReadarrState>().books)![widget.bookId];
      setState(() => book = result);
      context.read<ReadarrState>().fetchQualityProfiles();
      context.read<ReadarrState>().fetchTags();
      //await context.read<ReadarrState>().resetSingleBook(widget.bookId);
    }
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: ReadarrDatabaseValue.NAVIGATION_INDEX_SEASON_DETAILS.data,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.bookId <= 0)
      return LunaInvalidRoute(
        title: 'Book Details',
        message: 'Book Not Found',
      );
    return LunaScaffold(
      scaffoldKey: _scaffoldKey,
      module: LunaModule.RADARR,
      appBar: _appBar(),
      bottomNavigationBar:
          context.watch<ReadarrState>().enabled ? _bottomNavigationBar() : null,
      body: _body(),
    );
  }

  PreferredSizeWidget _appBar() {
    List<Widget>? _actions = book == null
        ? null
        : [
            LunaIconButton(
              iconSize: LunaUI.ICON_SIZE,
              icon: Icons.edit_rounded,
              //onPressed: () async =>
              //    ReadarrBooksEditRouter().navigateTo(context, widget.bookId),
            ),
            ReadarrAppBarBookSettingsAction(bookId: widget.bookId),
          ];
    return LunaAppBar(
      pageController: _pageController,
      scrollControllers: ReadarrBookDetailsNavigationBar.scrollControllers,
      title: 'Book Details',
      actions: _actions,
    );
  }

  Widget? _bottomNavigationBar() {
    if (book == null) return null;
    return ReadarrBookDetailsNavigationBar(
      pageController: _pageController,
      book: book,
    );
  }

  Widget _body() {
    return Consumer<ReadarrState>(
      builder: (context, state, _) => FutureBuilder(
        future: Future.wait([
          state.qualityProfiles!,
          state.tags!,
          state.books!,
        ]),
        builder: (context, AsyncSnapshot<List<Object>> snapshot) {
          if (snapshot.hasError) {
            if (snapshot.connectionState != ConnectionState.waiting)
              LunaLogger().error(
                'Unable to pull Readarr book details',
                snapshot.error,
                snapshot.stackTrace,
              );
            return LunaMessage.error(onTap: loadCallback);
          }
          if (snapshot.hasData) {
            book = (snapshot.data![2] as Map<int, ReadarrBook>)[widget.bookId];
            if (book == null)
              return LunaMessage.goBack(
                text: 'Book Not Found',
                context: context,
              );
            return _pages();
          }
          return const LunaLoader();
        },
      ),
    );
  }

  Widget _pages() {
    return ChangeNotifierProvider(
      create: (context) =>
          ReadarrBookDetailsState(context: context, book: book!),
      builder: (context, _) => LunaPageView(
        controller: _pageController,
        children: [
          ReadarrBookDetailsOverviewPage(
            book: book,
          ),
          const ReadarrBookDetailsFilesPage(),
          ReadarrBookDetailsHistoryPage(movie: book),
        ],
      ),
    );
  }
}
