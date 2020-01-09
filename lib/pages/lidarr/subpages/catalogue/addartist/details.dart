import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:lunasea/logic/automation/lidarr.dart';
import 'package:lunasea/system/constants.dart';
import 'package:lunasea/system/functions.dart';
import 'package:lunasea/system/ui.dart';

class LidarrArtistSearchDetails extends StatefulWidget {
    final LidarrSearchEntry entry;
    LidarrArtistSearchDetails({Key key, @required this.entry}): super(key: key);

    @override
    State<LidarrArtistSearchDetails> createState() {
        return _State();
    }  
}

class _State extends State<LidarrArtistSearchDetails> {
    final _scaffoldKey = GlobalKey<ScaffoldState>();

    List<LidarrRootFolder> _rootFolders = [];
    List<LidarrQualityProfile> _qualityProfiles = [];
    List<LidarrMetadataProfile> _metadataProfiles = [];
    LidarrMetadataProfile _metadataProfile;
    LidarrQualityProfile _qualityProfile;
    LidarrRootFolder _rootFolder;
    bool _loading = true;
    bool _monitored = true;
    bool _albumFolders = true;

    @override
    void initState() {
        super.initState();
        _fetchData();
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            key: _scaffoldKey,
            appBar: _buildAppBar(),
            body: _loading ? 
                Notifications.centeredMessage('Loading...') : 
                _rootFolder == null || _qualityProfile == null || _metadataProfile == null ?
                    Notifications.centeredMessage('Connection Error', showBtn: true, btnMessage: 'Refresh', onTapHandler: () async {_fetchData();}) :
                    _buildList(),
            floatingActionButton: _loading ?
                null :
                _rootFolder == null || _qualityProfile == null || _metadataProfile == null ?
                    null :
                    _buildFloatingActionButton(),
        );
    }

    Future<void> _fetchData() async {
        if(mounted) {
            setState(() {
                _loading = true;
            });
        }
        _rootFolders = await LidarrAPI.getRootFolders();
        if(_rootFolders != null && _rootFolders.length != 0) {
            _rootFolder = _rootFolders[0];
        }
        final qprofiles = await LidarrAPI.getQualityProfiles();
        _qualityProfiles = qprofiles?.values?.toList();
        if(_qualityProfiles != null && _qualityProfiles.length != 0) {
            _qualityProfile = _qualityProfiles[0];
        }
        final mprofiles = await LidarrAPI.getMetadataProfiles();
        _metadataProfiles = mprofiles?.values?.toList();
        if(_metadataProfiles != null && _metadataProfiles.length != 0) {
            _metadataProfile = _metadataProfiles[0];
        }
        if(mounted) {
            setState(() {
                _loading = false;
            });
        }
    }

    Widget _buildFloatingActionButton() {
        return Column(
            children: <Widget>[
                Padding(
                    child: FloatingActionButton(
                        heroTag: null,
                        child: Elements.getIcon(Icons.search),
                        backgroundColor: Colors.orange,
                        tooltip: 'Add Artist & Search',
                        onPressed: () async {
                            if(await LidarrAPI.addArtist(widget.entry, _qualityProfile, _rootFolder, _metadataProfile, _monitored, _albumFolders, search: true)) {
                                Navigator.of(context).pop(['artist_added', widget.entry.title]);
                            } else {
                                Notifications.showSnackBar(_scaffoldKey, 'Failed to add artist: Artist might already exist in Lidarr');
                            }
                        },
                    ),
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                ),
                FloatingActionButton(
                    heroTag: null,
                    child: Elements.getIcon(Icons.add),
                    tooltip: 'Add Artist',
                    onPressed: () async {
                        if(await LidarrAPI.addArtist(widget.entry, _qualityProfile, _rootFolder, _metadataProfile, _monitored, _albumFolders)) {
                            Navigator.of(context).pop(['artist_added', widget.entry.title]);
                        } else {
                            Notifications.showSnackBar(_scaffoldKey, 'Failed to add artist: Artist might already exist in Lidarr');
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
                    letterSpacing: Constants.LETTER_SPACING,
                ),
            ),
            centerTitle: false,
            elevation: 0,
            backgroundColor: Color(Constants.SECONDARY_COLOR),
            actions: widget.entry.discogsLink != null && widget.entry.discogsLink != '' ? (
                <Widget>[
                    IconButton(
                        icon: Elements.getIcon(Icons.link),
                        tooltip: 'Open Discogs URL',
                        onPressed: () async {
                            await Functions.openURL(widget.entry.discogsLink);
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
                            subtitle: Elements.getSubtitle('Monitor artist for new releases'),
                            trailing: Switch(
                                value: _monitored,
                                onChanged: (value) {
                                    if(mounted) {
                                        setState(() {
                                            _monitored = value;
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
                            title: Elements.getTitle('Use Album Folders'),
                            subtitle: Elements.getSubtitle('Sort tracks into album folders'),
                            trailing: Switch(
                                value: _albumFolders,
                                onChanged: (value) {
                                    if(mounted) {
                                        setState(() {
                                            _albumFolders = value;
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
                                List<dynamic> _values = await LidarrDialogs.showEditRootFolderPrompt(context, _rootFolders);
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
                                List<dynamic> _values = await LidarrDialogs.showEditQualityProfilePrompt(context, _qualityProfiles);
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
                            title: Elements.getTitle('Metadata Profile'),
                            subtitle: Elements.getSubtitle(_metadataProfile.name, preventOverflow: true),
                            trailing: IconButton(
                                icon: Elements.getIcon(Icons.arrow_forward_ios),
                                onPressed: null,
                            ),
                            onTap: () async {
                                List<dynamic> _values = await LidarrDialogs.showEditMetadataProfilePrompt(context, _metadataProfiles);
                                if(_values[0] && mounted) {
                                    setState(() {
                                        _metadataProfile = _values[1];
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