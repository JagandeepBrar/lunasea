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
        child: Padding(
            child: Consumer<LidarrModel>(
                builder: (context, model, widget) => LSIconButton(
                    icon: model.hideUnmonitoredArtists ? Icons.visibility_off : Icons.visibility,
                    onPressed: () => model.hideUnmonitoredArtists = !model.hideUnmonitoredArtists,
                ), 
            ),
            padding: EdgeInsets.all(1.0),
        ),
        margin: EdgeInsets.fromLTRB(0.0, 0.0, 12.0, 12.0),
        color: Theme.of(context).canvasColor,
    );
}
