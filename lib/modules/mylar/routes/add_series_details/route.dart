import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/mylar.dart';
import 'package:lunasea/widgets/pages/invalid_route.dart';

class AddSeriesDetailsRoute extends StatefulWidget {
  final MylarSeries? series;

  const AddSeriesDetailsRoute({
    Key? key,
    required this.series,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<AddSeriesDetailsRoute>
    with LunaLoadCallbackMixin, LunaScrollControllerMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  Future<void> loadCallback() async {
    context.read<MylarState>().fetchRootFolders();
    context.read<MylarState>().fetchTags();
    context.read<MylarState>().fetchQualityProfiles();
    context.read<MylarState>().fetchLanguageProfiles();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.series == null) {
      return InvalidRoutePage(
        title: 'mylar.AddSeries'.tr(),
        message: 'mylar.NoSeriesFound'.tr(),
      );
    }
    return ChangeNotifierProvider(
      create: (_) => MylarSeriesAddDetailsState(series: widget.series!),
      builder: (context, _) => LunaScaffold(
        scaffoldKey: _scaffoldKey,
        appBar: _appBar() as PreferredSizeWidget?,
        body: _body(context),
        bottomNavigationBar: const MylarAddSeriesDetailsActionBar(),
      ),
    );
  }

  Widget _appBar() {
    return LunaAppBar(
      title: 'mylar.AddSeries'.tr(),
      scrollControllers: [scrollController],
    );
  }

  Widget _body(BuildContext context) {
    return FutureBuilder(
      future: Future.wait(
        [
          context.watch<MylarState>().rootFolders!,
          context.watch<MylarState>().tags!,
          context.watch<MylarState>().qualityProfiles!,
          context.watch<MylarState>().languageProfiles!,
        ],
      ),
      builder: (context, AsyncSnapshot<List<Object>> snapshot) {
        if (snapshot.hasError) {
          if (snapshot.connectionState != ConnectionState.waiting) {
            LunaLogger().error(
              'Unable to fetch Mylar add series data',
              snapshot.error,
              snapshot.stackTrace,
            );
          }
          return LunaMessage.error(onTap: _refreshKey.currentState!.show);
        }
        if (snapshot.hasData) {
          return _content(
            context,
            rootFolders: snapshot.data![0] as List<MylarRootFolder>,
            tags: snapshot.data![1] as List<MylarTag>,
            qualityProfiles: snapshot.data![2] as List<MylarQualityProfile>,
            languageProfiles: snapshot.data![3] as List<MylarLanguageProfile>,
          );
        }
        return const LunaLoader();
      },
    );
  }

  Widget _content(
    BuildContext context, {
    required List<MylarRootFolder> rootFolders,
    required List<MylarQualityProfile> qualityProfiles,
    required List<MylarLanguageProfile> languageProfiles,
    required List<MylarTag> tags,
  }) {
    context.read<MylarSeriesAddDetailsState>().initializeMonitored();
    context.read<MylarSeriesAddDetailsState>().initializeUseSeasonFolders();
    context.read<MylarSeriesAddDetailsState>().initializeSeriesType();
    context.read<MylarSeriesAddDetailsState>().initializeMonitorType();
    context
        .read<MylarSeriesAddDetailsState>()
        .initializeRootFolder(rootFolders);
    context
        .read<MylarSeriesAddDetailsState>()
        .initializeQualityProfile(qualityProfiles);
    context
        .read<MylarSeriesAddDetailsState>()
        .initializeLanguageProfile(languageProfiles);
    context.read<MylarSeriesAddDetailsState>().initializeTags(tags);
    context.read<MylarSeriesAddDetailsState>().canExecuteAction = true;
    return LunaListView(
      controller: scrollController,
      children: [
        MylarSeriesAddSearchResultTile(
          series: context.read<MylarSeriesAddDetailsState>().series,
          onTapShowOverview: true,
          exists: false,
          isExcluded: false,
        ),
        const MylarSeriesAddDetailsRootFolderTile(),
        const MylarSeriesAddDetailsMonitorTile(),
        const MylarSeriesAddDetailsQualityProfileTile(),
        if (languageProfiles.isNotEmpty)
          const MylarSeriesAddDetailsLanguageProfileTile(),
        const MylarSeriesAddDetailsSeriesTypeTile(),
        const MylarSeriesAddDetailsUseSeasonFoldersTile(),
        const MylarSeriesAddDetailsTagsTile(),
      ],
    );
  }
}
