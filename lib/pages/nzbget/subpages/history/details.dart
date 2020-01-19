import 'package:flutter/material.dart';
import 'package:lunasea/logic/clients/nzbget.dart';
import 'package:lunasea/system/ui.dart';

class NZBGetHistoryDetails extends StatefulWidget {
    final NZBGetHistoryEntry entry;

    NZBGetHistoryDetails({
        Key key,
        @required this.entry,
    }) : super(key: key);

    @override
    State<NZBGetHistoryDetails> createState() {
        return _State();
    }
}

class _State extends State<NZBGetHistoryDetails> {
    final _scaffoldKey = GlobalKey<ScaffoldState>();

    @override
    void initState() {
        super.initState();
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            key: _scaffoldKey,
            appBar: Navigation.getAppBar('Job History Details', context),
            floatingActionButton: _buildFloatingActionButton(),
        );
    }

    Widget _buildFloatingActionButton() {
        return FloatingActionButton(
            heroTag: null,
            backgroundColor: Colors.red,
            child: Elements.getIcon(Icons.delete),
            onPressed: () async {
                List<dynamic> values = await NZBGetDialogs.showDeleteHistoryPrompt(context);
                if(values[0]) {
                    if(await NZBGetAPI.deleteHistoryEntry(widget.entry.id, hide: values[1])) {
                        Navigator.of(context).pop(['delete']);
                    } else {
                        Notifications.showSnackBar(_scaffoldKey, 'Failed to remove history entry');
                    }
                }
            },
        );
    }
}
