import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliMediaDetailsSwitcherButton extends StatefulWidget {
    final TautulliMetadata metadata;
    final TautulliMediaType type;
    final int ratingKey;

    TautulliMediaDetailsSwitcherButton({
        Key key,
        @required this.metadata,
        @required this.type,
        @required this.ratingKey,
    }) : super(key: key);

    @override
    State<TautulliMediaDetailsSwitcherButton> createState() => _State();
}

class _State extends State<TautulliMediaDetailsSwitcherButton> {
    static const List<TautulliMediaType> _blacklist = [
        TautulliMediaType.MOVIE,
        TautulliMediaType.ARTIST,
        TautulliMediaType.SHOW,
        TautulliMediaType.LIVE,
        TautulliMediaType.COLLECTION,
        TautulliMediaType.NULL,
    ];

    @override
    Widget build(BuildContext context) => _buttons;

    Widget get _buttons {
        if(_blacklist.contains(widget.type)) return Container();
        return LunaButtonContainer(
            children: _buttonBuilder(),
        );
    }

    List<Widget> _buttonBuilder() {
        switch(widget.type) {
            case TautulliMediaType.SEASON: return [
                _button(TautulliMediaDetailsSwitcherType.GO_TO_SERIES, LunaColours.accent),
            ];
            case TautulliMediaType.EPISODE: return [
                _button(TautulliMediaDetailsSwitcherType.GO_TO_SERIES, LunaColours.accent),
                _button(TautulliMediaDetailsSwitcherType.GO_TO_SEASON, LunaColours.orange),
            ];
            case TautulliMediaType.ALBUM: return [
                _button(TautulliMediaDetailsSwitcherType.GO_TO_ARTIST, LunaColours.accent),
            ];
            case TautulliMediaType.TRACK: return [
                _button(TautulliMediaDetailsSwitcherType.GO_TO_ARTIST, LunaColours.accent),
                _button(TautulliMediaDetailsSwitcherType.GO_TO_ALBUM, LunaColours.orange),
            ];
            default: return [];
        }
    }

    Widget _button(TautulliMediaDetailsSwitcherType type, Color color) => LunaButton.text(
        text: type.label,
        onTap: () => _onTap(type),
        backgroundColor: color,
    );

    void _onTap(TautulliMediaDetailsSwitcherType value) {
        switch(value) {  
            case TautulliMediaDetailsSwitcherType.GO_TO_SERIES:
                value.goTo(
                    context: context,
                    mediaType: TautulliMediaType.SHOW,
                    ratingKey: widget.type == TautulliMediaType.EPISODE
                        ? widget.metadata.grandparentRatingKey
                        : widget.metadata.parentRatingKey,
                );
                break;
            case TautulliMediaDetailsSwitcherType.GO_TO_SEASON:
                value.goTo(
                    context: context,
                    mediaType: TautulliMediaType.SEASON,
                    ratingKey: widget.metadata.parentRatingKey,
                );
                break;
            case TautulliMediaDetailsSwitcherType.GO_TO_ARTIST:
                value.goTo(
                    context: context,
                    mediaType: TautulliMediaType.ARTIST,
                    ratingKey: widget.type == TautulliMediaType.TRACK
                        ? widget.metadata.grandparentRatingKey
                        : widget.metadata.parentRatingKey,
                );
                break;
            case TautulliMediaDetailsSwitcherType.GO_TO_ALBUM:
                value.goTo(
                    context: context,
                    mediaType: TautulliMediaType.ALBUM,
                    ratingKey: widget.metadata.parentRatingKey,
                );
                break;
        }
    }
}
