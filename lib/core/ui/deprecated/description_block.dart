import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class LSDescriptionBlock extends StatefulWidget {
    final String description;
    final String title;
    final String uri;
    final String fallbackImage;
    final bool squareImage;
    final Map headers;

    LSDescriptionBlock({
        @required this.description,
        @required this.title,
        @required this.uri,
        @required this.fallbackImage,
        @required this.headers,
        this.squareImage = false,
    });

    @override
    State<StatefulWidget> createState() => _State();   
}

class _State extends State<LSDescriptionBlock> {
    final double _imageDimension = 105.0;

    @override
    Widget build(BuildContext context) {
        return LSCard(
            child: InkWell(
                child: Row(
                    children: <Widget>[
                        widget.uri != null
                            ? LSNetworkImage(
                                height: _imageDimension,
                                width: widget.squareImage ? _imageDimension : _imageDimension/1.5,
                                url: widget.uri,
                                placeholder: widget.fallbackImage,
                                headers: ((Database.currentProfileObject.getLidarr()['headers'] ?? {}) as Map).cast<String, String>(),
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
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: Constants.UI_FONT_SIZE_SUBTITLE,
                                        ),
                                        textAlign: TextAlign.start,
                                    ),
                                    padding: EdgeInsets.all(12.0),
                                ),
                                alignment: Alignment.center,
                            ),
                        ),
                    ],
                ),
                borderRadius: BorderRadius.circular(Constants.UI_BORDER_RADIUS),
                onTap: () => LunaDialogs().textPreview(context, widget.title, widget.description.trim() ?? 'No summary is available.'),
            ),
        );
    }
}
