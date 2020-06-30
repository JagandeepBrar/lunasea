import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/transition.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:lunasea/core.dart';

class LSDescriptionBlock extends StatefulWidget {
    final String description;
    final String title;
    final String uri;
    final String fallbackImage;
    final Map headers;

    LSDescriptionBlock({
        @required this.description,
        @required this.title,
        @required this.uri,
        @required this.fallbackImage,
        @required this.headers,
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
                                child: TransitionToImage(
                                    image: AdvancedNetworkImage(
                                        widget.uri,
                                        header: Map<String, String>.from(widget.headers),
                                        useDiskCache: true,
                                        fallbackAssetImage: widget.fallbackImage,
                                        retryLimit: 1,
                                        timeoutDuration: Duration(seconds: 3),
                                    ),
                                    height: 105.0,
                                    fit: BoxFit.cover,
                                    loadingWidget: Image.asset(
                                        widget.fallbackImage,
                                        height: 105.0,
                                    ),
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
}