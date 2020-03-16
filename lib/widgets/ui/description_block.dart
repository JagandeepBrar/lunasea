import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/transition.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:lunasea/widgets/ui.dart';

class LSDescriptionBlock extends StatefulWidget {
    final String description;
    final String title;
    final String uri;
    final String fallbackImage;

    LSDescriptionBlock({
        @required this.description,
        @required this.title,
        @required this.uri,
        @required this.fallbackImage,
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
                                        useDiskCache: true,
                                        fallbackAssetImage: widget.fallbackImage,
                                        retryLimit: 1,
                                    ),
                                    height: 100.0,
                                    fit: BoxFit.cover,
                                    loadingWidget: Image.asset(
                                        widget.fallbackImage,
                                        height: 100.0,
                                    ),
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                            )
                        : Container(),
                        Expanded(
                            child: Padding(
                                child: Text(
                                    widget.description ?? 'No summary is available',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 4,
                                    style: TextStyle(
                                        color: Colors.white,
                                    ),
                                ),
                                padding: EdgeInsets.all(16.0),
                            ),
                        ),
                    ],
                ),
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                onTap: () => SystemDialogs.showTextPreviewPrompt(context, widget.title, widget.description ?? 'No summary is available'),
            ),
        );
    }
}