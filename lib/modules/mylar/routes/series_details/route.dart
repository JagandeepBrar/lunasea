import 'package:collection/collection.dart' show IterableExtension;
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/mylar.dart';
import 'package:lunasea/modules/mylar/routes/series_details/sheets/links.dart';
import 'package:lunasea/router/routes/mylar.dart';
import 'package:lunasea/widgets/pages/invalid_route.dart';

class SeriesDetailsRoute extends StatefulWidget {
  final int seriesId;

  const SeriesDetailsRoute({
    Key? key,
    required this.seriesId,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<SeriesDetailsRoute> with LunaLoadCallbackMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  MylarSeries? series;
  PageController? _pageController;

  @override
  Future<void> loadCallback() async {
    if (widget.seriesId > 0) {
      MylarSeries? result =
          (await context.read<MylarState>().series)![widget.seriesId];
      setState(() => series = result);
      context.read<MylarState>().fetchQualityProfiles();
      context.read<MylarState>().fetchLanguageProfiles();
      context.read<MylarState>().fetchTags();
      await context.read<MylarState>().fetchSeries(widget.seriesId);
    }
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: MylarDatabase.NAVIGATION_INDEX_SERIES_DETAILS.read(),
    );
  }

  List<MylarTag> _findTags(
    List<int>? tagIds,
    List<MylarTag> tags,
  ) {
    return tags.where((tag) => tagIds!.contains(tag.id)).toList();
  }

  MylarQualityProfile? _findQualityProfile(
    int? qualityProfileId,
    List<MylarQualityProfile> profiles,
  ) {
    return profiles.firstWhereOrNull(
      (profile) => profile.id == qualityProfileId,
    );
  }

  MylarLanguageProfile? _findLanguageProfile(
    int? languageProfileId,
    List<MylarLanguageProfile> profiles,
  ) {
    return profiles.firstWhereOrNull(
      (profile) => profile.id == languageProfileId,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.seriesId <= 0) {
      return InvalidRoutePage(
        title: 'mylar.SeriesDetails'.tr(),
        message: 'mylar.SeriesNotFound'.tr(),
      );
    }
    return LunaScaffold(
      scaffoldKey: _scaffoldKey,
      module: LunaModule.SONARR,
      appBar: _appBar() as PreferredSizeWidget?,
      bottomNavigationBar:
          context.watch<MylarState>().enabled ? _bottomNavigationBar() : null,
      body: _body(),
    );
  }

  Widget _appBar() {
    List<Widget>? _actions;

    if (series != null) {
      _actions = [
        LunaIconButton(
          icon: LunaIcons.LINK,
          onPressed: () => LinksSheet(series: series!).show(),
        ),
        LunaIconButton(
          icon: LunaIcons.EDIT,
          onPressed: () {
            MylarRoutes.SERIES_EDIT.go(
              params: {'series': widget.seriesId.toString()},
            );
          },
        ),
        MylarAppBarSeriesSettingsAction(seriesId: widget.seriesId),
      ];
    }
    return LunaAppBar(
      title: 'mylar.SeriesDetails'.tr(),
      scrollControllers: MylarSeriesDetailsNavigationBar.scrollControllers,
      pageController: _pageController,
      actions: _actions,
    );
  }

  Widget? _bottomNavigationBar() {
    if (series == null) return null;
    return MylarSeriesDetailsNavigationBar(
      pageController: _pageController,
    );
  }

  Widget _body() {
    return Consumer<MylarState>(
      builder: (context, state, _) => FutureBuilder(
        future: Future.wait([
          state.qualityProfiles!,
          state.languageProfiles!,
          state.tags!,
          state.series!,
        ]),
        builder: (context, AsyncSnapshot<List<Object>> snapshot) {
          if (snapshot.hasError) {
            if (snapshot.connectionState != ConnectionState.waiting) {
              LunaLogger().error(
                'Unable to pull Mylar series details',
                snapshot.error,
                snapshot.stackTrace,
              );
            }
            return LunaMessage.error(onTap: loadCallback);
          }
          if (snapshot.hasData) {
            series =
                (snapshot.data![3] as Map<int, MylarSeries>)[widget.seriesId];
            if (series == null) {
              return LunaMessage.goBack(
                text: 'mylar.SeriesNotFound'.tr(),
                context: context,
              );
            }
            MylarQualityProfile? quality = _findQualityProfile(
              series!.qualityProfileId,
              snapshot.data![0] as List<MylarQualityProfile>,
            );
            MylarLanguageProfile? language = _findLanguageProfile(
              series!.languageProfileId,
              snapshot.data![1] as List<MylarLanguageProfile>,
            );
            List<MylarTag> tags =
                _findTags(series!.tags, snapshot.data![2] as List<MylarTag>);
            return _pages(
              qualityProfile: quality,
              languageProfile: language,
              tags: tags,
            );
          }
          return const LunaLoader();
        },
      ),
    );
  }

  Widget _pages({
    required MylarQualityProfile? qualityProfile,
    required MylarLanguageProfile? languageProfile,
    required List<MylarTag> tags,
  }) {
    return ChangeNotifierProvider(
      create: (context) => MylarSeriesDetailsState(
        context: context,
        series: series!,
      ),
      builder: (context, _) => LunaPageView(
        controller: _pageController,
        children: [
          MylarSeriesDetailsOverviewPage(
            series: series!,
            qualityProfile: qualityProfile,
            languageProfile: languageProfile,
            tags: tags,
          ),
          MylarSeriesDetailsSeasonsPage(series: series),
          const MylarSeriesDetailsHistoryPage(),
        ],
      ),
    );
  }
}
