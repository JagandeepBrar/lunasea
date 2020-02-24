import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/widgets/ui.dart';

Widget buildOverview(RadarrCatalogueEntry entry, BuildContext context) {
    return Scrollbar(
        child: ListView(
            children: <Widget>[
                _buildSummary(entry, context),
                _buildPath(entry, context),
                _buildYearProfile(entry),
                _buildMovieDetails(entry),
                _buildDates(entry),
                _buildExternalLinks(entry),
            ],
            padding: Elements.getListViewPadding(),
        ),
    );
}

Widget _buildDates(RadarrCatalogueEntry entry) {
    return Padding(
        child: Row(
            children: <Widget>[
                Expanded(
                    child: Card(
                        child: Padding(
                            child: Column(
                                children: <Widget>[
                                    Elements.getTitle('In Cinemas'),
                                    Elements.getSubtitle(entry.inCinemasString ?? 'Unknown', preventOverflow: true),
                                ],
                            ),
                            padding: EdgeInsets.all(16.0),
                        ),
                        margin: EdgeInsets.all(6.0),
                        elevation: 4.0,
                    ),
                ),
                Expanded(
                    child: Card(
                        child: Padding(
                            child: Column(
                                children: <Widget>[
                                    Elements.getTitle('Physical Release'),
                                    Elements.getSubtitle(entry.physicalReleaseString ?? 'Unknown', preventOverflow: true),
                                ],
                            ),
                            padding: EdgeInsets.all(16.0),
                        ),
                        margin: EdgeInsets.all(6.0),
                        elevation: 4.0,
                    ),
                ),
            ],
        ),
        padding: EdgeInsets.symmetric(horizontal: 6.0),
    );
}

Widget _buildPath(RadarrCatalogueEntry entry, BuildContext context) {
    return Padding(
        child: Row(
            children: <Widget>[
                Expanded(
                    child: Card(
                        child: InkWell(
                            child: Padding(
                                child: Column(
                                    children: <Widget>[
                                        Elements.getTitle('Movie Path'),
                                        Text(
                                        entry.path ?? 'Unknown',
                                        overflow: TextOverflow.fade,
                                        softWrap: false,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 14.0,
                                        ),  
                                    ),
                                    ],
                                ),
                                padding: EdgeInsets.all(16.0),
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(4.0)),
                            onTap: () async {
                                await SystemDialogs.showTextPreviewPrompt(context, 'Movie Path', entry.path);
                            },
                        ),
                        margin: EdgeInsets.all(6.0),
                        elevation: 4.0,
                    ),
                ),
            ],
        ),
        padding: EdgeInsets.symmetric(horizontal: 6.0),
    );
}

Widget _buildYearProfile(RadarrCatalogueEntry entry) {
    String _availability = 'Unknown';
    for(var availability in Constants.radarrMinAvailability) {
        if(availability.id == entry.minimumAvailability) {
            _availability = availability.name;
        }
    }
    return Padding(
        child: Row(
            children: <Widget>[
                Expanded(
                    child: Card(
                        child: Padding(
                            child: Column(
                                children: <Widget>[
                                    Elements.getTitle('Quality Profile'),
                                    Elements.getSubtitle(entry.profile ?? 'Unknown', preventOverflow: true),
                                ],
                            ),
                            padding: EdgeInsets.all(16.0),
                        ),
                        margin: EdgeInsets.all(6.0),
                        elevation: 4.0,
                    ),
                ),
                Expanded(
                    child: Card(
                        child: Padding(
                            child: Column(
                                children: <Widget>[
                                    Elements.getTitle('Min Availability'),
                                    Elements.getSubtitle(_availability, preventOverflow: true),
                                ],
                            ),
                            padding: EdgeInsets.all(16.0),
                        ),
                        margin: EdgeInsets.all(6.0),
                        elevation: 4.0,
                    ),
                ),
            ],
        ),
        padding: EdgeInsets.symmetric(horizontal: 6.0),
    );
}

