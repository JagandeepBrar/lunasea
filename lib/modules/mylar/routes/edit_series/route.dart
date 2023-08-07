import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/mylar.dart';
import 'package:lunasea/widgets/pages/invalid_route.dart';

class SeriesEditRoute extends StatefulWidget {
  final int seriesId;

  const SeriesEditRoute({
    Key? key,
    required this.seriesId,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<SeriesEditRoute>
    with LunaLoadCallbackMixin, LunaScrollControllerMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Future<void> loadCallback() async {
    context.read<MylarState>().fetchTags();
    context.read<MylarState>().fetchQualityProfiles();
    context.read<MylarState>().fetchLanguageProfiles();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.seriesId <= 0)
      return InvalidRoutePage(
        title: 'mylar.EditSeries'.tr(),
        message: 'mylar.SeriesNotFound'.tr(),
      );
    return ChangeNotifierProvider(
        create: (_) => MylarSeriesEditState(),
        builder: (context, _) {
          LunaLoadingState state =
              context.select<MylarSeriesEditState, LunaLoadingState>(
                  (state) => state.state);
          return LunaScaffold(
            scaffoldKey: _scaffoldKey,
            appBar: _appBar() as PreferredSizeWidget?,
            body:
                state == LunaLoadingState.ERROR ? _bodyError() : _body(context),
            bottomNavigationBar: state == LunaLoadingState.ERROR
                ? null
                : const MylarEditSeriesActionBar(),
          );
        });
  }

  Widget _appBar() {
    return LunaAppBar(
      scrollControllers: [scrollController],
      title: 'mylar.EditSeries'.tr(),
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
        context.select<MylarState, Future<Map<int?, MylarSeries>>?>(
            (state) => state.series)!,
        context.select<MylarState, Future<List<MylarQualityProfile>>?>(
            (state) => state.qualityProfiles)!,
        context.select<MylarState, Future<List<MylarTag>>?>(
            (state) => state.tags)!,
        context.select<MylarState, Future<List<MylarLanguageProfile>>?>(
            (state) => state.languageProfiles)!,
      ]),
      builder: (context, AsyncSnapshot<List<Object>> snapshot) {
        if (snapshot.hasError) {
          return LunaMessage.error(onTap: loadCallback);
        }
        if (snapshot.hasData) {
          MylarSeries? series = (snapshot.data![0] as Map)[widget.seriesId];
          if (series == null) return const LunaLoader();
          return _list(
            context,
            series: series,
            qualityProfiles: snapshot.data![1] as List<MylarQualityProfile>,
            tags: snapshot.data![2] as List<MylarTag>,
            languageProfiles: snapshot.data![3] as List<MylarLanguageProfile>,
          );
        }
        return const LunaLoader();
      },
    );
  }

  Widget _list(
    BuildContext context, {
    required MylarSeries series,
    required List<MylarQualityProfile> qualityProfiles,
    required List<MylarLanguageProfile> languageProfiles,
    required List<MylarTag> tags,
  }) {
    if (context.read<MylarSeriesEditState>().series == null) {
      context.read<MylarSeriesEditState>().series = series;
      context
          .read<MylarSeriesEditState>()
          .initializeQualityProfile(qualityProfiles);
      context
          .read<MylarSeriesEditState>()
          .initializeLanguageProfile(languageProfiles);
      context.read<MylarSeriesEditState>().initializeTags(tags);
      context.read<MylarSeriesEditState>().canExecuteAction = true;
    }
    return LunaListView(
      controller: scrollController,
      children: [
        const MylarSeriesEditMonitoredTile(),
        const MylarSeriesEditSeasonFoldersTile(),
        MylarSeriesEditQualityProfileTile(profiles: qualityProfiles),
        if (languageProfiles.isNotEmpty)
          MylarSeriesEditLanguageProfileTile(profiles: languageProfiles),
        const MylarSeriesEditSeriesTypeTile(),
        const MylarSeriesEditSeriesPathTile(),
        const MylarSeriesEditTagsTile(),
      ],
    );
  }
}
