import 'package:flutter/material.dart';
import 'package:lunasea/logic/clients/sabnzbd.dart';
import 'package:lunasea/system/ui.dart';

class SABnzbdHistoryDetails extends StatelessWidget {
    final SABnzbdHistoryEntry entry;

    SABnzbdHistoryDetails({
        Key key,
        @required this.entry,
    }) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return _SABnzbdHistoryDetailsWidget(
            entry: entry,
        );
    }
}

class _SABnzbdHistoryDetailsWidget extends StatefulWidget {
    final SABnzbdHistoryEntry entry;

    _SABnzbdHistoryDetailsWidget({
        Key key,
        @required this.entry,
    }) : super(key: key);

    @override
    State<StatefulWidget> createState() {
        return _SABnzbdHistoryDetailsState(
            entry: entry,
        );
    }
}

class _SABnzbdHistoryDetailsState extends State<StatefulWidget> {
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    final SABnzbdHistoryEntry entry;

    _SABnzbdHistoryDetailsState({
        Key key,
        @required this.entry,
    });

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
                    if(await SABnzbdAPI.deleteHistory(entry.nzoId)) {
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
                                        Elements.getSubtitle('${entry.completeTimeString}' ?? 'Unknown', preventOverflow: true),
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
                                        Elements.getSubtitle('${entry.sizeReadable}', preventOverflow: true),
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
                                        Elements.getSubtitle(entry.status ?? 'Unknown', preventOverflow: true),
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
                                        Elements.getTitle('Category'),
                                        Elements.getSubtitle(entry.category, preventOverflow: true),
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

    List<Widget> _buildPathStages() {
        return [
            Card(
                child: ListTile(
                    title: Elements.getTitle('Storage Location'),
                    subtitle: Elements.getSubtitle(entry.storageLocation, preventOverflow: true),
                    onTap: () async {
                        await SystemDialogs.showTextPreviewPrompt(context, 'Storage Location', entry.storageLocation);
                    },
                ),
                margin: Elements.getCardMargin(),
                elevation: 4.0,
            ),
            for(var stage in entry.stageLog)
                Card(
                    child: ListTile(
                        title: Elements.getTitle('${stage['name']} Stage'),
                        subtitle: Elements.getSubtitle('${stage['actions'][0].replaceAll('<br/>', '.\n')}', preventOverflow: true),
                        onTap: () async {
                            String data = stage['actions'].join(',\n').replaceAll('<br/>', '.\n');
                            await SystemDialogs.showTextPreviewPrompt(context, '${stage['name']} Stage', data);
                        },
                    ),
                    margin: Elements.getCardMargin(),
                    elevation: 4.0,
                )
        ];
    }
}