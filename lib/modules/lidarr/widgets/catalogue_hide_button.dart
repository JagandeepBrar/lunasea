import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/lidarr.dart';

class LidarrCatalogueHideButton extends StatefulWidget {
    final ScrollController controller;

    LidarrCatalogueHideButton({
        Key key,
        @required this.controller,
    }): super(key: key);

    @override
    State<LidarrCatalogueHideButton> createState() => _State();
}

class _State extends State<LidarrCatalogueHideButton> {    
    @override
    Widget build(BuildContext context) => LSCard(
        child: Consumer<LidarrModel>(
            builder: (context, model, widget) => InkWell(
                child: LSIconButton(
                    icon: model.hideUnmonitoredArtists
                        ? Icons.visibility_off
                        : Icons.visibility,
                ),
                onTap: () => model.hideUnmonitoredArtists = !model.hideUnmonitoredArtists,
                borderRadius: BorderRadius.circular(Constants.UI_BORDER_RADIUS),
            ),
        ),
        margin: EdgeInsets.fromLTRB(0.0, 0.0, 12.0, 12.0),
        color: Theme.of(context).canvasColor,
    );
}
