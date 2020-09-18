import 'package:flutter/material.dart';
import 'package:lunasea/modules/tautulli.dart';
import 'package:tautulli/tautulli.dart';

enum TautulliMediaDetailsSwitcherType {
    GO_TO_SERIES,
    GO_TO_SEASON,
    GO_TO_ARTIST,
    GO_TO_ALBUM,
}

extension TautulliMediaDetailsSwitcherTypeExtension on TautulliMediaDetailsSwitcherType {
    String get value {
        switch(this) {
            case TautulliMediaDetailsSwitcherType.GO_TO_SERIES: return 'gotoseries';
            case TautulliMediaDetailsSwitcherType.GO_TO_SEASON: return 'gotoseason';
            case TautulliMediaDetailsSwitcherType.GO_TO_ARTIST: return 'gotoartist';
            case TautulliMediaDetailsSwitcherType.GO_TO_ALBUM: return 'gotoalbum';
            default: return null;
        }
    }

    String get label {
        switch(this) {
            case TautulliMediaDetailsSwitcherType.GO_TO_SERIES: return 'Go to Series';
            case TautulliMediaDetailsSwitcherType.GO_TO_SEASON: return 'Go to Season';
            case TautulliMediaDetailsSwitcherType.GO_TO_ARTIST: return 'Go to Artist';
            case TautulliMediaDetailsSwitcherType.GO_TO_ALBUM: return 'Go to Album';
            default: return null;
        }
    }

    void goTo({
        @required BuildContext context,
        @required TautulliMediaType mediaType,
        @required int ratingKey
    }) => TautulliRouter.router.navigateTo(
        context,
        TautulliMediaDetailsRoute.route(ratingKey: ratingKey, mediaType: mediaType),
    );
}
