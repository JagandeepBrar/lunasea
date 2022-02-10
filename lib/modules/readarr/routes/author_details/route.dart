import 'package:collection/collection.dart' show IterableExtension;
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/readarr.dart';

class ReadarrAuthorDetailsRouter extends ReadarrPageRouter {
  ReadarrAuthorDetailsRouter() : super('/readarr/series/:seriesid');

  @override
  _ReadarrAuthorDetails widget([
    int authorId = -1,
  ]) {
    return _ReadarrAuthorDetails(authorId: authorId);
  }

  @override
  Future<void> navigateTo(
    BuildContext context, [
    int authorId = -1,
  ]) async {
    return LunaRouter.router.navigateTo(context, route(authorId));
  }

  @override
  String route([int authorId = -1]) {
    return fullRoute.replaceFirst(
      ':seriesid',
      authorId.toString(),
    );
  }

  @override
  void defineRoute(FluroRouter router) {
    super.withParameterRouteDefinition(
      router,
      (context, params) {
        int authorId = (params['seriesid']?.isNotEmpty ?? false)
            ? (int.tryParse(params['seriesid']![0]) ?? -1)
            : -1;
        return _ReadarrAuthorDetails(authorId: authorId);
      },
    );
  }
}

class _ReadarrAuthorDetails extends StatefulWidget {
  final int authorId;

  const _ReadarrAuthorDetails({
    Key? key,
    required this.authorId,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<_ReadarrAuthorDetails> with LunaLoadCallbackMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  ReadarrAuthor? author;
  PageController? _pageController;

  @override
  Future<void> loadCallback() async {
    if (widget.authorId > 0) {
      ReadarrAuthor? result =
          (await context.read<ReadarrState>().authors)![widget.authorId];
      setState(() => author = result);
      context.read<ReadarrState>().fetchQualityProfiles();
      context.read<ReadarrState>().fetchMetadataProfiles();
      context.read<ReadarrState>().fetchTags();
      context.read<ReadarrState>().fetchAllBooks();
      await context.read<ReadarrState>().fetchAuthor(widget.authorId);
    }
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: ReadarrDatabaseValue.NAVIGATION_INDEX_SERIES_DETAILS.data,
    );
  }

  List<ReadarrTag> _findTags(
    List<int>? tagIds,
    List<ReadarrTag> tags,
  ) {
    return tags.where((tag) => tagIds!.contains(tag.id)).toList();
  }

  ReadarrQualityProfile? _findQualityProfile(
    int? qualityProfileId,
    List<ReadarrQualityProfile> profiles,
  ) {
    return profiles.firstWhereOrNull(
      (profile) => profile.id == qualityProfileId,
    );
  }

  ReadarrMetadataProfile? _findMetadataProfile(
    int? metadataProfileId,
    List<ReadarrMetadataProfile> profiles,
  ) {
    return profiles.firstWhereOrNull(
      (profile) => profile.id == metadataProfileId,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.authorId <= 0) {
      return LunaInvalidRoute(
        title: 'readarr.AuthorDetails'.tr(),
        message: 'readarr.AuthorNotFound'.tr(),
      );
    }
    return LunaScaffold(
      scaffoldKey: _scaffoldKey,
      module: LunaModule.READARR,
      appBar: _appBar() as PreferredSizeWidget?,
      bottomNavigationBar:
          context.watch<ReadarrState>().enabled ? _bottomNavigationBar() : null,
      body: _body(),
    );
  }

  Widget _appBar() {
    List<Widget>? _actions = author == null
        ? null
        : [
            LunaIconButton(
              icon: Icons.edit_rounded,
              onPressed: () async => ReadarrEditAuthorRouter().navigateTo(
                context,
                widget.authorId,
              ),
            ),
            ReadarrAppBarSeriesSettingsAction(authorId: widget.authorId),
          ];
    return LunaAppBar(
      title: 'readarr.AuthorDetails'.tr(),
      scrollControllers: ReadarrAuthorDetailsNavigationBar.scrollControllers,
      pageController: _pageController,
      actions: _actions,
    );
  }

  Widget? _bottomNavigationBar() {
    if (author == null) return null;
    return ReadarrAuthorDetailsNavigationBar(
        pageController: _pageController, author: author);
  }

  Widget _body() {
    return Consumer<ReadarrState>(
      builder: (context, state, _) => FutureBuilder(
        future: Future.wait([
          state.qualityProfiles!,
          state.metadataProfiles!,
          state.tags!,
          state.authors!,
          state.books!
        ]),
        builder: (context, AsyncSnapshot<List<Object>> snapshot) {
          if (snapshot.hasError) {
            if (snapshot.connectionState != ConnectionState.waiting) {
              LunaLogger().error(
                'Unable to pull Readarr author details',
                snapshot.error,
                snapshot.stackTrace,
              );
            }
            return LunaMessage.error(onTap: loadCallback);
          }
          if (snapshot.hasData) {
            author =
                (snapshot.data![3] as Map<int, ReadarrAuthor>)[widget.authorId];
            if (author == null) {
              return LunaMessage.goBack(
                text: 'readarr.AuthorNotFound'.tr(),
                context: context,
              );
            }
            List<ReadarrBook> books =
                (snapshot.data![4] as Map<int, ReadarrBook>)
                    .values
                    .where((b) => b.authorId == widget.authorId)
                    .toList();
            ReadarrQualityProfile? quality = _findQualityProfile(
              author!.qualityProfileId,
              snapshot.data![0] as List<ReadarrQualityProfile>,
            );
            ReadarrMetadataProfile? language = _findMetadataProfile(
              author!.metadataProfileId,
              snapshot.data![1] as List<ReadarrMetadataProfile>,
            );
            List<ReadarrTag> tags =
                _findTags(author!.tags, snapshot.data![2] as List<ReadarrTag>);

            return _pages(
                qualityProfile: quality,
                metadataProfile: language,
                tags: tags,
                books: books);
          }
          return const LunaLoader();
        },
      ),
    );
  }

  Widget _pages(
      {required ReadarrQualityProfile? qualityProfile,
      required ReadarrMetadataProfile? metadataProfile,
      required List<ReadarrTag> tags,
      required List<ReadarrBook> books}) {
    return ChangeNotifierProvider(
      create: (context) => ReadarrAuthorDetailsState(
        context: context,
        author: author!,
        books: books,
      ),
      builder: (context, _) => LunaPageView(
        controller: _pageController,
        children: [
          ReadarrAuthorDetailsOverviewPage(
            author: author!,
            qualityProfile: qualityProfile,
            metadataProfile: metadataProfile,
            tags: tags,
          ),
          ReadarrAuthorDetailsBooksPage(author: author, books: books),
          const ReadarrAuthorDetailsHistoryPage(),
        ],
      ),
    );
  }
}
