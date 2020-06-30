import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/lidarr.dart';

class LidarrDetailsOverview extends StatefulWidget {
    final LidarrCatalogueData data;

    LidarrDetailsOverview({
        Key key,
        @required this.data,
    }) : super(key: key);

    @override
    State<LidarrDetailsOverview> createState() => _State();
}

class _State extends State<LidarrDetailsOverview> with AutomaticKeepAliveClientMixin {
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
                    fallbackImage: 'assets/images/lidarr/noartistposter.png',
                    headers: Database.currentProfileObject.getLidarr()['headers'],
                ),
                LSCardTile(
                    title: LSTitle(text: 'Artist Path', centerText: true),
                    subtitle: LSSubtitle(text: widget?.data?.path ?? 'Unknown', centerText: true),
                    onTap: () => GlobalDialogs.textPreview(context, 'Artist Path', widget?.data?.path ?? 'Unknown'),
                ),
                LSContainerRow(
                    children: <Widget>[
                        Expanded(
                            child: LSCardTile(
                                title: LSTitle(text: 'Quality Profile', centerText: true),
                                subtitle: LSSubtitle(text: widget?.data?.quality ?? 'Unknown', centerText: true),
                                reducedMargin: true,
                            ),
                        ),
                        Expanded(
                            child: LSCardTile(
                                title: LSTitle(text: 'Metadata Profile', centerText: true),
                                subtitle: LSSubtitle(text: widget?.data?.metadata ?? 'Unknown', centerText: true),
                                reducedMargin: true,
                            ),
                        ),
                    ],
                ),
                LSContainerRow(
                    children: <Widget>[
                        Expanded(
                            child: LSCardTile(
                                title: LSTitle(text: 'Genre', centerText: true),
                                subtitle: LSSubtitle(text: widget?.data?.genre ?? 'None', centerText: true),
                                reducedMargin: true,
                            ),
                        ),
                        Expanded(
                            child: LSCardTile(
                                title: LSTitle(text: 'Statistics', centerText: true),
                                subtitle: LSSubtitle(text: '${widget.data.albums ?? 'Unknown'}, ${widget.data.tracks ?? 'Unknown'}', centerText: true),
                                reducedMargin: true,
                            ),
                        ),
                    ],
                ),
                LSContainerRow(
                    children: <Widget>[
                        if(widget.data.bandsintownURI != '') Expanded(
                            child: LSCard(
                                child: InkWell(
                                    child: Padding(
                                        child: Image.asset(
                                            'assets/images/services/bandsintown.png',
                                            height: 25.0,
                                        ),
                                        padding: EdgeInsets.all(16.0),
                                    ),
                                    borderRadius: BorderRadius.circular(Constants.UI_BORDER_RADIUS),
                                    onTap: () async => await widget.data?.bandsintownURI?.lsLinks_OpenLink(),
                                ),
                                reducedMargin: true,
                            ),
                        ),
                        if(widget.data.discogsURI != '') Expanded(
                            child: LSCard(
                                child: InkWell(
                                    child: Padding(
                                        child: Image.asset(
                                            'assets/images/services/discogs.png',
                                            height: 19.0,
                                        ),
                                        padding: EdgeInsets.all(19.0),
                                    ),
                                    borderRadius: BorderRadius.circular(Constants.UI_BORDER_RADIUS),
                                    onTap: () async => await widget.data?.discogsURI?.lsLinks_OpenLink(),
                                ),
                                reducedMargin: true,
                            ),
                        ),
                        if(widget.data.lastfmURI != '') Expanded(
                            child: LSCard(
                                child: InkWell(
                                    child: Padding(
                                        child: Image.asset(
                                            'assets/images/services/lastfm.png',
                                            height: 17.0,
                                        ),
                                        padding: EdgeInsets.all(20.0),
                                    ),
                                    borderRadius: BorderRadius.circular(Constants.UI_BORDER_RADIUS),
                                    onTap: () async => await widget.data?.lastfmURI?.lsLinks_OpenLink(),
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
