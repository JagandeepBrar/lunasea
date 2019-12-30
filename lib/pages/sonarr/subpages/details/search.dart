import 'package:flutter/material.dart';
import 'package:lunasea/logic/automation/sonarr.dart';
import 'package:lunasea/pages/sonarr/subpages/details/release.dart';
import 'package:lunasea/system/constants.dart';
import 'package:lunasea/system/functions.dart';
import 'package:lunasea/system/ui.dart';

class SonarrEpisodeSearch extends StatelessWidget {
    final SonarrEpisodeEntry entry;

    SonarrEpisodeSearch({
        Key key,
        @required this.entry,
    }) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return _SonarrEpisodeSearchWidget(entry: entry);
    }
}

class _SonarrEpisodeSearchWidget extends StatefulWidget {
    final SonarrEpisodeEntry entry;

    _SonarrEpisodeSearchWidget({
        Key key,
        @required this.entry,
    }) : super(key: key);

    @override
    State<StatefulWidget> createState() {
        return _SonarrSeasonDetailsState(entry: entry);
    }
}

class _SonarrSeasonDetailsState extends State<StatefulWidget> {
    final SonarrEpisodeEntry entry;
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    final _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
    bool _loading = true;
    List<SonarrReleaseEntry> _entries;

    _SonarrSeasonDetailsState({
        Key key,
        @required this.entry,
    });

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
            appBar: Navigation.getAppBar('Releases', context),
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
        _entries = await SonarrAPI.getReleases(entry.episodeID);
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

    Widget _buildEntry(SonarrReleaseEntry release) {
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
                            Elements.getIcon(
                                Icons.report,
                                color: Colors.red,
                            )
                        ),
                        onPressed: () async {
                            if(release.approved) {
                                if(await _startDownload(release.guid, release.indexerId)) {
                                    Notifications.showSnackBar(_scaffoldKey, 'Download starting...');
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
                            List<dynamic> values = await SonarrDialogs.showDownloadWarningPrompt(context);
                            if(values[0]) {
                                if(await _startDownload(release.guid, release.indexerId)) {
                                    Notifications.showSnackBar(_scaffoldKey, 'Download starting...');
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
        return await SonarrAPI.downloadRelease(guid, indexerId);
    }

    Future<void> _showWarnings(SonarrReleaseEntry release) async {
        String reject = '';
        for(var i=0; i<release.rejections.length; i++) {
            reject += '${i+1}. ${release.rejections[i]}\n';
        }
        await SystemDialogs.showTextPreviewPrompt(context, 'Rejection Reasons', reject.substring(0, reject.length-1));
    }

    Future<void> _enterDetails(SonarrReleaseEntry release) async {
        await Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => SonarrReleaseInfo(entry: release),
            ),
        );
    }
}
