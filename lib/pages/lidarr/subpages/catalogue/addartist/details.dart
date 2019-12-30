import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:lunasea/logic/automation/lidarr.dart';
import 'package:lunasea/system/constants.dart';
import 'package:lunasea/system/functions.dart';
import 'package:lunasea/system/ui.dart';

class LidarrArtistSearchDetails extends StatelessWidget {
    final LidarrSearchEntry entry;
    LidarrArtistSearchDetails({Key key, @required this.entry}): super(key: key);

    @override
    Widget build(BuildContext context) {
        return _LidarrArtistSearchDetailsWidget(entry: entry);
    }
}

class _LidarrArtistSearchDetailsWidget extends StatefulWidget {
    final LidarrSearchEntry entry;
    _LidarrArtistSearchDetailsWidget({Key key, @required this.entry}): super(key: key);

    @override
    State<StatefulWidget> createState() {
        return _LidarrArtistSearchDetailsState(entry: entry);
    }  
}

class _LidarrArtistSearchDetailsState extends State<StatefulWidget> {
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    final LidarrSearchEntry entry;

    List<LidarrRootFolder> _rootFolders = [];
    List<LidarrQualityProfile> _qualityProfiles = [];
    List<LidarrMetadataProfile> _metadataProfiles = [];
    LidarrMetadataProfile _metadataProfile;
    LidarrQualityProfile _qualityProfile;
    LidarrRootFolder _rootFolder;
    bool _loading = true;
    bool _monitored = true;
    bool _albumFolders = true;

    _LidarrArtistSearchDetailsState({Key key, @required this.entry});

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
        return FloatingActionButton(
            heroTag: null,
            child: Elements.getIcon(Icons.add),
            tooltip: 'Add Artist',
            onPressed: () async {
                if(await LidarrAPI.addArtist(entry, _qualityProfile, _rootFolder, _metadataProfile, _monitored, _albumFolders)) {
                    Navigator.of(context).pop(['artist_added', entry.title]);
                } else {
                    Notifications.showSnackBar(_scaffoldKey, 'Failed to add artist: Artist might already exist in Lidarr');
                }
            },
        );
    }

    Widget _buildAppBar() {
        return AppBar(
            title: Text(
                entry.title,
                style: TextStyle(
                    letterSpacing: Constants.LETTER_SPACING,
                ),
            ),
            centerTitle: false,
            elevation: 0,
            backgroundColor: Color(Constants.SECONDARY_COLOR),
            actions: entry.discogsLink != null && entry.discogsLink != '' ? (
                <Widget>[
                    IconButton(
                        icon: Elements.getIcon(Icons.link),
                        tooltip: 'Open Discogs URL',
                        onPressed: () async {
                            await Functions.openURL(entry.discogsLink);
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
                                    setState(() {
                                        _monitored = value;
                                    });
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
                                    setState(() {
                                        _albumFolders = value;
                                    });
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
                                if(_values[0]) {
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
                                if(_values[0]) {
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
                                if(_values[0]) {
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
                        entry.posterURI != null && entry.posterURI != '' ? (
                            ClipRRect(
                                child: Image(
                                    image: AdvancedNetworkImage(
                                        entry.posterURI,
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
                                    '${entry.overview}.\n\n\n',
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
                    await SystemDialogs.showTextPreviewPrompt(context, entry.title, entry.overview ?? 'No summary is available.');
                },
            ),
            margin: Elements.getCardMargin(),
            elevation: 4.0,
        );
    }
}