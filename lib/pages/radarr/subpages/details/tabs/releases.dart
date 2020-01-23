import 'package:flutter/material.dart';
import 'package:lunasea/logic/automation/radarr.dart';
import 'package:lunasea/pages/radarr/subpages/details/release.dart';
import 'package:lunasea/system/constants.dart';
import 'package:lunasea/system/functions.dart';
import 'package:lunasea/system/ui.dart';

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
    final _searchController = TextEditingController();
    bool _searched = false;
    List<RadarrReleaseEntry> _entries;
    String _message = 'Please Search for Releases';

    @override
    void initState() {
        super.initState();
        String prefix = widget.entry.title.toLowerCase();
        _searchController.text = '$prefix full movie hd megaupload';
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
                itemCount: _entries == null || _entries.length == 0 ? _searched ? 5 : 3 : _entries.length+4,
                itemBuilder: (context, index) {
                    switch(index) {
                        case 0: return _buildSearchBar();
                        case 1: return _buildAutomaticSearchButton();
                        case 2: return _buildManualSearchButton();
                        case 3: return Elements.getDivider();
                    }
                    return _entries == null || _entries.length == 0 ?
                        Notifications.centeredMessage(_message) :
                        _buildEntry(_entries[index-4]);
                },
                padding: Elements.getListViewPadding(extraBottom: true),
            ),
        );
    }

    Widget _buildEntry(RadarrReleaseEntry release) {
        return Card(
            child: ListTile(
                title: Elements.getTitle(release.title),
                subtitle: Elements.getSubtitle(
                    '${Functions.toCapitalize(release.protocol)}' + 
                    '${release.isTorrent ? "\t•\t${release.seeders}/${release.leechers}" : ''}' +
                    '\t•\t${Functions.hoursReadable(release.ageHours) ?? 'Unknown'}\n' +
                    '${release.quality ?? 'Unknown'}\t•\t'+
                    '${Functions.bytesToReadable(release.size) ?? 'Unknown'}'
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

    Widget _buildSearchBar() {
        return Card(
                child: Padding(
                    child: TextField(
                        controller: _searchController,
                        readOnly: true,
                        decoration: InputDecoration(
                            labelText: 'Search...',
                            labelStyle: TextStyle(
                                color: Colors.white54,
                                decoration: TextDecoration.none,
                            ),
                            icon: Padding(
                                child: Icon(
                                    Icons.search,
                                    color: Color(Constants.ACCENT_COLOR),
                                ),
                                padding: EdgeInsets.fromLTRB(20.0, 8.0, 0.0, 8.0),
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(vertical: 8.0),
                        ),
                        style: TextStyle(
                            color: Colors.white,
                        ),
                        cursorColor: Color(Constants.ACCENT_COLOR),
                    ),
                padding: EdgeInsets.fromLTRB(0.0, 0.0, 16.0, 0.0),
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
