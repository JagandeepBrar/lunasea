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
    Widget build(BuildContext context) => LSListView(
        children: [
            _description(context),
            _information(context),
            _links,
        ],
    );

    Widget _information(BuildContext context) => LSTableBlock(
        children: [
            LSTableContent(title: 'path', body: series.path ?? 'Unknown'),
            LSTableContent(title: 'size', body: series.sizeOnDisk?.lunaBytesToString(decimals: 1) ?? 'Unknown'),
            LSTableContent(title: 'type', body: series.seriesType?.value?.lunaCapitalizeFirstLetters() ?? 'Unknown'),
            LSTableContent(title: 'quality', body: quality?.name ?? 'Unknown'),
            if(Provider.of<SonarrState>(context, listen: false).enableVersion3) LSTableContent(title: 'language', body: language?.name ?? Constants.TEXT_EMDASH),
            if(tags != null && tags.length > 0) LSTableContent(
                title: 'tags',
                body: tags.fold<String>('', (string, tag) => string += ', ${tag.label}').substring(2),
            ),
            LSTableContent(title: '', body: ''),
            LSTableContent(title: 'status', body: series.status?.lunaCapitalizeFirstLetters() ?? 'Unknown'),
            LSTableContent(title: 'runtime', body: series.lunaRuntime),
            LSTableContent(title: 'network', body: series.network ?? 'Unknown'),
            if(series.nextAiring != null) LSTableContent(title: 'next airing', body: series.lunaNextAiring),
            if(series.nextAiring != null) LSTableContent(title: 'air time', body: series.lunaAirTime),
        ],
    );

    Widget _description(BuildContext context) => LSCard(
        child: InkWell(
            child: Row(
                children: [
                    LSNetworkImage(
                        url: Provider.of<SonarrState>(context, listen: false).getPosterURL(series.id),
                        headers: Provider.of<SonarrState>(context, listen: false).headers.cast<String, String>(),
                        placeholder: 'assets/images/sonarr/noseriesposter.png',
                        height: _height,
                        width: _width,
                    ),
                    Expanded(
                        child: Padding(
                            child: Container(
                                child: Column(
                                    children: [
                                        LSTitle(text: series.title, maxLines: 1),
                                        Text(
                                            series.overview,
                                            maxLines: 4,
                                            overflow: TextOverflow.fade,
                                            style: TextStyle(
                                                color: Colors.white70,
                                                fontSize: Constants.UI_FONT_SIZE_SUBTITLE,
                                            ),
                                        ),
                                    ],
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                ),
                                height: (_height-(_padding*2)),
                            ),
                            padding: EdgeInsets.all(_padding),
                        ),
                    ),
                ],
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
            ),
            borderRadius: BorderRadius.circular(Constants.UI_BORDER_RADIUS),
            onTap: () async => LunaDialogs().textPreview(context, series.title, series.overview),
        ),
        decoration: LunaCardDecoration(
            uri: Provider.of<SonarrState>(context, listen: false).getFanartURL(series.id),
            headers: Provider.of<SonarrState>(context, listen: false).headers,
        ),
    );

    Widget get _links => LSContainerRow(
        children: [
            if(series.imdbId != '') Expanded(
                child: LSCard(
                    child: InkWell(
                        child: Padding(
                            child: Image.asset(
                                'assets/images/services/imdb.png',
                                height: 21.0,
                            ),
                            padding: EdgeInsets.all(18.0),
                        ),
                        borderRadius: BorderRadius.circular(Constants.UI_BORDER_RADIUS),
                        onTap: () async => await series?.imdbId?.lunaOpenIMDB(),
                    ),
                    reducedMargin: true,
                ),
            ),
            if(series.tvdbId != 0) Expanded(
                child: LSCard(
                    child: InkWell(
                        child: Padding(
                            child: Image.asset(
                                'assets/images/services/thetvdb.png',
                                height: 23.0,
                            ),
                            padding: EdgeInsets.all(17.0),
                        ),
                        borderRadius: BorderRadius.circular(Constants.UI_BORDER_RADIUS),
                        onTap: () async => await series?.tvdbId?.toString()?.lunaOpenTheTVDB(),
                    ),
                    reducedMargin: true,
                ),
            ),
            if(series.tvMazeId != 0) Expanded(
                child: LSCard(
                    child: InkWell(
                        child: Padding(
                            child: Image.asset(
                                'assets/images/services/tvmaze.png',
                                height: 21.0,
                            ),
                            padding: EdgeInsets.all(18.0),
                        ),
                        borderRadius: BorderRadius.circular(Constants.UI_BORDER_RADIUS),
                        onTap: () async => await series?.tvMazeId?.toString()?.lunaOpenTVMaze(),
                    ),
                    reducedMargin: true,
                ),
            ),
        ],
    );
}
