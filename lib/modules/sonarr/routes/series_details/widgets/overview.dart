import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrSeriesDetailsOverview extends StatelessWidget {
  final SonarrSeries series;
  final SonarrQualityProfile quality;
  final SonarrLanguageProfile language;
  final List<SonarrTag> tags;

  final double _height = 105.0;
  final double _width = 70.0;
  final double _padding = 8.0;

  SonarrSeriesDetailsOverview({
    Key key,
    @required this.series,
    @required this.quality,
    @required this.language,
    @required this.tags,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LunaListView(
      controller: SonarrSeriesDetailsNavigationBar.scrollControllers[0],
      children: [
        _description(context),
        _links(context),
        _information(context),
      ],
    );
  }

  Widget _information(BuildContext context) {
    return LunaTableCard(
      content: [
        LunaTableContent(
          title: 'path',
          body: series.path ?? 'Unknown',
        ),
        LunaTableContent(
          title: 'size',
          body: series.statistics?.sizeOnDisk?.lunaBytesToString(decimals: 1) ??
              'Unknown',
        ),
        LunaTableContent(
          title: 'type',
          body: series.seriesType?.value?.lunaCapitalizeFirstLetters() ??
              'Unknown',
        ),
        LunaTableContent(
          title: 'quality',
          body: quality?.name ?? 'Unknown',
        ),
        LunaTableContent(
          title: 'language',
          body: language?.name ?? LunaUI.TEXT_EMDASH,
        ),
        LunaTableContent(
          title: 'tags',
          body: (tags?.isNotEmpty ?? false)
              ? tags
                  .fold<String>('', (string, tag) => string += ', ${tag.label}')
                  .substring(2)
              : LunaUI.TEXT_EMDASH,
        ),
        LunaTableContent(title: '', body: ''),
        LunaTableContent(
          title: 'status',
          body: series.status?.lunaCapitalizeFirstLetters() ?? 'Unknown',
        ),
        LunaTableContent(
          title: 'runtime',
          body: series.lunaRuntime,
        ),
        LunaTableContent(
          title: 'network',
          body: series.network ?? 'Unknown',
        ),
        if (series.nextAiring != null)
          LunaTableContent(
            title: 'next airing',
            body: series.lunaNextAiring,
          ),
        if (series.nextAiring != null)
          LunaTableContent(
            title: 'air time',
            body: series.lunaAirTime,
          ),
      ],
    );
  }

  Widget _description(BuildContext context) {
    return LunaCard(
      context: context,
      child: InkWell(
        child: Row(
          children: [
            LunaNetworkImage(
              url: Provider.of<SonarrState>(context, listen: false)
                  .getPosterURL(series.id),
              headers: Provider.of<SonarrState>(context, listen: false)
                  .headers
                  .cast<String, String>(),
              placeholderAsset: LunaAssets.blankVideo,
              height: _height,
              width: _width,
            ),
            Expanded(
              child: Padding(
                child: Container(
                  child: Column(
                    children: [
                      LunaText.title(text: series.title, maxLines: 1),
                      Text(
                        series.overview == null || series.overview.isEmpty
                            ? 'No summary is available.\n\n\n'
                            : series.overview,
                        maxLines: 4,
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: LunaUI.FONT_SIZE_SUBTITLE,
                        ),
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                  ),
                  height: (_height - (_padding * 2)),
                ),
                padding: EdgeInsets.all(_padding),
              ),
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
        borderRadius: BorderRadius.circular(LunaUI.BORDER_RADIUS),
        onTap: () async =>
            LunaDialogs().textPreview(context, series.title, series.overview),
      ),
      decoration: LunaCardDecoration(
        uri: Provider.of<SonarrState>(context, listen: false)
            .getFanartURL(series.id),
        headers: Provider.of<SonarrState>(context, listen: false).headers,
      ),
    );
  }

  Widget _links(BuildContext context) {
    return LunaButtonContainer(
      children: [
        if (series.imdbId != '')
          LunaCard(
            context: context,
            child: InkWell(
              child: Padding(
                child: Image.asset(LunaAssets.serviceImdb),
                padding: EdgeInsets.all(12.0),
              ),
              borderRadius: BorderRadius.circular(LunaUI.BORDER_RADIUS),
              onTap: () async => await series?.imdbId?.lunaOpenIMDB(),
            ),
            height: 50.0,
            margin: EdgeInsets.symmetric(horizontal: 6.0, vertical: 6.0),
          ),
        if (series.tvdbId != 0)
          LunaCard(
            context: context,
            child: InkWell(
              child: Padding(
                child: Image.asset(LunaAssets.serviceTrakt),
                padding: EdgeInsets.all(12.0),
              ),
              borderRadius: BorderRadius.circular(LunaUI.BORDER_RADIUS),
              onTap: () async =>
                  await series?.tvdbId?.toString()?.lunaOpenTraktSeries(),
            ),
            height: 50.0,
            margin: EdgeInsets.symmetric(horizontal: 6.0, vertical: 6.0),
          ),
        if (series.tvdbId != 0)
          LunaCard(
            context: context,
            child: InkWell(
              child: Padding(
                child: Image.asset(LunaAssets.serviceThetvdb),
                padding: EdgeInsets.all(12.0),
              ),
              borderRadius: BorderRadius.circular(LunaUI.BORDER_RADIUS),
              onTap: () async =>
                  await series?.tvdbId?.toString()?.lunaOpenTheTVDB(),
            ),
            height: 50.0,
            margin: EdgeInsets.symmetric(horizontal: 6.0, vertical: 6.0),
          ),
        if (series.tvMazeId != 0)
          LunaCard(
            context: context,
            child: InkWell(
              child: Padding(
                child: Image.asset(LunaAssets.serviceTvmaze),
                padding: EdgeInsets.all(12.0),
              ),
              borderRadius: BorderRadius.circular(LunaUI.BORDER_RADIUS),
              onTap: () async =>
                  await series?.tvMazeId?.toString()?.lunaOpenTVMaze(),
            ),
            height: 50.0,
            margin: EdgeInsets.symmetric(horizontal: 6.0, vertical: 6.0),
          ),
      ],
    );
  }
}
