import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/mylar.dart';
import 'package:lunasea/widgets/sheets/download_client/button.dart';

class ReleasesRoute extends StatefulWidget {
  final int? episodeId;
  final int? seriesId;
  final int? seasonNumber;

  const ReleasesRoute({
    Key? key,
    this.episodeId,
    this.seriesId,
    this.seasonNumber,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<ReleasesRoute> with LunaScrollControllerMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MylarReleasesState(
        context: context,
        episodeId: widget.episodeId,
        seriesId: widget.seriesId,
        seasonNumber: widget.seasonNumber,
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
      title: 'mylar.Releases'.tr(),
      scrollControllers: [scrollController],
      bottom: MylarReleasesSearchBar(scrollController: scrollController),
      actions: const [
        DownloadClientButton(),
      ],
    );
  }

  Widget _body(BuildContext context) {
    return LunaRefreshIndicator(
      context: context,
      key: _refreshKey,
      onRefresh: () async {
        context.read<MylarReleasesState>().refreshReleases(context);
        await context.read<MylarReleasesState>().releases;
      },
      child: FutureBuilder(
        future: context.read<MylarReleasesState>().releases,
        builder: (context, AsyncSnapshot<List<MylarRelease>> snapshot) {
          if (snapshot.hasError) {
            if (snapshot.connectionState != ConnectionState.waiting) {
              LunaLogger().error(
                'Unable to fetch Mylar releases',
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

  Widget _list(BuildContext context, List<MylarRelease>? releases) {
    return Consumer<MylarReleasesState>(
      builder: (context, state, _) {
        if (releases?.isEmpty ?? true) {
          return LunaMessage(
            text: 'mylar.NoReleasesFound'.tr(),
            buttonText: 'lunasea.Refresh'.tr(),
            onTap: _refreshKey.currentState!.show,
          );
        }
        List<MylarRelease> _processed = _filterAndSortReleases(
          releases ?? [],
          state,
        );
        return LunaListViewBuilder(
          controller: scrollController,
          itemCount: _processed.isEmpty ? 1 : _processed.length,
          itemBuilder: (context, index) {
            if (_processed.isEmpty) {
              return LunaMessage.inList(text: 'mylar.NoReleasesFound'.tr());
            }
            return MylarReleasesTile(release: _processed[index]);
          },
        );
      },
    );
  }

  List<MylarRelease> _filterAndSortReleases(
    List<MylarRelease> releases,
    MylarReleasesState state,
  ) {
    if (releases.isEmpty) return releases;
    List<MylarRelease> filtered = releases.where(
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
