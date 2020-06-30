import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrCatalogueSearchBar extends StatefulWidget {
    final String prefill;

    SonarrCatalogueSearchBar({
        Key key,
        this.prefill = '',
    }): super(key: key);

    @override
    State<SonarrCatalogueSearchBar> createState() => _State();
}

class _State extends State<SonarrCatalogueSearchBar> {
    final _textController = TextEditingController();

    void initState() {
        super.initState();
        _textController.text = widget.prefill ?? '';
    }
    
    @override
    Widget build(BuildContext context) => Expanded(
        child: Consumer<SonarrModel>(
            builder: (context, model, widget) => LSTextInputBar(
                controller: _textController,
                labelText: 'Search Series...',
                onChanged: (text, update) => _onChanged(model, text, update),
                margin: EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 12.0),
            ),
        ),
    );

    void _onChanged(SonarrModel model, String text, bool update) {
        model.searchCatalogueFilter = text;
        if(update) _textController.text = '';
    }
}
