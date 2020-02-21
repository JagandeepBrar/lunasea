import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:intl/intl.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/system.dart';
import 'package:lunasea/widgets/ui.dart';

class SonarrSeriesSearchDetails extends StatefulWidget {
    final SonarrSearchEntry entry;
    final SonarrAPI api = SonarrAPI.from(Database.currentProfileObject);

    SonarrSeriesSearchDetails({
        Key key,
        @required this.entry,
    }): super(key: key);

    @override
    State<SonarrSeriesSearchDetails> createState() {
        return _State();
    }  
}

class _State extends State<SonarrSeriesSearchDetails> {
    final _scaffoldKey = GlobalKey<ScaffoldState>();

    List<SonarrQualityProfile> _qualityProfiles = [];
    List<SonarrRootFolder> _rootFolders = [];
    SonarrQualityProfile _qualityProfile;
    SonarrRootFolder _rootFolder;
    SonarrSeriesType _seriesType;
    bool monitored = true;
    bool seasonFolders = true;
    bool loading = true;

    @override
    void initState() {
        super.initState();
        _fetchData();
    }

    Future<void> _fetchData() async {
        if(mounted) {
            setState(() {
                loading = true;
            });
        }
        final profiles = await widget.api.getQualityProfiles();
        _qualityProfiles = profiles?.values?.toList();
        if(_qualityProfiles != null && _qualityProfiles.length != 0) {
            _qualityProfile = _qualityProfiles[0];
        }
        _rootFolders = await widget.api.getRootFolders();
        if(_rootFolders != null && _rootFolders.length != 0) {
            _rootFolder = _rootFolders[0];
        }
        _seriesType = SonarrSeriesType(Constants.sonarrSeriesTypes[2]);
        if(mounted) {
            setState(() {
                loading = false;
            });
        }
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            key: _scaffoldKey,
            appBar: _buildAppBar(),
            body: loading ? 
                Notifications.centeredMessage('Loading...') : 
                _qualityProfile == null || _rootFolder == null ?
                    Notifications.centeredMessage('Connection Error', showBtn: true, btnMessage: 'Refresh', onTapHandler: () async {_fetchData();}) :
                    _buildList(),
            floatingActionButton: loading ?
                null :
                _qualityProfile == null || _rootFolder == null ?
                    null :
                    _buildFloatingActionButton(),
        );
    }

    Widget _buildFloatingActionButton() {
        return Column(
            children: <Widget>[
                Padding(
                    child: FloatingActionButton(
                        heroTag: null,
                        tooltip: 'Add Series & Search',
                        backgroundColor: Colors.orange,
                        child: Elements.getIcon(Icons.search),
                        onPressed: () async { 
                            if(await widget.api.addSeries(widget.entry, _qualityProfile, _rootFolder, _seriesType, seasonFolders, monitored, search: true)) {
                                Navigator.of(context).pop(['series_added', widget.entry.title]);
                            } else {
                                Notifications.showSnackBar(_scaffoldKey, 'Failed to add series: Series might already exist in Sonarr');
                            }
                        },
                    ),
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                ),
                FloatingActionButton(
                    heroTag: null,
                    tooltip: 'Add Series',
                    child: Elements.getIcon(Icons.add),
                    onPressed: () async {
                        if(await widget.api.addSeries(widget.entry, _qualityProfile, _rootFolder, _seriesType, seasonFolders, monitored)) {
                            Navigator.of(context).pop(['series_added', widget.entry.title]);
                        } else {
                            Notifications.showSnackBar(_scaffoldKey, 'Failed to add series: Series might already exist in Sonarr');
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
                widget.entry.title,
                style: TextStyle(
                    letterSpacing: Constants.UI_LETTER_SPACING,
                ),
            ),
            centerTitle: false,
            elevation: 0,
            backgroundColor: Color(Constants.SECONDARY_COLOR),
            actions: widget.entry.tvdbId != null && widget.entry.tvdbId != 0 ? (
                <Widget>[
                    IconButton(
                        icon: Elements.getIcon(Icons.link),
                        tooltip: 'Open TheTVDB URL',
                        onPressed: () async {
                            await widget?.entry?.tvdbId?.toString()?.lsLinks_OpenTVDB();
                        },
                    )
                ]
            ) : (
                null
            ),
        );
    }

    Widget _buildList() {
        return Scrollbar(
            child: ListView(
                children: <Widget>[
                    _buildSummary(),
                    Elements.getDivider(),
                    Card(
                        child: ListTile(
                            title: Elements.getTitle('Monitored'),
                            subtitle: Elements.getSubtitle('Monitor series for new releases'),
                            trailing: Switch(
                                value: monitored,
                                onChanged: (value) {
                                    if(mounted) {
                                        setState(() {
                                            monitored = value;
                                        });
                                    }
                                },
                            ),
                        ),
                        margin: Elements.getCardMargin(),
                        elevation: 4.0,
                    ),
                    Card(
                        child: ListTile(
                            title: Elements.getTitle('Use Season Folders'),
                            subtitle: Elements.getSubtitle('Sort episodes into season folders'),
                            trailing: Switch(
                                value: seasonFolders,
                                onChanged: (value) {
                                    if(mounted) {
                                        setState(() {
                                            seasonFolders = value;
                                        });
                                    }
                                },
                            ),
                        ),
                        margin: Elements.getCardMargin(),
                        elevation: 4.0,
                    ),
                    Card(
                        child: ListTile(
                            title: Elements.getTitle('Root Folder'),
                            subtitle: Elements.getSubtitle(_rootFolder.path, preventOverflow: true),
                            trailing: IconButton(
                                icon: Elements.getIcon(Icons.arrow_forward_ios),
                                onPressed: null,
                            ),
                            onTap: () async {
                                List<dynamic> _values = await SonarrDialogs.showEditRootFolderPrompt(context, _rootFolders);
                                if(_values[0] && mounted) {
                                    setState(() {
                                        _rootFolder = _values[1];
                                    });
                                }
                            },
                        ),
                        margin: Elements.getCardMargin(),
                        elevation: 4.0,
                    ),
                    Card(
                        child: ListTile(
                            title: Elements.getTitle('Quality Profile'),
                            subtitle: Elements.getSubtitle(_qualityProfile.name, preventOverflow: true),
                            trailing: IconButton(
                                icon: Elements.getIcon(Icons.arrow_forward_ios),
                                onPressed: null,
                            ),
                            onTap: () async {
                                List<dynamic> _values = await SonarrDialogs.showEditQualityProfilePrompt(context, _qualityProfiles);
                                if(_values[0] && mounted) {
                                    setState(() {
                                        _qualityProfile = _values[1];
                                    });
                                }
                            },
                        ),
                        margin: Elements.getCardMargin(),
                        elevation: 4.0,
                    ),
                    Card(
                        child: ListTile(
                            title: Elements.getTitle('Series Type'),
                            subtitle: Elements.getSubtitle(toBeginningOfSentenceCase(_seriesType.type), preventOverflow: true),
                            trailing: IconButton(
                                icon: Elements.getIcon(Icons.arrow_forward_ios),
                                onPressed: null,
                            ),
                            onTap: () async {
                                List<dynamic> _values = await SonarrDialogs.showEditSeriesTypePrompt(context);
                                if(_values[0] && mounted) {
                                    setState(() {
                                        _seriesType = _values[1];
                                    });
                                }
                            },
                        ),
                        margin: Elements.getCardMargin(),
                        elevation: 4.0,
                    ),
                ],
                padding: Elements.getListViewPadding(),
            ),
        );
    }

    Widget _buildSummary() {
        return Card(
            child: InkWell(
                child: Row(
                    children: <Widget>[
                        widget.entry.posterURI != null && widget.entry.posterURI != '' ? (
                            ClipRRect(
                                child: Image(
                                    image: AdvancedNetworkImage(
                                        widget.entry.posterURI,
                                        useDiskCache: true,
                                        fallbackAssetImage: 'assets/images/secondary_color.png',
                                        loadFailedCallback: () {},
                                        retryLimit: 1,
                                    ),
                                    height: 100.0,
                                    fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                            )
                         ) : (
                            Container()
                         ),
                        Expanded(
                            child: Padding(
                                child: Text(
                                    '${widget.entry.overview}.\n\n\n',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 4,
                                    style: TextStyle(
                                        color: Colors.white,
                                    ),
                                ),
                                padding: EdgeInsets.all(16.0),
                            ),
                        ),
                    ],
                ),
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                onTap: () async {
                    await SystemDialogs.showTextPreviewPrompt(context, widget.entry.title, widget.entry.overview ?? 'No summary is available.');
                },
            ),
            margin: Elements.getCardMargin(),
            elevation: 4.0,
        );
    }
}
