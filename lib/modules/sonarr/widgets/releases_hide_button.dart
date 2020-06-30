import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrReleasesHideButton extends StatefulWidget {
    final ScrollController controller;

    SonarrReleasesHideButton({
        Key key,
        @required this.controller,
    }): super(key: key);

    @override
    State<SonarrReleasesHideButton> createState() => _State();
}

class _State extends State<SonarrReleasesHideButton> {    
    @override
    Widget build(BuildContext context) => LSCard(
        child: Consumer<SonarrModel>(
            builder: (context, model, widget) => InkWell(
                child: LSIconButton(
                    icon: model.hideRejectedReleases
                        ? Icons.visibility_off
                        : Icons.visibility,
                ),
                onTap: () => model.hideRejectedReleases = !model.hideRejectedReleases,
                borderRadius: BorderRadius.circular(Constants.UI_BORDER_RADIUS),
            ),
        ),
        margin: EdgeInsets.fromLTRB(0.0, 0.0, 12.0, 12.0),
        color: Theme.of(context).canvasColor,
    );
}
