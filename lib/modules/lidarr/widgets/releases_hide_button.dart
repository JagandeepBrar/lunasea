import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/lidarr.dart';

class LidarrReleasesHideButton extends StatefulWidget {
    final ScrollController controller;

    LidarrReleasesHideButton({
        Key key,
        @required this.controller,
    }): super(key: key);

    @override
    State<LidarrReleasesHideButton> createState() => _State();
}

class _State extends State<LidarrReleasesHideButton> {    
    @override
    Widget build(BuildContext context) => LSCard(
        child: Consumer<LidarrState>(
            builder: (context, model, widget) => LSIconButton(
                icon: model.hideRejectedReleases
                    ? Icons.visibility_off
                    : Icons.visibility,
                onPressed: () => model.hideRejectedReleases = !model.hideRejectedReleases,
            ),
        ),
        margin: EdgeInsets.fromLTRB(0.0, 0.0, 12.0, 12.0),
        color: Theme.of(context).canvasColor,
    );
}
