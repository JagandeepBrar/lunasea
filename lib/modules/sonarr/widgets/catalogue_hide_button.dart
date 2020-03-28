import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import '../../sonarr.dart';

class SonarrCatalogueHideButton extends StatefulWidget {
    final ScrollController controller;

    SonarrCatalogueHideButton({
        Key key,
        @required this.controller,
    }): super(key: key);

    @override
    State<SonarrCatalogueHideButton> createState() => _State();
}

class _State extends State<SonarrCatalogueHideButton> {    
    @override
    Widget build(BuildContext context) => LSCard(
        child: Padding(
            child: Consumer<SonarrModel>(
                builder: (context, model, widget) => LSIconButton(
                    icon: model.hideUnmonitoredSeries ? Icons.visibility_off : Icons.visibility,
                    onPressed: () => model.hideUnmonitoredSeries = !model.hideUnmonitoredSeries,
                ), 
            ),
            padding: EdgeInsets.all(1.70),
        ),
        color: LSColors.primary,
        margin: EdgeInsets.fromLTRB(0.0, 0.0, 12.0, 12.0),
    );
}
