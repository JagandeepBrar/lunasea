import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:tautulli/tautulli.dart';

class TautulliLibrariesDetailsInformationDetails extends StatelessWidget {
    final TautulliTableLibrary library;

    TautulliLibrariesDetailsInformationDetails({
        Key key,
        @required this.library,
    }) : super(key: key);
    
    @override
    Widget build(BuildContext context) => LSCard(
        child: Padding(
            child: Column(
                children: [
                    _content('name', library.sectionName),
                    if(library.count != null) _content(_count(library.count), '${library.count} ${_count(library.count)}'),
                    if(library.parentCount != null) _content(_parentCount(library.parentCount), '${library.parentCount} ${_parentCount(library.parentCount)}'),
                    if(library.childCount != null) _content(_childCount(library.childCount), '${library.childCount} ${_childCount(library.childCount)}'),
                    _content('last played', library.lastPlayed),
                    _content('', DateTime.now().lsDateTime_ageString(library.lastAccessed)),
                ]
            ),
            padding: EdgeInsets.symmetric(vertical: 8.0),
        ),
    );

    String _count(int value) {
        switch(library.sectionType) {
            case TautulliSectionType.MOVIE: return value == 1 ? 'Movie' : 'Movies';
            case TautulliSectionType.SHOW: return 'Series';
            case TautulliSectionType.ARTIST: return value == 1 ? 'Artist' : 'Artists';
            case TautulliSectionType.PHOTO: return value == 1 ? 'Photo' : 'Photos';
            case TautulliSectionType.NULL:
            default: return 'Unknown';
        }
    }

    String _childCount(int value) {
        switch(library.sectionType) {
            case TautulliSectionType.MOVIE: return null;
            case TautulliSectionType.SHOW: return value == 1 ? 'Episode' : 'Episodes';
            case TautulliSectionType.ARTIST: return value == 1 ? 'Track' : 'Tracks';
            case TautulliSectionType.PHOTO: return null;
            case TautulliSectionType.NULL:
            default: return 'Unknown';
        }
    }

    String _parentCount(int value) {
        switch(library.sectionType) {
            case TautulliSectionType.MOVIE: return null;
            case TautulliSectionType.SHOW: return value == 1 ? 'Season' : 'Seasons';
            case TautulliSectionType.ARTIST: return value == 1 ? 'Album' : 'Albums';
            case TautulliSectionType.PHOTO: return null;
            case TautulliSectionType.NULL:
            default: return 'Unknown';
        }
    }

    Widget _content(String header, String body) => Padding(
        child: Row(
            children: [
                Expanded(
                    child: Text(
                        header.toUpperCase(),
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            color: Colors.white70,
                            fontSize: Constants.UI_FONT_SIZE_SUBTITLE,
                        ),
                    ),
                    flex: 2,
                ),
                Container(width: 16.0, height: 0.0),
                Expanded(
                    child: Text(
                        body,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: Constants.UI_FONT_SIZE_SUBTITLE,
                        ),
                    ),
                    flex: 5,
                ),
            ],
            crossAxisAlignment: CrossAxisAlignment.start,
        ),
        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
    );
}