import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/widgets/ui.dart';

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
            appBar: LSAppBar('Job History Details'),
            floatingActionButton: _buildFloatingActionButton(),
            body: _buildList(),
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

    Widget _buildList() {
        return Scrollbar(
            child: ListView(
                children: <Widget>[
                    _buildStatusAge(),
                    _buildCategorySize(),
                    _buildSpeedHealth(),
                    _buildStorageLocation(),
                ],
                padding: Elements.getListViewPadding(extraBottom: true),
                physics: AlwaysScrollableScrollPhysics(),
            ),
        );
    }

    Widget _buildStatusAge() {
        return Padding(
            child: Row(
                children: <Widget>[
                    Expanded(
                        child: Card(
                            child: Padding(
                                child: Column(
                                    children: <Widget>[
                                        Elements.getTitle('Status'),
                                        Elements.getSubtitle(widget.entry.statusString ?? 'Unknown', preventOverflow: true),
                                    ],
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                            ),
                            margin: EdgeInsets.all(6.0),
                            elevation: 4.0,
                        ),
                    ),
                    Expanded(
                        child: Card(
                            child: Padding(
                                child: Column(
                                    children: <Widget>[
                                        Elements.getTitle('Age'),
                                        Elements.getSubtitle(widget.entry.completeTime, preventOverflow: true),
                                    ],
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                            ),
                            margin: EdgeInsets.all(6.0),
                            elevation: 4.0,
                        ),
                    ),
                ],
            ),
            padding: EdgeInsets.symmetric(horizontal: 6.0),
        );
    }

    Widget _buildCategorySize() {
        return Padding(
            child: Row(
                children: <Widget>[
                    Expanded(
                        child: Card(
                            child: Padding(
                                child: Column(
                                    children: <Widget>[
                                        Elements.getTitle('Category'),
                                        Elements.getSubtitle(widget.entry.category == '' ? 'No Category' : widget.entry.category, preventOverflow: true),
                                    ],
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                            ),
                            margin: EdgeInsets.all(6.0),
                            elevation: 4.0,
                        ),
                    ),
                    Expanded(
                        child: Card(
                            child: Padding(
                                child: Column(
                                    children: <Widget>[
                                        Elements.getTitle('Size'),
                                        Elements.getSubtitle(widget.entry.sizeReadable, preventOverflow: true),
                                    ],
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                            ),
                            margin: EdgeInsets.all(6.0),
                            elevation: 4.0,
                        ),
                    ),
                ],
            ),
            padding: EdgeInsets.symmetric(horizontal: 6.0),
        );
    }

    Widget _buildSpeedHealth() {
        return Padding(
            child: Row(
                children: <Widget>[
                    Expanded(
                        child: Card(
                            child: Padding(
                                child: Column(
                                    children: <Widget>[
                                        Elements.getTitle('Health'),
                                        Elements.getSubtitle(widget.entry.healthString, preventOverflow: true),
                                    ],
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                            ),
                            margin: EdgeInsets.all(6.0),
                            elevation: 4.0,
                        ),
                    ),
                    Expanded(
                        child: Card(
                            child: Padding(
                                child: Column(
                                    children: <Widget>[
                                        Elements.getTitle('Average Speed'),
                                        Elements.getSubtitle(widget.entry.downloadSpeed ?? 'Unknown', preventOverflow: true),
                                    ],
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                            ),
                            margin: EdgeInsets.all(6.0),
                            elevation: 4.0,
                        ),
                    ),
                ],
            ),
            padding: EdgeInsets.symmetric(horizontal: 6.0),
        );
    }

    Widget _buildStorageLocation() {
        return Card(
            child: ListTile(
                title: Elements.getTitle('Storage Location'),
                subtitle: Elements.getSubtitle(widget.entry.storageLocation, preventOverflow: true),
                onTap: () async {
                    await SystemDialogs.showTextPreviewPrompt(context, 'Storage Location', widget.entry.storageLocation);
                },
                trailing: IconButton(
                    icon: Elements.getIcon(Icons.arrow_forward_ios),
                    onPressed: null,
                ),
            ),
            margin: Elements.getCardMargin(),
            elevation: 4.0,
        );
    }
}
