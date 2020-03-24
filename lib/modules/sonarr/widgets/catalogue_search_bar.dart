import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import '../../sonarr.dart';

class SonarrCatalogueSearchBar extends StatefulWidget {
    @override
    State<SonarrCatalogueSearchBar> createState() => _State();
}

class _State extends State<SonarrCatalogueSearchBar> {
    final _textController = TextEditingController();
    
    @override
    Widget build(BuildContext context) => Expanded(
        child: Consumer<SonarrModel>(
            builder: (context, model, widget) => LSTextInputBar(
                controller: _textController,
                labelText: 'Search Series...',
                onChanged: (value) => model.searchFilter = value,
            ),
        ),
    );
}