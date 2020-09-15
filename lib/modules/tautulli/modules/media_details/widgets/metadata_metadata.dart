import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:tautulli/tautulli.dart';

class TautulliMediaDetailsMetadataMetadata extends StatelessWidget {
    final TautulliMetadata metadata;

    TautulliMediaDetailsMetadataMetadata({
        Key key,
        @required this.metadata,
    }) : super(key: key);

    @override
    Widget build(BuildContext context) => _block(
        children: [
            if(metadata.originallyAvailableAt != null && metadata.originallyAvailableAt.isNotEmpty) _content('released', metadata.originallyAvailableAt),
            if(metadata.addedAt != null) _content('added', metadata.addedAt.lsDateTime_date),
            if(metadata.duration != null) _content('duration', metadata.duration.lsDuration_timestamp()),
            if(metadata.mediaInfo != null && metadata.mediaInfo.length != 0) _content('resolution', metadata.mediaInfo[0].videoFullResolution),
            if(metadata.rating != null) _content('rating', '${((metadata.rating*10).truncate())}%'),
            if(metadata.studio != null && metadata.studio.isNotEmpty) _content('studio', metadata.studio),
            if(metadata.genres != null && metadata.genres.length != 0) _content('genres', metadata.genres.take(5).join('\n')),
            if(metadata.directors != null && metadata.directors.length != 0) _content('directors', metadata.directors.take(5).join('\n')),
            if(metadata.writers != null && metadata.writers.length != 0) _content('writers', metadata.writers.take(5).join('\n')),
            if(metadata.actors != null && metadata.actors.length != 0) _content('actors', metadata.actors.take(5).join('\n')),
        ],
    );
    
    Widget _block({ @required List<Widget> children }) => LSCard(
        child: Padding(
            child: Column(
                children: children,
            ),
            padding: EdgeInsets.symmetric(vertical: 8.0),
        ),
    );

    Widget _content(String header, String body) => Padding(
        child: Row(
            children: [
                Expanded(
                    child: Text(
                        header.toUpperCase(),
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            color: Colors.white70,
                        ),
                    ),
                    flex: 2,
                ),
                Container(width: 16.0, height: 0.0),
                Expanded(
                    child: Text(
                        body,
                        textAlign: TextAlign.start,
                        style: TextStyle(),
                    ),
                    flex: 5,
                ),
            ],
            crossAxisAlignment: CrossAxisAlignment.start,
        ),
        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
    );
}