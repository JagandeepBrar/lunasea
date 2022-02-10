import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/readarr.dart';

class _Args {
  final ReadarrAuthor series;

  _Args({
    required this.series,
  });
}

class ReadarrAddSeriesDetailsRouter extends ReadarrPageRouter {
  ReadarrAddSeriesDetailsRouter() : super('/readarr/addseries/details');

  @override
  _Widget widget() => _Widget();

  @override
  Future<void> navigateTo(
    BuildContext context, [
    ReadarrAuthor? series,
  ]) {
    assert(series != null);
    return LunaRouter.router.navigateTo(
      context,
      route(),
      routeSettings: RouteSettings(
        arguments: _Args(
          series: series!,
        ),
      ),
    );
  }

  @override
  void defineRoute(FluroRouter router) {
    super.noParameterRouteDefinition(router);
  }
}

class _Widget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<_Widget>
    with LunaLoadCallbackMixin, LunaScrollControllerMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  Future<void> loadCallback() async {
    context.read<ReadarrState>().fetchRootFolders();
    context.read<ReadarrState>().fetchTags();
    context.read<ReadarrState>().fetchQualityProfiles();
    context.read<ReadarrState>().fetchMetadataProfiles();
  }

  @override
  Widget build(BuildContext context) {
    _Args? arguments = ModalRoute.of(context)!.settings.arguments as _Args?;
    if (arguments == null) {
      return LunaInvalidRoute(
        title: 'readarr.AddAuthor'.tr(),
        message: 'readarr.NoSeriesFound'.tr(),
      );
    }
    return ChangeNotifierProvider(
      create: (_) => ReadarrAuthorAddDetailsState(
        series: arguments.series,
      ),
      builder: (context, _) => LunaScaffold(
        scaffoldKey: _scaffoldKey,
        appBar: _appBar() as PreferredSizeWidget?,
        body: _body(context),
        bottomNavigationBar: const ReadarrAddSeriesDetailsActionBar(),
      ),
    );
  }

  Widget _appBar() {
    return LunaAppBar(
      title: 'readarr.AddAuthor'.tr(),
      scrollControllers: [scrollController],
    );
  }

  Widget _body(BuildContext context) {
    return FutureBuilder(
      future: Future.wait(
        [
          context.watch<ReadarrState>().rootFolders!,
          context.watch<ReadarrState>().tags!,
          context.watch<ReadarrState>().qualityProfiles!,
          context.watch<ReadarrState>().metadataProfiles!,
        ],
      ),
      builder: (context, AsyncSnapshot<List<Object>> snapshot) {
        if (snapshot.hasError) {
          if (snapshot.connectionState != ConnectionState.waiting) {
            LunaLogger().error(
              'Unable to fetch Readarr add series data',
              snapshot.error,
              snapshot.stackTrace,
            );
          }
          return LunaMessage.error(onTap: _refreshKey.currentState!.show);
        }
        if (snapshot.hasData) {
          return _content(
            context,
            rootFolders: snapshot.data![0] as List<ReadarrRootFolder>,
            tags: snapshot.data![1] as List<ReadarrTag>,
            qualityProfiles: snapshot.data![2] as List<ReadarrQualityProfile>,
            metadataProfiles: snapshot.data![3] as List<ReadarrMetadataProfile>,
          );
        }
        return const LunaLoader();
      },
    );
  }

  Widget _content(
    BuildContext context, {
    required List<ReadarrRootFolder> rootFolders,
    required List<ReadarrQualityProfile> qualityProfiles,
    required List<ReadarrMetadataProfile> metadataProfiles,
    required List<ReadarrTag> tags,
  }) {
    context.read<ReadarrAuthorAddDetailsState>().initializeMonitored();
    context.read<ReadarrAuthorAddDetailsState>().initializeMonitorType();
    context
        .read<ReadarrAuthorAddDetailsState>()
        .initializeRootFolder(rootFolders);
    context
        .read<ReadarrAuthorAddDetailsState>()
        .initializeQualityProfile(qualityProfiles);
    context
        .read<ReadarrAuthorAddDetailsState>()
        .initializeMetadataProfile(metadataProfiles);
    context.read<ReadarrAuthorAddDetailsState>().initializeTags(tags);
    context.read<ReadarrAuthorAddDetailsState>().canExecuteAction = true;
    return LunaListView(
      controller: scrollController,
      children: [
        ReadarrAuthorAddSearchResultTile(
          series: context.read<ReadarrAuthorAddDetailsState>().series,
          onTapShowOverview: true,
          exists: false,
          isExcluded: false,
        ),
        const ReadarrAuthorAddDetailsRootFolderTile(),
        const ReadarrAuthorAddDetailsMonitorTile(),
        const ReadarrAuthorAddDetailsQualityProfileTile(),
        const ReadarrAuthorAddDetailsMetadataProfileTile(),
        const ReadarrAuthorAddDetailsTagsTile(),
      ],
    );
  }
}
