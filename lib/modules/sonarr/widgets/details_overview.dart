import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrDetailsOverview extends StatefulWidget {
    final SonarrCatalogueData data;

    SonarrDetailsOverview({
        Key key,
        @required this.data,
    }) : super(key: key);

    @override
    State<SonarrDetailsOverview> createState() => _State();
}

class _State extends State<SonarrDetailsOverview> with AutomaticKeepAliveClientMixin {
    @override
    bool get wantKeepAlive => true;

    @override
    Widget build(BuildContext context) {
        super.build(context);
        return LSListView(
            children: <Widget>[
                LSDescriptionBlock(
                    title: widget?.data?.title ?? 'Unknown',
                    description: widget?.data?.overview == ''
                    ? 'No summary is available.'
                    : widget?.data?.overview,
                    uri: widget?.data?.posterURI() ?? '',
                    fallbackImage: 'assets/images/sonarr/noseriesposter.png',
                    headers: Database.currentProfileObject.getSonarr()['headers'],
                ),
                LSCardTile(
                    title: LSTitle(text: 'Series Path', centerText: true),
                    subtitle: LSSubtitle(text: widget?.data?.path ?? 'Unknown', centerText: true),
                    onTap: () => GlobalDialogs.textPreview(context, 'Series Path', widget?.data?.path ?? 'Unknown'),
                ),
                LSContainerRow(
                    children: <Widget>[
                        Expanded(
                            child: LSCardTile(
                                title: LSTitle(text: 'Quality Profile', centerText: true),
                                subtitle: LSSubtitle(text: widget?.data?.profile ?? 'Unknown', centerText: true),
                                reducedMargin: true,
                            ),
                        ),
                        Expanded(
                            child: LSCardTile(
                                title: LSTitle(text: 'Series Type', centerText: true),
                                subtitle: LSSubtitle(text: widget?.data?.type?.lsLanguage_Capitalize() ?? 'Unknown', centerText: true),
                                reducedMargin: true,
                            ),
                        ),
                    ],
                ),
                LSContainerRow(
                    children: <Widget>[
                        Expanded(
                            child: LSCardTile(
                                title: LSTitle(text: 'Network', centerText: true),
                                subtitle: LSSubtitle(text: widget?.data?.network ?? 'None', centerText: true),
                                reducedMargin: true,
                            ),
                        ),
                        Expanded(
                            child: LSCardTile(
                                title: LSTitle(text: 'Runtime', centerText: true),
                                subtitle: LSSubtitle(text: widget.data.runtime > 0 ? '${widget.data.runtime} Minutes' : 'Unknown', centerText: true),
                                reducedMargin: true,
                            ),
                        ),
                    ],
                ),
                LSContainerRow(
                    children: <Widget>[
                        Expanded(
                            child: LSCardTile(
                                title: LSTitle(text: 'Next Air Date', centerText: true),
                                subtitle: LSSubtitle(text: widget.data.status == 'ended' ? 'Series Ended' : widget.data.nextEpisode ?? 'Unknown', centerText: true),
                                reducedMargin: true,
                            ),
                        ),
                        Expanded(
                            child: LSCardTile(
                                title: LSTitle(text: 'Air Time', centerText: true),
                                subtitle: LSSubtitle(text: widget.data.airTimeString ?? 'Unknown', centerText: true),
                                reducedMargin: true,
                            ),
                        ),
                    ],
                ),
                LSContainerRow(
                    children: <Widget>[
                        if(widget.data.imdbId != '') Expanded(
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
                                    onTap: () async => await widget.data?.imdbId?.lsLinks_OpenIMDB(),
                                ),
                                reducedMargin: true,
                            ),
                        ),
                        if(widget.data.tvdbId != 0) Expanded(
                            child: LSCard(
                                child: InkWell(
                                    child: Padding(
                                        child: Image.asset(
                                            'assets/images/services/thetvdb.png',
                                            height: 21.0,
                                        ),
                                        padding: EdgeInsets.all(18.0),
                                    ),
                                    borderRadius: BorderRadius.circular(Constants.UI_BORDER_RADIUS),
                                    onTap: () async => await widget.data?.tvdbId?.toString()?.lsLinks_OpenTVDB(),
                                ),
                                reducedMargin: true,
                            ),
                        ),
                        if(widget.data.tvMazeId != 0) Expanded(
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
                                    onTap: () async => await widget.data?.tvMazeId?.toString()?.lsLinks_OpenTVMaze(),
                                ),
                                reducedMargin: true,
                            ),
                        ),
                    ],
                ),
            ],
        );
    }
}
