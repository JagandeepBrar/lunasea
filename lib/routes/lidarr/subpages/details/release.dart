import 'package:flutter/material.dart';
import 'package:lunasea/system.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/widgets/ui.dart';

class LidarrReleaseInfo extends StatefulWidget {
    final LidarrAPI api = LidarrAPI.from(Database.currentProfileObject);
    final LidarrReleaseEntry entry;

    LidarrReleaseInfo({
        Key key,
        @required this.entry,
    }) : super(key: key);

    @override
    State<LidarrReleaseInfo> createState() {
        return _State();
    }
}

class _State extends State<LidarrReleaseInfo> {
    final _scaffoldKey = GlobalKey<ScaffoldState>();

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            key: _scaffoldKey,
            appBar: _buildAppBar(),
            body: _buildList(),
            floatingActionButton: _buildFloatingActionButton(),
        );
    }

    Widget _buildFloatingActionButton() {
        return Column(
            children: <Widget>[
                if(!widget.entry.approved) Padding(
                    child: FloatingActionButton(
                        heroTag: null,
                        child: Elements.getIcon(Icons.report),
                        tooltip: 'Rejection Reasons',
                        backgroundColor: Colors.red,
                        onPressed: () async {
                            await _showWarnings(widget.entry);
                        },
                    ),
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                ),
                FloatingActionButton(
                    heroTag: null,
                    tooltip: 'Start Download',
                    child: Elements.getIcon(Icons.cloud_download),
                    onPressed: () async {
                        if(widget.entry.approved) {
                            await _startDownload(widget.entry.guid, widget.entry.indexerId);
                        } else {
                            List<dynamic> values = await LidarrDialogs.showDownloadWarningPrompt(context);
                            if(values[0]) {
                                await _startDownload(widget.entry.guid, widget.entry.indexerId);
                            }
                        }
                    },
                ),
            ],
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
        );
    }

    Widget _buildAppBar() {
        return AppBar(
            title: Text(
                'Release Details',
                style: TextStyle(
                    letterSpacing: Constants.UI_LETTER_SPACING,
                ),
            ),
            centerTitle: false,
            elevation: 0,
            backgroundColor: Color(Constants.SECONDARY_COLOR),
            actions: <Widget>[
                IconButton(
                    icon: Icon(Icons.link),
                    tooltip: 'Open Information URL',
                    onPressed: () async {
                        if(widget.entry.infoUrl != null && widget.entry.infoUrl != '') {
                            await widget?.entry?.infoUrl?.lsLinks_OpenLink();
                        } else {
                            Notifications.showSnackBar(_scaffoldKey, 'No URL available');
                        }
                    },
                ),
            ],
        );
    }

    Widget _buildList() {
        return Scrollbar(
            child: ListView(
                children: <Widget>[
                    Card(
                        child: ListTile(
                            title: Elements.getTitle('Release Title'),
                            subtitle: Elements.getSubtitle(widget.entry.title, preventOverflow: true),
                            onTap: () async {
                                SystemDialogs.showTextPreviewPrompt(context, 'Release Title', widget.entry.title);
                            },
                            trailing: IconButton(
                                icon: Elements.getIcon(Icons.arrow_forward_ios),
                                onPressed: null,
                            ),
                        ),
                        margin: Elements.getCardMargin(),
                        elevation: 4.0,
                    ),
                    _buildIndexerProtocol(),
                    _buildAgeSize(),
                    widget.entry.isTorrent ? _buildSeedersLeechers() : Container(),
                ],
                padding: Elements.getListViewPadding(extraBottom: true),
            ),
        );
    }

    Widget _buildIndexerProtocol() {
        return Padding(
            child: Row(
                children: <Widget>[
                    Expanded(
                        child: Card(
                            child: Padding(
                                child: Column(
                                    children: <Widget>[
                                        Elements.getTitle('Protocol'),
                                        Elements.getSubtitle(widget?.entry?.protocol?.lsLanguage_Capitalize(), preventOverflow: true),
                                    ],
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
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
                                        Elements.getTitle('Indexer'),
                                        Elements.getSubtitle(widget.entry.indexer, preventOverflow: true),
                                    ],
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
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
                                        Elements.getSubtitle(widget?.entry?.ageHours?.lsTime_releaseAgeString(), preventOverflow: true),
                                    ],
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
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
                                        Elements.getSubtitle(widget.entry.size?.lsBytes_BytesToString(), preventOverflow: true),
                                    ],
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
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

    Widget _buildSeedersLeechers() {
        return Padding(
            child: Row(
                children: <Widget>[
                    Expanded(
                        child: Card(
                            child: Padding(
                                child: Column(
                                    children: <Widget>[
                                        Elements.getTitle('Seeders'),
                                        Elements.getSubtitle('${widget.entry.seeders} Seeders', preventOverflow: true),
                                    ],
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
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
                                        Elements.getTitle('Leechers'),
                                        Elements.getSubtitle('${widget.entry.leechers} Leechers', preventOverflow: true),
                                    ],
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
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

    Future<void> _showWarnings(LidarrReleaseEntry release) async {
        String reject = '';
        for(var i=0; i<release.rejections.length; i++) {
            reject += '${i+1}. ${release.rejections[i]}\n';
        }
        await SystemDialogs.showTextPreviewPrompt(context, 'Rejection Reasons', reject.substring(0, reject.length-1));
    }

    Future<void> _startDownload(String guid, int indexerId) async {
        if(await widget.api.downloadRelease(guid, indexerId)) {
            Notifications.showSnackBar(_scaffoldKey, 'Download starting...');
        } else {
            Notifications.showSnackBar(_scaffoldKey, 'Failed to start download');
        }
    }
}
