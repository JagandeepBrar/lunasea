import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrDetailsOverview extends StatefulWidget {
    final RadarrCatalogueData data;

    RadarrDetailsOverview({
        Key key,
        @required this.data,
    }) : super(key: key);

    @override
    State<RadarrDetailsOverview> createState() => _State();
}

class _State extends State<RadarrDetailsOverview> with AutomaticKeepAliveClientMixin {
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
                    fallbackImage: 'assets/images/radarr/nomovieposter.png',
                    headers: Database.currentProfileObject.getRadarr()['headers'],
                ),
                LSCardTile(
                    title: LSTitle(text: 'Movie Path', centerText: true),
                    subtitle: LSSubtitle(text: widget?.data?.path ?? 'Unknown', centerText: true),
                    onTap: () => GlobalDialogs.textPreview(context, widget?.data?.title, widget?.data?.path ?? 'Unknown'),
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
                                title: LSTitle(text: 'Min Availability', centerText: true),
                                subtitle: LSSubtitle(
                                    text: RadarrConstants.MINIMUM_AVAILBILITIES.firstWhere(
                                        (data) => data.id == widget?.data?.minimumAvailability,
                                        orElse: () => null,
                                    )?.name ?? 'Unknown',
                                    centerText: true,
                                ),
                                reducedMargin: true,
                            ),
                        ),
                    ],
                ),
                LSContainerRow(
                    children: <Widget>[
                        Expanded(
                            child: LSCardTile(
                                title: LSTitle(text: 'Studio', centerText: true),
                                subtitle: LSSubtitle(text: widget?.data?.studio ?? 'None', centerText: true),
                                reducedMargin: true,
                            ),
                        ),
                        Expanded(
                            child: LSCardTile(
                                title: LSTitle(text: 'Runtime', centerText: true),
                                subtitle: LSSubtitle(text: (widget?.data?.runtime ?? -1) > 0 ? '${widget.data.runtime} Minutes' : 'Unknown', centerText: true),
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
                        if(widget.data.tmdbId != null && widget.data.tmdbId != 0) Expanded(
                            child: LSCard(
                                child: InkWell(
                                    child: Padding(
                                        child: Image.asset(
                                            'assets/images/services/themoviedb.png',
                                            height: 19.0,
                                        ),
                                        padding: EdgeInsets.all(19.0),
                                    ),
                                    borderRadius: BorderRadius.circular(Constants.UI_BORDER_RADIUS),
                                    onTap: () async => await widget.data?.tmdbId?.toString()?.lsLinks_OpenMovieDB(),
                                ),
                                reducedMargin: true,
                            ),
                        ),
                        if(widget.data.youtubeId != '') Expanded(
                            child: LSCard(
                                child: InkWell(
                                    child: Padding(
                                        child: Image.asset(
                                            'assets/images/services/youtube.png',
                                            height: 17.0,
                                        ),
                                        padding: EdgeInsets.all(20.0),
                                    ),
                                    borderRadius: BorderRadius.circular(Constants.UI_BORDER_RADIUS),
                                    onTap: () async => await widget.data?.youtubeId?.lsLinks_OpenYoutube(),
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
