import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/lidarr.dart';
import 'package:lunasea/widgets/sheets/download_client/button.dart';

class ArtistAlbumReleasesRoute extends StatefulWidget {
  final int albumId;

  const ArtistAlbumReleasesRoute({
    Key? key,
    required this.albumId,
  }) : super(key: key);

  @override
  State<ArtistAlbumReleasesRoute> createState() => _State();
}

class _State extends State<ArtistAlbumReleasesRoute>
    with LunaScrollControllerMixin, LunaLoadCallbackMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();
  Future<List<LidarrReleaseData>>? _future;
  List<LidarrReleaseData>? _results = [];

  @override
  Future<void> loadCallback() async {
    if (mounted) setState(() => _results = []);
    final _api = LidarrAPI.from(LunaProfile.current);
    setState(() {
      _future = _api.getReleases(widget.albumId);
    });
    //Clear the search filter using a microtask
    Future.microtask(
        () => context.read<LidarrState>().searchReleasesFilter = '');
  }

  @override
  Widget build(BuildContext context) {
    return LunaScaffold(
      scaffoldKey: _scaffoldKey,
      body: _body(),
      appBar: _appBar(),
    );
  }

  PreferredSizeWidget _appBar() {
    return LunaAppBar(
      title: 'Releases',
      scrollControllers: [scrollController],
      bottom: LidarrReleasesSearchBar(scrollController: scrollController),
      actions: const [
        DownloadClientButton(),
      ],
    );
  }

  Widget _body() {
    return LunaRefreshIndicator(
      context: context,
      key: _refreshKey,
      onRefresh: loadCallback,
      child: FutureBuilder(
        future: _future,
        builder: (context, AsyncSnapshot<List<LidarrReleaseData>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              {
                if (snapshot.hasError || snapshot.data == null) {
                  return LunaMessage.error(
                      onTap: _refreshKey.currentState!.show);
                }
                _results = snapshot.data;
                return _list();
              }
            case ConnectionState.none:
            case ConnectionState.waiting:
            case ConnectionState.active:
            default:
              return const LunaLoader();
          }
        },
      ),
    );
  }

  Widget _list() {
    if ((_results?.length ?? 0) == 0)
      return LunaMessage(
        text: 'No Releases Found',
        buttonText: 'Refresh',
        onTap: _refreshKey.currentState?.show,
      );
    return Consumer<LidarrState>(
      builder: (context, state, _) {
        List<LidarrReleaseData>? filtered =
            _filterAndSort(_results, state.searchReleasesFilter);
        if ((filtered?.length ?? 0) == 0)
          return LunaListView(
            controller: scrollController,
            children: [
              LunaMessage.inList(text: 'No Releases Found'),
            ],
          );
        return LunaListViewBuilder(
          controller: scrollController,
          itemCount: filtered!.length,
          itemBuilder: (context, index) =>
              LidarrReleasesTile(release: filtered[index]),
        );
      },
    );
  }

  List<LidarrReleaseData>? _filterAndSort(
      List<LidarrReleaseData>? releases, String query) {
    if ((releases?.length ?? 0) == 0) return releases;
    LidarrReleasesSorting sorting =
        context.read<LidarrState>().sortReleasesType;
    bool shouldHide = context.read<LidarrState>().hideRejectedReleases;
    bool ascending = context.read<LidarrState>().sortReleasesAscending;
    // Filter
    List<LidarrReleaseData> filtered = releases!.where((release) {
      if (shouldHide && !release.approved) return false;
      if (query.isNotEmpty)
        return release.title.toLowerCase().contains(query.toLowerCase());
      return true;
    }).toList();
    filtered = sorting.sort(filtered, ascending);
    return filtered;
  }
}
