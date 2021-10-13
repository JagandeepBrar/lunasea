import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';
import 'package:tuple/tuple.dart';

class SonarrSeriesDetailsRouter extends SonarrPageRouter {
  SonarrSeriesDetailsRouter() : super('/sonarr/series/details/:seriesid');

  @override
  _Widget widget({
    @required int seriesId,
  }) =>
      _Widget(seriesId: seriesId);

  @override
  Future<void> navigateTo(
    BuildContext context, {
    @required int seriesId,
  }) async =>
      LunaRouter.router.navigateTo(context, route(seriesId: seriesId));

  @override
  String route({
    @required int seriesId,
  }) =>
      fullRoute.replaceFirst(':seriesid', seriesId.toString());

  @override
  void defineRoute(FluroRouter router) => super.withParameterRouteDefinition(
        router,
        (context, params) {
          int seriesId = (params['seriesid']?.isNotEmpty ?? false)
              ? (int.tryParse(params['seriesid'][0]) ?? -1)
              : -1;
          return _Widget(seriesId: seriesId);
        },
      );
}

class _Widget extends StatefulWidget {
  final int seriesId;

  _Widget({
    Key key,
    @required this.seriesId,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<_Widget> with LunaLoadCallbackMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  PageController _pageController;
  SonarrSeries series;
  bool _loaded = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
        initialPage: SonarrDatabaseValue.NAVIGATION_INDEX_SERIES_DETAILS.data);
  }

  @override
  Future<void> loadCallback() async {
    if (widget.seriesId > 0) {
      _findSeries(await context.read<SonarrState>().series);
      await context.read<SonarrState>().resetSingleSeries(widget.seriesId);
      _findSeries(await context.read<SonarrState>().series);
    }
  }

  void _findSeries(List<SonarrSeries> seriesList) {
    SonarrSeries _series = seriesList.firstWhere(
      (series) => series.id == widget.seriesId,
      orElse: () => null,
    );
    if (mounted)
      setState(() {
        series = _series;
        _loaded = true;
      });
  }

  List<SonarrTag> _findTags(List<int> tagIds, List<SonarrTag> tags) {
    return tags.where((tag) => tagIds.contains(tag.id)).toList();
  }

  SonarrQualityProfile _findQualityProfile(
      int profileId, List<SonarrQualityProfile> profiles) {
    return profiles.firstWhere(
      (profile) => profile.id == profileId,
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
          title: 'Series Details', message: 'Series Not Found');
    return LunaScaffold(
      scaffoldKey: _scaffoldKey,
      appBar: _appBar,
      bottomNavigationBar:
          context.watch<SonarrState>().enabled ? _bottomNavigationBar : null,
      body: _body,
    );
  }

  Widget get _appBar => LunaAppBar(
        title: 'Series Details',
        scrollControllers: SonarrSeriesDetailsNavigationBar.scrollControllers,
        pageController: _pageController,
        actions: [
          SonarrAppBarSeriesEditAction(seriesId: widget.seriesId),
          SonarrAppBarSeriesSettingsAction(seriesId: widget.seriesId),
        ],
      );

  Widget get _bottomNavigationBar =>
      SonarrSeriesDetailsNavigationBar(pageController: _pageController);

  Widget get _body => Selector<
          SonarrState,
          Tuple4<
              Future<List<SonarrSeries>>,
              Future<List<SonarrTag>>,
              Future<List<SonarrQualityProfile>>,
              Future<List<SonarrLanguageProfile>>>>(
        selector: (_, state) => Tuple4(
          state.series,
          state.tags,
          state.qualityProfiles,
          state.languageProfiles,
        ),
        builder: (context, tuple, _) => FutureBuilder(
          future: Future.wait([
            tuple.item1,
            tuple.item2,
            tuple.item3,
            tuple.item4,
          ]),
          builder: (context, AsyncSnapshot<List<Object>> snapshot) {
            if (_loaded && series == null)
              return LunaMessage.goBack(
                text: 'Series Not Found',
                context: context,
              );
            if (snapshot.hasError) {
              if (snapshot.connectionState != ConnectionState.waiting) {
                LunaLogger().error('Unable to pull Sonarr series details',
                    snapshot.error, snapshot.stackTrace);
              }
              return LunaMessage.error(onTap: loadCallback);
            }
            if (snapshot.hasData) {
              if (series == null) return LunaLoader();
              SonarrQualityProfile quality = _findQualityProfile(
                series.profileId,
                snapshot.data[2],
              );
              SonarrLanguageProfile language = _findLanguageProfile(
                series.languageProfileId,
                snapshot.data[3],
              );
              List<SonarrTag> tags = _findTags(series.tags, snapshot.data[1]);
              if (series == null) return _unknown();
              return PageView(
                controller: _pageController,
                children: _tabs(
                  series: series,
                  quality: quality,
                  language: language,
                  tags: tags,
                ),
              );
            }
            return LunaLoader();
          },
        ),
      );

  List<Widget> _tabs({
    @required SonarrSeries series,
    @required SonarrQualityProfile quality,
    @required SonarrLanguageProfile language,
    @required List<SonarrTag> tags,
  }) =>
      [
        SonarrSeriesDetailsOverview(
            series: series, quality: quality, language: language, tags: tags),
        SonarrSeriesDetailsSeasonList(series: series),
      ];

  Widget _unknown() {
    return LunaMessage(text: 'Series Not Found');
  }
}
