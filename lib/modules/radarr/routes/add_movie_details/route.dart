import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';
import 'package:lunasea/widgets/pages/invalid_route.dart';

class AddMovieDetailsRoute extends StatefulWidget {
  final RadarrMovie? movie;
  final bool isDiscovery;

  const AddMovieDetailsRoute({
    Key? key,
    required this.movie,
    required this.isDiscovery,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<AddMovieDetailsRoute>
    with LunaLoadCallbackMixin, LunaScrollControllerMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  Future<void> loadCallback() async {
    context.read<RadarrState>().fetchQualityProfiles();
    context.read<RadarrState>().fetchRootFolders();
    context.read<RadarrState>().fetchTags();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.movie == null) {
      return InvalidRoutePage(
        title: 'radarr.AddMovie'.tr(),
        message: 'radarr.MovieNotFound'.tr(),
      );
    }
    return ChangeNotifierProvider(
      create: (_) => RadarrAddMovieDetailsState(
        movie: widget.movie!,
        isDiscovery: widget.isDiscovery,
      ),
      builder: (context, _) => LunaScaffold(
        scaffoldKey: _scaffoldKey,
        appBar: _appBar(),
        body: _body(),
        bottomNavigationBar: const RadarrAddMovieDetailsActionBar(),
      ),
    );
  }

  PreferredSizeWidget _appBar() {
    return LunaAppBar(
      title: 'radarr.AddMovie'.tr(),
      scrollControllers: [scrollController],
    );
  }

  Widget _body() {
    return FutureBuilder(
      future: Future.wait(
        [
          context.watch<RadarrState>().rootFolders!,
          context.watch<RadarrState>().qualityProfiles!,
          context.watch<RadarrState>().tags!,
        ],
      ),
      builder: (context, AsyncSnapshot<List<Object>> snapshot) {
        if (snapshot.hasError) {
          if (snapshot.connectionState != ConnectionState.waiting) {
            LunaLogger().error(
              'Unable to fetch Radarr add movie data',
              snapshot.error,
              snapshot.stackTrace,
            );
          }
          return LunaMessage.error(onTap: _refreshKey.currentState!.show);
        }
        if (snapshot.hasData) {
          return _content(
            context,
            rootFolders: snapshot.data![0] as List<RadarrRootFolder>?,
            qualityProfiles: snapshot.data![1] as List<RadarrQualityProfile>?,
            tags: snapshot.data![2] as List<RadarrTag>?,
          );
        }
        return const LunaLoader();
      },
    );
  }

  Widget _content(
    BuildContext context, {
    List<RadarrRootFolder>? rootFolders,
    List<RadarrQualityProfile>? qualityProfiles,
    List<RadarrTag>? tags,
  }) {
    context.read<RadarrAddMovieDetailsState>().initializeAvailability();
    context
        .read<RadarrAddMovieDetailsState>()
        .initializeQualityProfile(qualityProfiles);
    context
        .read<RadarrAddMovieDetailsState>()
        .initializeRootFolder(rootFolders);
    context.read<RadarrAddMovieDetailsState>().initializeTags(tags);
    context.read<RadarrAddMovieDetailsState>().canExecuteAction = true;
    return LunaRefreshIndicator(
      context: context,
      key: _refreshKey,
      onRefresh: loadCallback,
      child: LunaListView(
        controller: scrollController,
        children: [
          RadarrAddMovieSearchResultTile(
            movie: context.read<RadarrAddMovieDetailsState>().movie,
            onTapShowOverview: true,
            exists: false,
            isExcluded: false,
          ),
          const RadarrAddMovieDetailsRootFolderTile(),
          const RadarrAddMovieDetailsMonitoredTile(),
          const RadarrAddMovieDetailsMinimumAvailabilityTile(),
          const RadarrAddMovieDetailsQualityProfileTile(),
          const RadarrAddMovieDetailsTagsTile(),
        ],
      ),
    );
  }
}
