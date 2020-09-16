import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:tautulli/tautulli.dart';

class TautulliMediaDetailsMetadataSummary extends StatelessWidget {
    final TautulliMetadata metadata;

    TautulliMediaDetailsMetadataSummary({
        Key key,
        @required this.metadata,
    }) : super(key: key);

    @override
    Widget build(BuildContext context) => LSCard(
        child: InkWell(
            child: Padding(
                child: Text(
                    metadata.summary.trim(),
                    style: TextStyle(
                        fontSize: Constants.UI_FONT_SIZE_SUBTITLE,
                        color: Colors.white,
                    ),
                    maxLines: 6,
                    overflow: TextOverflow.fade,
                    textAlign: TextAlign.center,
                ),
                padding: EdgeInsets.all(12.0),
            ),
            borderRadius: BorderRadius.circular(Constants.UI_BORDER_RADIUS),
            onTap: () async => GlobalDialogs.textPreview(context, metadata.title, metadata.summary.trim()),
        ),
    );
}
