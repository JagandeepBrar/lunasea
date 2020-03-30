import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import '../../nzbget.dart';

class NZBGetHistoryHideButton extends StatefulWidget {
    @override
    State<NZBGetHistoryHideButton> createState() => _State();
}

class _State extends State<NZBGetHistoryHideButton> {    
    @override
    Widget build(BuildContext context) => LSCard(
        child: Padding(
            child: Consumer<NZBGetModel>(
                builder: (context, model, widget) => LSIconButton(
                    icon: model.historyHideFailed ? Icons.visibility_off : Icons.visibility,
                    onPressed: () => model.historyHideFailed = !model.historyHideFailed,
                ), 
            ),
            padding: EdgeInsets.all(1.70),
        ),
        color: LSColors.primary,
        margin: EdgeInsets.fromLTRB(0.0, 0.0, 12.0, 12.0),
    );
}