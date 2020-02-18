import 'package:flutter/material.dart';
import 'package:lunasea/system.dart';
import 'package:lunasea/routes/radarr/subpages/details/release.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/widgets/ui.dart';

class RadarrReleases extends StatefulWidget {
    final GlobalKey<ScaffoldState> scaffoldKey;
    final RadarrCatalogueEntry entry;

    RadarrReleases({
        Key key,
        @required this.entry,
        @required this.scaffoldKey,
    }): super(key: key);

    State<RadarrReleases> createState() {
        return _State();
    }
}

class _State extends State<RadarrReleases> {
    bool _searched = false;
    List<RadarrReleaseEntry> _entries;
    String _message = 'Please Search for Releases';

    @override
    void initState() {
        super.initState();
    }

    @override
    Widget build(BuildContext context) {
        return _buildReleases();
    }

    Future<void> _startManualSearch() async {
        if(mounted) {
            setState(() {
                _message = 'Searching...';
                _entries = [];
                _searched = true;
            });
        }
        _entries = await RadarrAPI.getReleases(widget.entry.movieID);
        if(mounted) {
            setState(() {
                _message = _entries == null ? 'Connection Error' : 'No Releases Found';
            });
        }
    }

    Future<void> _startAutomaticSearch() async {
        if(await RadarrAPI.automaticSearchMovie(widget.entry.movieID)) {
            Notifications.showSnackBar(widget.scaffoldKey, 'Searching for ${widget.entry.title}...');
        } else {
            Notifications.showSnackBar(widget.scaffoldKey, 'Failed to search for ${widget.entry.title}...');
        }
    }

    Widget _buildAutomaticSearchButton() {
        return Elements.getButton('Automatic Search', () async {
            _startAutomaticSearch();
        });
    }

    Widget _buildManualSearchButton() {
        return Elements.getButton('Manual Search', () async {
            _startManualSearch();
        }, backgroundColor: Colors.orange);
    }

    Widget _buildReleases() {
        return Scrollbar(
            child: ListView.builder(
                itemCount: _entries == null || _entries.length == 0 ? _searched ? 4 : 2 : _entries.length+3,
                itemBuilder: (context, index) {
                    switch(index) {
                        case 0: return _buildAutomaticSearchButton();
                        case 1: return _buildManualSearchButton();
                        case 2: return Elements.getDivider();
                    }
                    return _entries == null || _entries.length == 0 ?
                        Notifications.centeredMessage(_message) :
                        _buildEntry(_entries[index-3]);
                },
                padding: Elements.getListViewPadding(extraBottom: true),
            ),
        );
    }

    Widget _buildEntry(RadarrReleaseEntry release) {
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
                                text: '${release?.size?.lsBytes_BytesToString() ?? 'Unknown'}',
                            ),
                        ]
                    ),
                ),
                trailing: InkWell(
                    child: IconButton(
                        icon: release.approved ? (
                            Elements.getIcon(Icons.file_download) 
                        ) : (
                            Icon(
                                Icons.report,
                                color: Colors.red,
                            )
                        ),
                        onPressed: () async {
                            if(release.approved) {
                                if(await _startDownload(release.guid, release.indexerId)) {
                                    Notifications.showSnackBar(widget.scaffoldKey, 'Download starting...');
                                } else {
                                    Notifications.showSnackBar(widget.scaffoldKey, 'Failed to start download');
                                }
                            } else {
                                await _showWarnings(release);
                            }
                        },
                    ),
                    onLongPress: () async {
                        if(!release.approved) {
                            List<dynamic> values = await RadarrDialogs.showDownloadWarningPrompt(context);
                            if(values[0]) {
                                if(await _startDownload(release.guid, release.indexerId)) {
                                    Notifications.showSnackBar(widget.scaffoldKey, 'Download starting...');
                                } else {
                                    Notifications.showSnackBar(widget.scaffoldKey, 'Failed to start download');
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
        return await RadarrAPI.downloadRelease(guid, indexerId);
    }

    Future<void> _showWarnings(RadarrReleaseEntry release) async {
        String reject = '';
        for(var i=0; i<release.rejections.length; i++) {
            reject += '${i+1}. ${release.rejections[i]}\n';
        }
        await SystemDialogs.showTextPreviewPrompt(context, 'Rejection Reasons', reject.substring(0, reject.length-1));
    }

    Future<void> _enterDetails(RadarrReleaseEntry release) async {
        await Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => RadarrReleaseInfo(entry: release),
            ),
        );
    }
}
