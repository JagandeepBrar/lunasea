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
  final double _imageDimension = 105.0;

  @override
  Widget build(BuildContext context) {
    return LunaCard(
      context: context,
      child: InkWell(
        child: Row(
          children: <Widget>[
            widget.uri != null
                ? LunaNetworkImage(
                    context: context,
                    height: _imageDimension,
                    width: widget.squareImage
                        ? _imageDimension
                        : _imageDimension / 1.5,
                    url: widget.uri,
                    placeholderIcon: LunaIcons.USER,
                    headers: ((Database.currentProfileObject
                                .getLidarr()['headers'] ??
                            {}) as Map)
                        .cast<String, String>(),
                  )
                : Container(),
            Expanded(
              child: Container(
                height: _imageDimension,
                child: Padding(
                  child: Text(
                    widget.description ?? 'No summary is available.',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 5,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: LunaUI.FONT_SIZE_H3,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  padding: const EdgeInsets.all(12.0),
                ),
                alignment: Alignment.topLeft,
              ),
            ),
          ],
        ),
        borderRadius: BorderRadius.circular(LunaUI.BORDER_RADIUS),
        onTap: () => LunaDialogs().textPreview(context, widget.title,
            widget.description.trim() ?? 'No summary is available.'),
      ),
    );
  }
}
