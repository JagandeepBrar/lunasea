import 'package:flutter/material.dart';
import 'package:lunasea/routes/lidarr/subpages/details/release.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/widgets/ui.dart';

class LidarrAlbumSearch extends StatefulWidget {
    final LidarrAPI api = LidarrAPI.from(Database.currentProfileObject);
    final int albumID;

    LidarrAlbumSearch({
        Key key,
        @required this.albumID,
    }) : super(key: key);

    @override
    State<LidarrAlbumSearch> createState() {
        return _State();
    }
}

class _State extends State<LidarrAlbumSearch> {
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    final _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

    bool _loading = true;
    List<LidarrReleaseEntry> _entries = [];

    @override
    void initState() {
        super.initState();
        Future.delayed(Duration(milliseconds: 200)).then((_) {
            if(mounted) {
                _refreshIndicatorKey?.currentState?.show();
            } 
        });
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            key: _scaffoldKey,
            appBar: LSAppBar(title: 'Releases'),
            body: RefreshIndicator(
                key: _refreshIndicatorKey,
                backgroundColor: Color(Constants.SECONDARY_COLOR),
                onRefresh: _handleRefresh,
                child: _loading ? 
                    Notifications.centeredMessage('Searching...') :
                    _entries == null ?
                        Notifications.centeredMessage('Connection Error', showBtn: true, btnMessage: 'Refresh', onTapHandler: () {_refreshIndicatorKey?.currentState?.show();}) : 
                        _entries.length == 0 ? 
                            Notifications.centeredMessage('No Releases Found', showBtn: true, btnMessage: 'Refresh', onTapHandler: () {_refreshIndicatorKey?.currentState?.show();}) :
                            _buildList(),
            ),
        );
    }

    Future<void> _handleRefresh() async {
        if(mounted) {
            setState(() {
                _loading = true;
            });
        }
        _entries = await widget.api.getReleases(widget.albumID);
        if(mounted) {
            setState(() {
                _loading = false;
            });
        }
    }

    Widget _buildList() {
        return Scrollbar(
            child: ListView.builder(
                itemCount: _entries.length,
                itemBuilder: (context, index) {
                    return _buildEntry(_entries[index]);
                },
                padding: Elements.getListViewPadding(extraBottom: true),
                physics: AlwaysScrollableScrollPhysics(),
            ),
        );
    }

    Widget _buildEntry(LidarrReleaseEntry release) {
        return Card(
            child: ListTile(
                title: Elements.getTitle(release.title),
                subtitle: RichText(
                    text: TextSpan(
                        style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14.0,
                        ),
                        children: <TextSpan>[
                            TextSpan(
                                text: release?.protocol?.lsLanguage_Capitalize(),
                                style: TextStyle(
                                    color: release.isTorrent ? Colors.orange : Color(Constants.ACCENT_COLOR),
                                    fontWeight: FontWeight.bold,
                                ),
                            ),
                            if(release.isTorrent) TextSpan(
                                text: '${release.isTorrent ? " (${release.seeders}/${release.leechers})" : ''}',
                                style: TextStyle(
                                    color: Colors.orange,
                                    fontWeight: FontWeight.bold,
                                ),
                            ),
                            TextSpan(
                                text: '\t•\t${release?.ageHours?.lsTime_releaseAgeString() ?? 'Unknown'}\n',
                            ),
                            TextSpan(
                                text: '${release.quality ?? 'Unknown'}\t•\t',
                            ),
                            TextSpan(
                                text: '${release.size?.lsBytes_BytesToString() ?? 'Unknown'}',
                            ),
                        ]
                    ),
                ),
                trailing: InkWell(
                    child: IconButton(
                        icon: release.approved ? (
                            Elements.getIcon(Icons.file_download)
                        ) : (
                            Elements.getIcon(
                                Icons.report,
                                color: Colors.red,
                            )
                        ),
                        onPressed: () async {
                            if(release.approved) {
                                if(await _startDownload(release.guid, release.indexerId)) {
                                    Notifications.showSnackBar(_scaffoldKey, 'Downloading starting...');
                                } else {
                                    Notifications.showSnackBar(_scaffoldKey, 'Failed to start download');
                                }
                            } else {
                                await _showWarnings(release);
                            }
                        },
                    ),
                    onLongPress: () async {
                        if(!release.approved) {
                            List<dynamic> values = await LidarrDialogs.showDownloadWarningPrompt(context);
                            if(values[0]) {
                                if(await _startDownload(release.guid, release.indexerId)) {
                                    Notifications.showSnackBar(_scaffoldKey, 'Downloading starting...');
                                } else {
                                    Notifications.showSnackBar(_scaffoldKey, 'Failed to start download');
                                }
                            }
                        }
                    },
                ),
                onTap: () async {
                    _enterDetails(release);
                },
                contentPadding: Elements.getContentPadding(),
            ),
            margin: Elements.getCardMargin(),
            elevation: 4.0,
        );
    }

    Future<bool> _startDownload(String guid, int indexerId) async {
        return await widget.api.downloadRelease(guid, indexerId);
    }

    Future<void> _showWarnings(LidarrReleaseEntry release) async {
        String reject = '';
        for(var i=0; i<release.rejections.length; i++) {
            reject += '${i+1}. ${release.rejections[i]}\n';
        }
        await SystemDialogs.showTextPreviewPrompt(context, 'Rejection Reasons', reject.substring(0, reject.length-1));
    }

    Future<void> _enterDetails(LidarrReleaseEntry release) async {
        await Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => LidarrReleaseInfo(entry: release),
            ),
        );
    }
}
