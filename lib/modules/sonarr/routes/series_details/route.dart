import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrSeriesDetailsRouter extends SonarrPageRouter {
  SonarrSeriesDetailsRouter() : super('/sonarr/series/:seriesid');

  @override
  _Widget widget({
    @required int seriesId,
  }) {
    return _Widget(seriesId: seriesId);
  }

  @override
  Future<void> navigateTo(
    BuildContext context, {
    @required int seriesId,
  }) async {
    LunaRouter.router.navigateTo(context, route(seriesId: seriesId));
  }

  @override
  String route({
    @required int seriesId,
  }) {
    return fullRoute.replaceFirst(
      ':seriesid',
      seriesId.toString(),
    );
  }

  @override
  void defineRoute(FluroRouter router) {
    super.withParameterRouteDefinition(
      router,
      (context, params) {
        int seriesId = (params['seriesid']?.isNotEmpty ?? false)
            ? (int.tryParse(params['seriesid'][0]) ?? -1)
            : -1;
        return _Widget(seriesId: seriesId);
      },
    );
  }
}

class _Widget extends StatefulWidget {
  final int seriesId;

  const _Widget({
    Key key,
    @required this.seriesId,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<_Widget> with LunaLoadCallbackMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  SonarrSeries series;
  PageController _pageController;

  @override
  Future<void> loadCallback() async {
    if (widget.seriesId > 0) {
      SonarrSeries result =
          _findSeries(await context.read<SonarrState>().series);
      setState(() => series = result);
      context.read<SonarrState>().fetchQualityProfiles();
      context.read<SonarrState>().fetchLanguageProfiles();
      context.read<SonarrState>().fetchTags();
      await context.read<SonarrState>().fetchSingleSeries(widget.seriesId);
    }
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: SonarrDatabaseValue.NAVIGATION_INDEX_SERIES_DETAILS.data,
    );
  }

  SonarrSeries _findSeries(List<SonarrSeries> series) {
    return series.firstWhere(
      (s) => s.id == widget.seriesId,
      orElse: () => null,
    );
  }

  List<SonarrTag> _findTags(
    List<int> tagIds,
    List<SonarrTag> tags,
  ) {
    return tags.where((tag) => tagIds.contains(tag.id)).toList();
  }

  SonarrQualityProfile _findQualityProfile(
    int qualityProfileId,
    List<SonarrQualityProfile> profiles,
  ) {
    return profiles.firstWhere(
      (profile) => profile.id == qualityProfileId,
      orElse: () => null,
    );
  }

  SonarrLanguageProfile _findLanguageProfile(
    int languageProfileId,
    List<SonarrLanguageProfile> profiles,
  ) {
    return profiles.firstWhere(
      (profile) => profile.id == languageProfileId,
      orElse: () => null,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.seriesId <= 0)
      return LunaInvalidRoute(
        title: 'sonarr.SeriesDetails'.tr(),
        message: 'sonarr.SeriesNotFound'.tr(),
      );
    return LunaScaffold(
      scaffoldKey: _scaffoldKey,
      appBar: _appBar(),
      bottomNavigationBar:
          context.watch<SonarrState>().enabled ? _bottomNavigationBar() : null,
      body: _body(),
    );
  }

  Widget _appBar() {
    List<Widget> _actions = series == null
        ? null
        : [
            LunaIconButton(
              icon: Icons.edit,
              onPressed: () async => SonarrEditSeriesRouter().navigateTo(
                context,
                seriesId: widget.seriesId,
              ),
            ),
            SonarrAppBarSeriesSettingsAction(seriesId: widget.seriesId),
          ];
    return LunaAppBar(
      title: 'sonarr.SeriesDetails'.tr(),
      scrollControllers: SonarrSeriesDetailsNavigationBar.scrollControllers,
      pageController: _pageController,
      actions: _actions,
    );
  }

  Widget _bottomNavigationBar() {
    if (series == null) return null;
    return SonarrSeriesDetailsNavigationBar(
      pageController: _pageController,
    );
  }

  Widget _body() {
    return Consumer<SonarrState>(
      builder: (context, state, _) => FutureBuilder(
        future: Future.wait([
          state.qualityProfiles,
          state.languageProfiles,
          state.tags,
          state.series,
        ]),
        builder: (context, AsyncSnapshot<List<Object>> snapshot) {
          if (snapshot.hasError) {
            if (snapshot.connectionState != ConnectionState.waiting) {
              LunaLogger().error(
                'Unable to pull Sonarr series details',
                snapshot.error,
                snapshot.stackTrace,
              );
            }
            return LunaMessage.error(onTap: loadCallback);
          }
          if (snapshot.hasData) {
            series = _findSeries(snapshot.data[3]);
            if (series == null) {
              return LunaMessage.goBack(
                text: 'sonarr.SeriesNotFound'.tr(),
                context: context,
              );
            }
            SonarrQualityProfile quality = _findQualityProfile(
              series.qualityProfileId,
              snapshot.data[0],
            );
            SonarrLanguageProfile language = _findLanguageProfile(
              series.languageProfileId,
              snapshot.data[1],
            );
            List<SonarrTag> tags = _findTags(series.tags, snapshot.data[2]);
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
    @required SonarrQualityProfile qualityProfile,
    @required SonarrLanguageProfile languageProfile,
    @required List<SonarrTag> tags,
  }) {
    return ChangeNotifierProvider(
      create: (context) => SonarrSeriesDetailsState(
        context: context,
        series: series,
      ),
      builder: (context, _) => PageView(
        controller: _pageController,
        children: [
          SonarrSeriesDetailsOverview(
            series: series,
            quality: qualityProfile,
            language: languageProfile,
            tags: tags,
          ),
          SonarrSeriesDetailsSeasonList(series: series),
          const SonarrSeriesDetailsHistoryPage(),
        ],
      ),
    );
  }
}
