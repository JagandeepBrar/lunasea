import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class LidarrDescriptionBlock extends StatefulWidget {
  final String description;
  final String title;
  final String uri;
  final bool squareImage;
  final Map headers;

  const LidarrDescriptionBlock({
    Key key,
    @required this.description,
    @required this.title,
    @required this.uri,
    @required this.headers,
    this.squareImage = false,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<LidarrDescriptionBlock> {
  @override
  Widget build(BuildContext context) {
    return LunaBlock(
      title: widget.title,
      body: [
        LunaTextSpan.extended(
          text: widget.description?.isNotEmpty ?? false
              ? widget.description
              : 'No Summary Available',
        ),
      ],
      onTap: () async => LunaDialogs().textPreview(
        context,
        widget.title,
        widget.description.trim() ?? 'No Summary Available',
      ),
      customBodyMaxLines: 3,
      posterPlaceholderIcon: LunaIcons.USER,
      posterHeaders: widget.headers,
      posterIsSquare: widget.squareImage,
      posterUrl: widget.uri,
    );
  }
}
