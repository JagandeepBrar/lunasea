import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:lunasea/widgets/ui.dart';

class LSDescriptionBlock extends StatelessWidget {
    final String description;
    final String title;
    final String uri;

    LSDescriptionBlock({
        @required this.description,
        @required this.title,
        @required this.uri,
    });

    @override
    Widget build(BuildContext context) => LSCard(
        child: InkWell(
            child: Row(
                children: <Widget>[
                    uri != null && uri != '' ? (
                        ClipRRect(
                            child: Image(
                                image: AdvancedNetworkImage(
                                    uri,
                                    useDiskCache: true,
                                    fallbackAssetImage: 'assets/images/secondary_color.png',
                                    loadFailedCallback: () {},
                                    retryLimit: 1,
                                ),
                                height: 100.0,
                                fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        )
                    ) : (
                        Container()
                    ),
                    Expanded(
                        child: Padding(
                            child: Text(
                                description ?? 'No summary is available.\n\n\n',
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
            onTap: () => SystemDialogs.showTextPreviewPrompt(context, title, description ?? 'No summary is available.'),
        ),
    );
}