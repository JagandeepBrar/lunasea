import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/widgets/ui.dart';

class LidarrEditArtist extends StatefulWidget {
    final LidarrAPI api = LidarrAPI.from(Database.currentProfileObject);
    final LidarrCatalogueEntry entry;

    LidarrEditArtist({
        Key key,
        @required this.entry
    }) : super(key: key);

    @override
    State<LidarrEditArtist> createState() {
        return _State();
    }
}

class _State extends State<LidarrEditArtist> {
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    bool _loading = true;

    List<LidarrQualityProfile> _qualityProfiles = [];
    List<LidarrMetadataProfile> _metadataProfiles = [];
    LidarrQualityProfile _qualityProfile;
    LidarrMetadataProfile _metadataProfile;
    String _path;
    bool _monitored;
    bool _albumFolders;

    @override
    void initState() {
        super.initState();
        _fetchData();
    }

    Future<void> _fetchData() async {
        if(mounted) {
            setState(() {
                _loading = true;
            });
        }
        final profiles = await widget.api.getQualityProfiles();
        _qualityProfiles = profiles?.values?.toList();
        if(_qualityProfiles != null && _qualityProfiles.length != 0) {
            for(var profile in _qualityProfiles) {
                if(profile.id == widget.entry.qualityProfile) {
                    _qualityProfile = profile;
                }
            }
        }
        final metadatas = await widget.api.getMetadataProfiles();
        _metadataProfiles = metadatas?.values?.toList();
        if(_metadataProfiles != null && _metadataProfiles.length != 0) {
            for(var profile in _metadataProfiles) {
                if(profile.id == widget.entry.metadataProfile) {
                    _metadataProfile = profile;
                }
            }
        }
        _path = widget.entry.path;
        _monitored = widget.entry.monitored;
        _albumFolders = widget.entry.albumFolders;
        if(mounted) {
            setState(() {
                _loading = false;
            });
        }
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            key: _scaffoldKey,
            appBar: LSAppBar(title: widget.entry.title),
            body: _loading ?
                Notifications.centeredMessage('Loading...') : 
                checkValues() ? 
                    _buildList() :
                    Notifications.centeredMessage('Connection Error', showBtn: true, btnMessage: 'Refresh', onTapHandler: () async {
                        _fetchData();
                    }),
            floatingActionButton: _loading ?
                null :
                checkValues() ?
                    _buildFloatingActionButton() :
                    null,
        );
    }

    bool checkValues() {
        if(
            _qualityProfile != null &&
            _qualityProfiles != null &&
            _metadataProfile != null &&
            _metadataProfiles != null
        ) {
            return true;
        }
        return false;
    }

    Widget _buildFloatingActionButton() {
        return FloatingActionButton(
            heroTag: null,
            tooltip: 'Save Changes',
            child: Elements.getIcon(Icons.save),
            onPressed: () async {
                if(await widget.api.editArtist(widget.entry.artistID, _qualityProfile, _metadataProfile, _path, _monitored, _albumFolders)) {
                    widget.entry.qualityProfile = _qualityProfile.id;
                    widget.entry.quality = _qualityProfile.name;
                    widget.entry.metadataProfile = _metadataProfile.id;
                    widget.entry.metadata = _metadataProfile.name;
                    widget.entry.path = _path;
                    widget.entry.monitored = _monitored;
                    widget.entry.albumFolders = _albumFolders;
                    Navigator.of(context).pop(['updated_artist', widget.entry]);
                } else {
                    Notifications.showSnackBar(_scaffoldKey, 'Failed to update ${widget.entry.title}');
                }
            },
        );
    }

    Widget _buildList() {
        return Scrollbar(
            child: ListView(
                children: <Widget>[
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
                        elevation: 4.0,
                        margin: Elements.getCardMargin(),
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
                        elevation: 4.0,
                        margin: Elements.getCardMargin(),
                    ),
                    Card(
                        child: ListTile(
                            title: Elements.getTitle('Artist Path'),
                            subtitle: Elements.getSubtitle(_path, preventOverflow: true),
                            trailing: IconButton(
                                icon: Elements.getIcon(Icons.arrow_forward_ios),
                                onPressed: null,
                            ),
                            onTap: () async {
                                List<dynamic> _values = await SystemDialogs.showEditTextPrompt(context, 'Artist Path', prefill: _path);
                                if(_values[0] && mounted) {
                                    setState(() {
                                        _path = _values[1];
                                    });
                                }
                            }
                        ),
                        elevation: 4.0,
                        margin: Elements.getCardMargin(),
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
                        elevation: 4.0,
                        margin: Elements.getCardMargin(),
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
                        elevation: 4.0,
                        margin: Elements.getCardMargin(),
                    ),
                ],
                padding: Elements.getListViewPadding(),
            ),
        );
    }
}