import 'package:flutter/material.dart';
import 'package:lunasea/logic/automation/radarr.dart';
import 'package:lunasea/system/constants.dart';
import 'package:lunasea/system/functions.dart';
import 'package:lunasea/system/ui.dart';

class RadarrReleaseInfo extends StatelessWidget {
    final RadarrReleaseEntry entry;

    RadarrReleaseInfo({
        Key key,
        @required this.entry,
    }) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return _RadarrReleaseInfoWidget(entry: entry);
    }
}

class _RadarrReleaseInfoWidget extends StatefulWidget {
    final RadarrReleaseEntry entry;

    _RadarrReleaseInfoWidget({
        Key key,
        @required this.entry,
    }) : super(key: key);

    @override
    State<StatefulWidget> createState() {
        return _RadarrReleaseInfoState(entry: entry);
    }
}

class _RadarrReleaseInfoState extends State<StatefulWidget> {
    final RadarrReleaseEntry entry;
    final _scaffoldKey = GlobalKey<ScaffoldState>();

    _RadarrReleaseInfoState({
        Key key,
        @required this.entry,
    });

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
                if(!entry.approved) Padding(
                    child: FloatingActionButton(
                        heroTag: null,
                        child: Elements.getIcon(Icons.report),
                        tooltip: 'Rejection Reasons',
                        backgroundColor: Colors.red,
                        onPressed: () async {
                            await _showWarnings(entry);
                        },
                    ),
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                ),
                FloatingActionButton(
                    heroTag: null,
                    tooltip: 'Start Download',
                    child: Elements.getIcon(Icons.cloud_download),
                    onPressed: () async {
                        if(entry.approved) {
                            await _startDownload(entry.guid, entry.indexerId);
                        } else {
                            List<dynamic> values = await RadarrDialogs.showDownloadWarningPrompt(context);
                            if(values[0]) {
                                await _startDownload(entry.guid, entry.indexerId);
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
                    letterSpacing: Constants.LETTER_SPACING,
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
                        if(entry.infoUrl != null && entry.infoUrl != '') {
                            Functions.openURL(entry.infoUrl);
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
                            subtitle: Elements.getSubtitle(entry.title, preventOverflow: true),
                            onTap: () async {
                                SystemDialogs.showTextPreviewPrompt(context, 'Release Title', entry.title);
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
                    entry.isTorrent ? _buildSeedersLeechers() : Container(),
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
                                        Elements.getSubtitle(Functions.toCapitalize(entry.protocol), preventOverflow: true),
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
                                        Elements.getSubtitle(entry.indexer, preventOverflow: true),
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
                                        Elements.getSubtitle(Functions.hoursReadable(entry.ageHours), preventOverflow: true),
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
                                        Elements.getSubtitle(Functions.bytesToReadable(entry.size), preventOverflow: true),
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
                                        Elements.getSubtitle('${entry.seeders} Seeders', preventOverflow: true),
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
                                        Elements.getSubtitle('${entry.leechers} Leechers', preventOverflow: true),
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

    Future<void> _showWarnings(RadarrReleaseEntry release) async {
        String reject = '';
        for(var i=0; i<release.rejections.length; i++) {
            reject += '${i+1}. ${release.rejections[i]}\n';
        }
        await SystemDialogs.showTextPreviewPrompt(context, 'Rejection Reasons', reject.substring(0, reject.length-1));
    }

    Future<void> _startDownload(String guid, int indexerId) async {
        if(await RadarrAPI.downloadRelease(guid, indexerId)) {
            Notifications.showSnackBar(_scaffoldKey, 'Download starting...');
        } else {
            Notifications.showSnackBar(_scaffoldKey, 'Failed to start download');
        }
    }
}
