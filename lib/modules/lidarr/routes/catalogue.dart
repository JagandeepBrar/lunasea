import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/lidarr.dart';

class LidarrCatalogue extends StatefulWidget {
  static const ROUTE_NAME = '/lidarr/catalogue';
  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey;
  final Function refreshAllPages;

  const LidarrCatalogue({
    Key? key,
    required this.refreshIndicatorKey,
    required this.refreshAllPages,
  }) : super(key: key);

  @override
  State<LidarrCatalogue> createState() => _State();
}

class _State extends State<LidarrCatalogue>
    with AutomaticKeepAliveClientMixin, LunaLoadCallbackMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Future<List<LidarrCatalogueData>>? _future;
  List<LidarrCatalogueData>? _results = [];

  @override
  bool get wantKeepAlive => true;

  @override
  Future<void> loadCallback() async {
    if (mounted) setState(() => _results = []);
    final _api = LidarrAPI.from(LunaProfile.current);
    if (mounted) {
      setState(() {
        _future = _api.getAllArtists();
      });
    }
  }

  void _refreshState() => setState(() {});

  void _refreshAllPages() => widget.refreshAllPages();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return LunaScaffold(
      scaffoldKey: _scaffoldKey,
      body: _body(),
      appBar: _appBar() as PreferredSizeWidget?,
    );
  }

  Widget _appBar() {
    return LunaAppBar.empty(
      child: LidarrCatalogueSearchBar(
        scrollController: LidarrNavigationBar.scrollControllers[0],
      ),
      height: LunaTextInputBar.defaultAppBarHeight,
    );
  }

  Widget _body() {
    return LunaRefreshIndicator(
      context: context,
      key: widget.refreshIndicatorKey,
      onRefresh: loadCallback,
      child: FutureBuilder(
        future: _future,
        builder: (context, AsyncSnapshot<List<LidarrCatalogueData>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              {
                if (snapshot.hasError || snapshot.data == null) {
                  return LunaMessage.error(
                      onTap: () =>
                          widget.refreshIndicatorKey.currentState?.show);
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
        text: 'No Artists Found',
        buttonText: 'Refresh',
        onTap: widget.refreshIndicatorKey.currentState?.show,
      );
    return Consumer<LidarrState>(
      builder: (context, state, _) {
        List<LidarrCatalogueData>? filtered =
            _filterAndSort(_results, state.searchCatalogueFilter);
        if ((filtered?.length ?? 0) == 0)
          return LunaListView(
            controller: LidarrNavigationBar.scrollControllers[0],
            children: [
              LunaMessage.inList(text: 'No Artists Found'),
            ],
          );
        return LunaListViewBuilder(
          controller: LidarrNavigationBar.scrollControllers[0],
          itemCount: filtered!.length,
          itemExtent: LunaBlock.calculateItemExtent(2),
          itemBuilder: (context, index) => LidarrCatalogueTile(
            data: filtered[index],
            scaffoldKey: _scaffoldKey,
            refresh: _refreshAllPages,
            refreshState: _refreshState,
          ),
        );
      },
    );
  }

  List<LidarrCatalogueData>? _filterAndSort(
      List<LidarrCatalogueData>? artists, String query) {
    if ((artists?.length ?? 0) == 0) return artists;
    LidarrCatalogueSorting sorting =
        context.read<LidarrState>().sortCatalogueType;
    bool shouldHide = context.read<LidarrState>().hideUnmonitoredArtists;
    bool ascending = context.read<LidarrState>().sortCatalogueAscending;
    // Filter
    List<LidarrCatalogueData> filtered = artists!.where((artist) {
      if (shouldHide && !artist.monitored!) return false;
      if (query.isNotEmpty)
        return artist.title.toLowerCase().contains(query.toLowerCase());
      return true;
    }).toList();
    filtered = sorting.sort(filtered, ascending);
    return filtered;
  }
}
