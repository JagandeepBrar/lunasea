import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sabnzbd.dart';

class SABnzbdHistoryHideButton extends StatefulWidget {
    final ScrollController controller;

    SABnzbdHistoryHideButton({
        Key key,
        @required this.controller,
    }): super(key: key);

    @override
    State<SABnzbdHistoryHideButton> createState() => _State();
}

class _State extends State<SABnzbdHistoryHideButton> {    
    @override
    Widget build(BuildContext context) => LunaCard(
        context: context,
        child: Consumer<SABnzbdState>(
            builder: (context, model, widget) => LunaIconButton(
                icon: model.historyHideFailed
                    ? Icons.visibility_off
                    : Icons.visibility,
                onPressed: () => model.historyHideFailed = !model.historyHideFailed,
            ),
        ),
        height: LunaTextInputBar.appBarInnerHeight,
        width: LunaTextInputBar.appBarInnerHeight,
        margin: EdgeInsets.only(left: 12.0),
        color: Theme.of(context).canvasColor,
    );
}
