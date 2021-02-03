import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/nzbget.dart';

class NZBGetHistoryHideButton extends StatefulWidget {
    @override
    State<NZBGetHistoryHideButton> createState() => _State();
}

class _State extends State<NZBGetHistoryHideButton> {    
    @override
    Widget build(BuildContext context) => LSCard(
        child: Consumer<NZBGetState>(
            builder: (context, model, widget) => LSIconButton(
                icon: model.historyHideFailed
                    ? Icons.visibility_off
                    : Icons.visibility,
                onPressed: () => model.historyHideFailed = !model.historyHideFailed,
            ),
        ),
        margin: EdgeInsets.fromLTRB(0.0, 0.0, 12.0, 12.0),
        color: Theme.of(context).canvasColor,
    );
}
