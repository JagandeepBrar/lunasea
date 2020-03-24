import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class SABnzbdHistoryDetails extends StatefulWidget {
    final SABnzbdAPI api = SABnzbdAPI.from(Database.currentProfileObject);
    final SABnzbdHistoryEntry entry;

    SABnzbdHistoryDetails({
        Key key,
        @required this.entry,
    }) : super(key: key);

    @override
    State<SABnzbdHistoryDetails> createState() {
        return _State();
    }
}

class _State extends State<SABnzbdHistoryDetails> {
    final _scaffoldKey = GlobalKey<ScaffoldState>();

    @override
    void initState() {
        super.initState();
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            key: _scaffoldKey,
            appBar: LSAppBar(title: 'Job History Details'),
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
                List<dynamic> values = await SABnzbdDialogs.showDeleteHistoryPrompt(context);
                if(values[0]) {
                    if(await widget.api.deleteHistory(widget.entry.nzoId)) {
                        Navigator.of(context).pop(['delete']);
                    } else {
                        Notifications.showSnackBar(_scaffoldKey, 'Failed to delete history entry');
                    }
                }
            },
        );
    }

    Widget _buildList() {
        return Scrollbar(
            child: ListView(
                children: <Widget>[
                    _buildStatusCategory(),
                    _buildAgeSize(),
                    ..._buildPathStages(),
                ],
                padding: Elements.getListViewPadding(extraBottom: true),
                physics: AlwaysScrollableScrollPhysics(),
            ),
        );
    }

    Widget _buildAgeSize() {
        return Padding(
            child: Row(
                children: <Widget>[
                    Expanded(
                        child: Card(
                            child: Padding(
                                child: Column(
                                    children: <Widget>[
                                        Elements.getTitle('Age'),
                                        Elements.getSubtitle('${widget.entry.completeTimeString}' ?? 'Unknown', preventOverflow: true),
                                    ],
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                            ),
                            margin: EdgeInsets.all(6.0),
                            elevation: 2.0,
                        ),
                    ),
                    Expanded(
                        child: Card(
                            child: Padding(
                                child: Column(
                                    children: <Widget>[
                                        Elements.getTitle('Size'),
                                        Elements.getSubtitle('${widget.entry.sizeReadable}', preventOverflow: true),
                                    ],
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                            ),
                            margin: EdgeInsets.all(6.0),
                            elevation: 2.0,
                        ),
                    ),
                ],
            ),
            padding: EdgeInsets.symmetric(horizontal: 6.0),
        );
    }

    Widget _buildStatusCategory() {
        return Padding(
            child: Row(
                children: <Widget>[
                    Expanded(
                        child: Card(
                            child: Padding(
                                child: Column(
                                    children: <Widget>[
                                        Elements.getTitle('Status'),
                                        Elements.getSubtitle(widget.entry.status ?? 'Unknown', preventOverflow: true),
                                    ],
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                            ),
                            margin: EdgeInsets.all(6.0),
                            elevation: 2.0,
                        ),
                    ),
                    Expanded(
                        child: Card(
                            child: Padding(
                                child: Column(
                                    children: <Widget>[
                                        Elements.getTitle('Category'),
                                        Elements.getSubtitle(widget.entry.category, preventOverflow: true),
                                    ],
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                            ),
                            margin: EdgeInsets.all(6.0),
                            elevation: 2.0,
                        ),
                    ),
                ],
            ),
            padding: EdgeInsets.symmetric(horizontal: 6.0),
        );
    }

    List<Widget> _buildPathStages() {
        return [
            Card(
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
                elevation: 2.0,
            ),
            for(var stage in widget.entry.stageLog)
                Card(
                    child: ListTile(
                        title: Elements.getTitle('${stage['name']} Stage'),
                        subtitle: Elements.getSubtitle('${stage['actions'][0].replaceAll('<br/>', '.\n')}', preventOverflow: true),
                        onTap: () async {
                            String data = stage['actions'].join(',\n').replaceAll('<br/>', '.\n');
                            await SystemDialogs.showTextPreviewPrompt(context, '${stage['name']} Stage', data);
                        },
                        trailing: IconButton(
                            icon: Elements.getIcon(Icons.arrow_forward_ios),
                            onPressed: null,
                        ),
                    ),
                    margin: Elements.getCardMargin(),
                    elevation: 2.0,
                )
        ];
    }
}