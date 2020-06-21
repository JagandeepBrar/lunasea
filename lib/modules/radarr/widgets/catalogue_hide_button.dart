import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrCatalogueHideButton extends StatefulWidget {
    final ScrollController controller;

    RadarrCatalogueHideButton({
        Key key,
        @required this.controller,
    }): super(key: key);

    @override
    State<RadarrCatalogueHideButton> createState() => _State();
}

class _State extends State<RadarrCatalogueHideButton> {    
    @override
    Widget build(BuildContext context) => LSCard(
        child: Consumer<RadarrModel>(
            builder: (context, model, widget) => InkWell(
                child: LSIconButton(
                    icon: model.hideUnmonitoredMovies
                        ? Icons.visibility_off
                        : Icons.visibility,
                ),
                onTap: () => model.hideUnmonitoredMovies = !model.hideUnmonitoredMovies,
                borderRadius: BorderRadius.circular(Constants.UI_BORDER_RADIUS),
            ),
        ),
        margin: EdgeInsets.fromLTRB(0.0, 0.0, 12.0, 12.0),
        color: Theme.of(context).canvasColor,
    );
}