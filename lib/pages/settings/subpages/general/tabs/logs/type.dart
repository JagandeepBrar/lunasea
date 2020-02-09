import 'package:flutter/material.dart';
import 'package:lunasea/pages/settings/subpages/general/tabs/logs/view.dart';
import 'package:lunasea/core.dart';

class TypeLogs extends StatefulWidget {
    @override
    State<TypeLogs> createState() {
        return _State();
    }
}

class _State extends State<TypeLogs> {
    final _scaffoldKey = GlobalKey<ScaffoldState>();

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            key: _scaffoldKey,
            appBar: Navigation.getAppBar('Log Types', context),
            body: _buildList(),
        );
    }

    Widget _buildList() {
        return Scrollbar(
            child: ListView(
                children: <Widget>[
                    Card(
                        child: ListTile(
                            title: Elements.getTitle('All Logs'),
                            subtitle: Elements.getSubtitle('View logs of all types'),
                            trailing: IconButton(
                                icon: Elements.getIcon(Icons.developer_mode),
                                onPressed: null,
                            ),
                            onTap: () async {
                                await _viewLogs('All');
                            },
                        ),
                        elevation: 4.0,
                        margin: Elements.getCardMargin(),
                    ),
                    Elements.getDivider(),
                    Card(
                        child: ListTile(
                            title: Elements.getTitle('Warning'),
                            subtitle: Elements.getSubtitle('View warning logs'),
                            trailing: IconButton(
                                icon: Elements.getIcon(Icons.warning),
                                onPressed: null,
                            ),
                            onTap: () async {
                                await _viewLogs('Warning');
                            },
                        ),
                        elevation: 4.0,
                        margin: Elements.getCardMargin(),
                    ),
                    Card(
                        child: ListTile(
                            title: Elements.getTitle('Error'),
                            subtitle: Elements.getSubtitle('View error logs'),
                            trailing: IconButton(
                                icon: Elements.getIcon(Icons.report),
                                onPressed: null,
                            ),
                            onTap: () async {
                                await _viewLogs('Error');
                            },
                        ),
                        elevation: 4.0,
                        margin: Elements.getCardMargin(),
                    ),
                    Card(
                        child: ListTile(
                            title: Elements.getTitle('Fatal'),
                            subtitle: Elements.getSubtitle('View fatal logs'),
                            trailing: IconButton(
                                icon: Elements.getIcon(Icons.new_releases),
                                onPressed: null,
                            ),
                            onTap: () async {
                                await _viewLogs('Fatal');
                            },
                        ),
                        elevation: 4.0,
                        margin: Elements.getCardMargin(),
                    ),
                ],
                padding: Elements.getListViewPadding(extraBottom: true),
            ),
        );
    }

    Future<void> _viewLogs(String type) async {
        await Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => ViewLogs(type: type),
            ),
        );
    }
}
