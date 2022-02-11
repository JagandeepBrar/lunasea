import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/readarr.dart';

class ReadarrEditAuthorRouter extends ReadarrPageRouter {
  ReadarrEditAuthorRouter() : super('/readarr/editmovie/:seriesid');

  @override
  _Widget widget([int authorId = -1]) => _Widget(authorId: authorId);

  @override
  Future<void> navigateTo(
    BuildContext context, [
    int authorId = -1,
  ]) async =>
      LunaRouter.router.navigateTo(context, route(authorId));

  @override
  String route([int authorId = -1]) => fullRoute.replaceFirst(
        ':seriesid',
        authorId.toString(),
      );

  @override
  void defineRoute(
    FluroRouter router,
  ) {
    super.withParameterRouteDefinition(
      router,
      (context, params) {
        int authorId = (params['seriesid']?.isNotEmpty ?? false)
            ? (int.tryParse(params['seriesid']![0]) ?? -1)
            : -1;
        return _Widget(authorId: authorId);
      },
    );
  }
}

class _Widget extends StatefulWidget {
  final int authorId;

  const _Widget({
    Key? key,
    required this.authorId,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<_Widget>
    with LunaLoadCallbackMixin, LunaScrollControllerMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Future<void> loadCallback() async {
    context.read<ReadarrState>().fetchTags();
    context.read<ReadarrState>().fetchQualityProfiles();
    context.read<ReadarrState>().fetchMetadataProfiles();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.authorId <= 0)
      return LunaInvalidRoute(
        title: 'readarr.EditAuhtor'.tr(),
        message: 'readarr.AuthorNotFound'.tr(),
      );
    return ChangeNotifierProvider(
        create: (_) => ReadarrAuthorEditState(),
        builder: (context, _) {
          LunaLoadingState state =
              context.select<ReadarrAuthorEditState, LunaLoadingState>(
                  (state) => state.state);
          return LunaScaffold(
            scaffoldKey: _scaffoldKey,
            appBar: _appBar() as PreferredSizeWidget?,
            body:
                state == LunaLoadingState.ERROR ? _bodyError() : _body(context),
            bottomNavigationBar: state == LunaLoadingState.ERROR
                ? null
                : const ReadarrEditSeriesActionBar(),
          );
        });
  }

  Widget _appBar() {
    return LunaAppBar(
      scrollControllers: [scrollController],
      title: 'readarr.EditAuthor'.tr(),
    );
  }

  Widget _bodyError() {
    return LunaMessage.goBack(
      context: context,
      text: 'lunasea.AnErrorHasOccurred'.tr(),
    );
  }

  Widget _body(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([
        context.select<ReadarrState, Future<Map<int?, ReadarrAuthor>>?>(
            (state) => state.authors)!,
        context.select<ReadarrState, Future<List<ReadarrQualityProfile>>?>(
            (state) => state.qualityProfiles)!,
        context.select<ReadarrState, Future<List<ReadarrTag>>?>(
            (state) => state.tags)!,
        context.select<ReadarrState, Future<List<ReadarrMetadataProfile>>?>(
            (state) => state.metadataProfiles)!,
      ]),
      builder: (context, AsyncSnapshot<List<Object>> snapshot) {
        if (snapshot.hasError) {
          return LunaMessage.error(onTap: loadCallback);
        }
        if (snapshot.hasData) {
          ReadarrAuthor? series = (snapshot.data![0] as Map)[widget.authorId];
          if (series == null) return const LunaLoader();
          return _list(
            context,
            series: series,
            qualityProfiles: snapshot.data![1] as List<ReadarrQualityProfile>,
            tags: snapshot.data![2] as List<ReadarrTag>,
            metadataProfiles: snapshot.data![3] as List<ReadarrMetadataProfile>,
          );
        }
        return const LunaLoader();
      },
    );
  }

  Widget _list(
    BuildContext context, {
    required ReadarrAuthor series,
    required List<ReadarrQualityProfile> qualityProfiles,
    required List<ReadarrMetadataProfile> metadataProfiles,
    required List<ReadarrTag> tags,
  }) {
    if (context.read<ReadarrAuthorEditState>().series == null) {
      context.read<ReadarrAuthorEditState>().series = series;
      context
          .read<ReadarrAuthorEditState>()
          .initializeQualityProfile(qualityProfiles);
      context
          .read<ReadarrAuthorEditState>()
          .initializeMetadataProfile(metadataProfiles);
      context.read<ReadarrAuthorEditState>().initializeTags(tags);
      context.read<ReadarrAuthorEditState>().canExecuteAction = true;
    }
    return LunaListView(
      controller: scrollController,
      children: [
        const ReadarrAuthorEditMonitoredTile(),
        ReadarrAuthorEditQualityProfileTile(profiles: qualityProfiles),
        ReadarrAuthorEditMetadataProfileTile(profiles: metadataProfiles),
        const ReadarrAuthorEditSeriesPathTile(),
        const ReadarrAuthorEditTagsTile(),
      ],
    );
  }
}
