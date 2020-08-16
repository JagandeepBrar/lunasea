import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
    @override
    Widget build(BuildContext context) {
        return LSCard(
            child: InkWell(
                child: Row(
                    children: <Widget>[
                        widget.uri != null
                            ? ClipRRect(
                                child: CachedNetworkImage(
                                    fadeInDuration: Duration(milliseconds: Constants.UI_NAVIGATION_SPEED),
                                    fadeOutDuration: Duration(milliseconds: Constants.UI_NAVIGATION_SPEED),
                                    imageUrl: widget.uri,
                                    httpHeaders: Map<String, String>.from(widget.headers),
                                    imageBuilder: (context, imageProvider) => Container(
                                        height: 105.0,
                                        width: widget.squareImage ? 105.0 : 71.0,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.cover,
                                            ),
                                        ),
                                    ),
                                    placeholder: (context, url) => _placeholder,
                                    errorWidget: (context, url, error) => _placeholder,
                                ),
                                borderRadius: BorderRadius.circular(Constants.UI_BORDER_RADIUS),
                            )
                        : Container(),
                        Expanded(
                            child: Container(
                                height: 105.0,
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
                onTap: () => GlobalDialogs.textPreview(context, widget.title, widget.description.trim() ?? 'No summary is available.'),
            ),
        );
    }

    Widget get _placeholder => Container(
        height: 105.0,
        width: widget.squareImage ? 105.0 : 71.0,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(widget.fallbackImage),
            ),
        ),
    );
}