Widget _buildMovieDetails(RadarrCatalogueEntry entry) {
    return Padding(
        child: Row(
            children: <Widget>[
                Expanded(
                    child: Card(
                        child: Padding(
                            child: Column(
                                children: <Widget>[
                                    Elements.getTitle('Studio'),
                                    Text(
                                        entry.studio ?? 'Unknown',
                                        overflow: TextOverflow.fade,
                                        softWrap: false,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 14.0,
                                        ),  
                                    ),
                                ],
                            ),
                            padding: EdgeInsets.all(16.0),
                        ),
                        margin: EdgeInsets.all(6.0),
                        elevation: 4.0,
                    ),
                ),
                Expanded(
                    child: Card(
                        child: Padding(
                            child: Column(
                                children: <Widget>[
                                    Elements.getTitle('Runtime'),
                                    Text(
                                        entry.runtime > 0 ? '${entry.runtime} Minutes' : 'Unknown',
                                        overflow: TextOverflow.fade,
                                        softWrap: false,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 14.0,
                                        ),  
                                    ),
                                ],
                            ),
                            padding: EdgeInsets.all(16.0),
                        ),
                        margin: EdgeInsets.all(6.0),
                        elevation: 4.0,
                    ),
                ),
            ],
        ),
        padding: EdgeInsets.symmetric(horizontal: 6.0),
    );
}

Widget _buildExternalLinks(RadarrCatalogueEntry entry) {
    return Padding(
        child: Row(
            children: <Widget>[
                entry.imdbId != null && entry.imdbId != '' ? (
                    Expanded(
                        child: Card(
                            child: InkWell(
                                child: Padding(
                                    child: Image.asset(
                                        'assets/images/services/imdb.png',
                                        height: 25.0,
                                    ),
                                    padding: EdgeInsets.all(16.0),
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                                onTap: () async {
                                    await entry?.imdbId?.lsLinks_OpenIMDB();
                                },
                            ),
                            margin: EdgeInsets.all(6.0),
                            elevation: 4.0,
                        ),
                    )
                ) : (
                    Container()
                ),
                entry.tmdbId != null && entry.tmdbId != 0 ? (
                    Expanded(
                        child: Card(
                            child: InkWell(
                                child: Padding(
                                    child: Image.asset(
                                        'assets/images/services/themoviedb.png',
                                        height: 25.0,
                                    ),
                                    padding: EdgeInsets.all(16.0),
                                ),
                                onTap: () async {
                                    await entry?.tmdbId?.toString()?.lsLinks_OpenMovieDB();
                                },
                                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                            ),
                            margin: EdgeInsets.all(6.0),
                            elevation: 4.0,
                        ),
                    )
                ) : (
                    Container()
                ),
                entry.youtubeId != null && entry.youtubeId != '' ? (
                    Expanded(
                        child: Card(
                            child: InkWell(
                                child: Padding(
                                    child: Image.asset(
                                        'assets/images/services/youtube.png',
                                        height: 25.0,
                                    ),
                                    padding: EdgeInsets.all(16.0),
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                                onTap: () async {
                                    await entry.youtubeId.lsLinks_OpenYoutube();
                                },
                            ),
                            margin: EdgeInsets.all(6.0),
                            elevation: 4.0,
                        ),
                    )
                ) : (
                    Container()
                ),
            ],
        ),
        padding: EdgeInsets.symmetric(horizontal: 6.0),
    );
}

Widget _buildSummary(RadarrCatalogueEntry entry, BuildContext context) {
    return Card(
        child: InkWell(
            child: Row(
                children: <Widget>[
                    entry.posterURI() != null && entry.posterURI() != '' ? (
                        ClipRRect(
                            child: Image(
                                image: AdvancedNetworkImage(
                                    entry.posterURI(),
                                    useDiskCache: true,
                                    fallbackAssetImage: 'assets/images/secondary_color.png',
                                    loadFailedCallback: () {},
                                    retryLimit: 1,
                                ),
                                height: 100.0,
                                fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        )
                    ) : (
                        Container()
                    ),
                    Expanded(
                        child: Padding(
                            child: Text(
                                entry.overview ?? 'No summary is available.\n\n\n',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 4,
                                style: TextStyle(
                                    color: Colors.white,
                                ),
                            ),
                            padding: EdgeInsets.all(16.0),
                        ),
                    ),
                ],
            ),
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
            onTap: () async {
                await SystemDialogs.showTextPreviewPrompt(context, entry.title, entry.overview ?? 'No summary is available.');
            },
        ),
        margin: Elements.getCardMargin(),
        elevation: 4.0,
    );
}
