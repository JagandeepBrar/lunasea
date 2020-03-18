import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/widgets/ui.dart';

class RadarrCatalogueHideButton extends StatefulWidget {
    @override
    State<RadarrCatalogueHideButton> createState() => _State();
}

class _State extends State<RadarrCatalogueHideButton> {    
    @override
    Widget build(BuildContext context) => LSCard(
        child: Padding(
            child: Consumer<RadarrModel>(
                builder: (context, model, widget) => LSIconButton(
                    icon: model.hideUnmonitoredMovies ? Icons.visibility_off : Icons.visibility,
                    onPressed: () => model.hideUnmonitoredMovies = !model.hideUnmonitoredMovies,
                ), 
            ),
            padding: EdgeInsets.all(1.75),
        ),
        margin: EdgeInsets.fromLTRB(0.0, 0.0, 12.0, 0.0),
    );
}