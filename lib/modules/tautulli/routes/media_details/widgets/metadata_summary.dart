import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliMediaDetailsMetadataSummary extends StatefulWidget {
  final TautulliMetadata? metadata;
  final TautulliMediaType? type;

  const TautulliMediaDetailsMetadataSummary({
    Key? key,
    required this.metadata,
    required this.type,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<TautulliMediaDetailsMetadataSummary> {
  static const List<TautulliMediaType> _blacklist = [
    TautulliMediaType.MOVIE,
    TautulliMediaType.ARTIST,
    TautulliMediaType.SHOW,
    TautulliMediaType.LIVE,
    TautulliMediaType.COLLECTION,
    TautulliMediaType.NULL,
  ];
  String? _summary;
  Widget? _buttons;

  @override
  void initState() {
    super.initState();
    if (widget.metadata!.summary != null &&
        widget.metadata!.summary!.trim().isNotEmpty) {
      _summary = widget.metadata!.summary!.trim();
    }
    _buttons = _buildButtons();
  }

  @override
  Widget build(BuildContext context) {
    if (_summary == null && _buttons == null)
      return const SizedBox(height: 0.0);
    return LunaCard(
      context: context,
      child: InkWell(
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (_summary != null)
                    Padding(
                      child: RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            fontSize: LunaUI.FONT_SIZE_H3,
                          ),
                          text: _summary,
                        ),
                        maxLines: 6,
                        overflow: TextOverflow.fade,
                        textAlign: TextAlign.center,
                      ),
                      padding: EdgeInsets.fromLTRB(
                        12.0,
                        12.0,
                        12.0,
                        _buttons == null ? 12.0 : 6.0,
                      ),
                    ),
                  if (_buttons != null) _buttons!,
                ],
              ),
            ),
          ],
        ),
        onTap: () async => LunaDialogs()
            .textPreview(context, widget.metadata!.title, _summary!),
      ),
    );
  }

  Widget? _buildButtons() {
    if (_blacklist.contains(widget.type)) return null;
    return LunaButtonContainer(
      children: _buttonBuilder(),
      padding: EdgeInsets.fromLTRB(
        6.0,
        _summary == null ? 6.0 : 0.0,
        6.0,
        6.0,
      ),
    );
  }

  List<Widget> _buttonBuilder() {
    switch (widget.type) {
      case TautulliMediaType.SEASON:
        return [
          _button(TautulliMediaDetailsSwitcherType.GO_TO_SERIES),
        ];
      case TautulliMediaType.EPISODE:
        return [
          _button(TautulliMediaDetailsSwitcherType.GO_TO_SERIES),
          _button(TautulliMediaDetailsSwitcherType.GO_TO_SEASON),
        ];
      case TautulliMediaType.ALBUM:
        return [
          _button(TautulliMediaDetailsSwitcherType.GO_TO_ARTIST),
        ];
      case TautulliMediaType.TRACK:
        return [
          _button(TautulliMediaDetailsSwitcherType.GO_TO_ARTIST),
          _button(TautulliMediaDetailsSwitcherType.GO_TO_ALBUM),
        ];
      default:
        return [];
    }
  }

  Widget _button(TautulliMediaDetailsSwitcherType type) {
    return LunaButton.text(
      text: type.label!,
      icon: Icons.info_outline_rounded,
      onTap: () => _buttonOnTap(type),
    );
  }

  void _buttonOnTap(TautulliMediaDetailsSwitcherType value) {
    switch (value) {
      case TautulliMediaDetailsSwitcherType.GO_TO_SERIES:
        value.goTo(
          context: context,
          mediaType: TautulliMediaType.SHOW,
          ratingKey: widget.type == TautulliMediaType.EPISODE
              ? widget.metadata!.grandparentRatingKey!
              : widget.metadata!.parentRatingKey!,
        );
        break;
      case TautulliMediaDetailsSwitcherType.GO_TO_SEASON:
        value.goTo(
          context: context,
          mediaType: TautulliMediaType.SEASON,
          ratingKey: widget.metadata!.parentRatingKey!,
        );
        break;
      case TautulliMediaDetailsSwitcherType.GO_TO_ARTIST:
        value.goTo(
          context: context,
          mediaType: TautulliMediaType.ARTIST,
          ratingKey: widget.type == TautulliMediaType.TRACK
              ? widget.metadata!.grandparentRatingKey!
              : widget.metadata!.parentRatingKey!,
        );
        break;
      case TautulliMediaDetailsSwitcherType.GO_TO_ALBUM:
        value.goTo(
          context: context,
          mediaType: TautulliMediaType.ALBUM,
          ratingKey: widget.metadata!.parentRatingKey!,
        );
        break;
    }
  }
}
