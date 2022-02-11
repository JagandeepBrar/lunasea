import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/readarr.dart';

class ReadarrReleasesRouter extends ReadarrPageRouter {
  ReadarrReleasesRouter() : super('/readarr/releases');

  @override
  Widget widget({
    int? bookId,
    int? authorId,
  }) =>
      _Widget(
        bookId: bookId,
        authorId: authorId,
      );

  @override
  Future<void> navigateTo(
    BuildContext context, {
    int? bookId,
    int? authorId,
  }) async =>
      LunaRouter.router.navigateTo(
        context,
        route(
          bookId: bookId,
          authorId: authorId,
        ),
      );

  @override
  String route({
    int? bookId,
    int? authorId,
  }) {
    if (bookId != null) {
      return '$fullRoute/book/$bookId';
    } else if (authorId != null) {
      return '$fullRoute/author/$authorId';
    } else {
      throw Exception('bookId or authorId must be passed to this route');
    }
  }

  @override
  void defineRoute(FluroRouter router) {
    router.define(
      '$fullRoute/book/:bookid',
      handler: Handler(
        handlerFunc: (context, params) {
          if (!context!.read<ReadarrState>().enabled) {
            return LunaNotEnabledRoute(module: LunaModule.READARR.name);
          }
          int bookId = int.tryParse(params['bookid']![0]) ?? -1;
          return _Widget(
            bookId: bookId,
          );
        },
      ),
      transitionType: LunaRouter.transitionType,
    );
    router.define(
      '$fullRoute/author/:authorid',
      handler: Handler(
        handlerFunc: (context, params) {
          if (!context!.read<ReadarrState>().enabled) {
            return LunaNotEnabledRoute(module: LunaModule.READARR.name);
          }
          int authorId = int.tryParse(params['authorid']![0]) ?? -1;
          return _Widget(
            authorId: authorId,
          );
        },
      ),
      transitionType: LunaRouter.transitionType,
    );
  }
}

class _Widget extends StatefulWidget {
  final int? bookId;
  final int? authorId;

  const _Widget({
    Key? key,
    this.bookId,
    this.authorId,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<_Widget> with LunaScrollControllerMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ReadarrReleasesState(
        context: context,
        bookId: widget.bookId,
        authorId: widget.authorId,
      ),
      builder: (context, _) => LunaScaffold(
        scaffoldKey: _scaffoldKey,
        appBar: _appBar(context) as PreferredSizeWidget?,
        body: _body(context),
      ),
    );
  }

  Widget _appBar(BuildContext context) {
    return LunaAppBar(
      title: 'readarr.Releases'.tr(),
      scrollControllers: [scrollController],
      bottom: ReadarrReleasesSearchBar(scrollController: scrollController),
    );
  }

  Widget _body(BuildContext context) {
    return LunaRefreshIndicator(
      context: context,
      key: _refreshKey,
      onRefresh: () async {
        context.read<ReadarrReleasesState>().refreshReleases(context);
        await context.read<ReadarrReleasesState>().releases;
      },
      child: FutureBuilder(
        future: context.read<ReadarrReleasesState>().releases,
        builder: (context, AsyncSnapshot<List<ReadarrRelease>> snapshot) {
          if (snapshot.hasError) {
            if (snapshot.connectionState != ConnectionState.waiting) {
              LunaLogger().error(
                'Unable to fetch Readarr releases',
                snapshot.error,
                snapshot.stackTrace,
              );
            }
            return LunaMessage.error(
              onTap: () => _refreshKey.currentState!.show,
            );
          }
          if (snapshot.hasData) return _list(context, snapshot.data);
          return const LunaLoader();
        },
      ),
    );
  }

  Widget _list(BuildContext context, List<ReadarrRelease>? releases) {
    return Consumer<ReadarrReleasesState>(
      builder: (context, state, _) {
        if (releases?.isEmpty ?? true) {
          return LunaMessage(
            text: 'readarr.NoReleasesFound'.tr(),
            buttonText: 'lunasea.Refresh'.tr(),
            onTap: _refreshKey.currentState!.show,
          );
        }
        List<ReadarrRelease> _processed = _filterAndSortReleases(
          releases ?? [],
          state,
        );
        return LunaListViewBuilder(
          controller: scrollController,
          itemCount: _processed.isEmpty ? 1 : _processed.length,
          itemBuilder: (context, index) {
            if (_processed.isEmpty) {
              return LunaMessage.inList(text: 'readarr.NoReleasesFound'.tr());
            }
            return ReadarrReleasesTile(release: _processed[index]);
          },
        );
      },
    );
  }

  List<ReadarrRelease> _filterAndSortReleases(
    List<ReadarrRelease> releases,
    ReadarrReleasesState state,
  ) {
    if (releases.isEmpty) return releases;
    List<ReadarrRelease> filtered = releases.where(
      (release) {
        String _query = state.searchQuery;
        if (_query.isNotEmpty) {
          return release.title!.toLowerCase().contains(_query.toLowerCase());
        }
        return true;
      },
    ).toList();
    filtered = state.filterType.filter(filtered);
    filtered = state.sortType.sort(filtered, state.sortAscending);
    return filtered;
  }
}
