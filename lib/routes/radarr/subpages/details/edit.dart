import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/widgets/ui.dart';

class RadarrEditMovie extends StatefulWidget {
    final RadarrCatalogueEntry entry;
    final RadarrAPI api = RadarrAPI.from(Database.currentProfileObject);

    RadarrEditMovie({
        Key key,
        @required this.entry,
    }): super(key: key);

    @override
    State<RadarrEditMovie> createState() {
        return _State();
    }  
}

class _State extends State<RadarrEditMovie> {
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    bool _loading = true;
    bool _monitored;
    bool _static;
    String _path;
    List<RadarrQualityProfile> _qualityProfiles = [];
    RadarrQualityProfile _qualityProfile;
    RadarrAvailabilityEntry _minimumAvailability;

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
        _monitored = widget.entry.monitored;
        _static = widget.entry.staticPath;
        _path = widget.entry.path;
        for(var min in Constants.radarrMinAvailability) {
            if(widget.entry.minimumAvailability == min.id) {
                _minimumAvailability = min;
            }
        }
        _minimumAvailability ??= Constants.radarrMinAvailability[0];
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
                LSLoading() : 
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
            _qualityProfiles != null &&
            _qualityProfile != null
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
                if(await widget.api.editMovie(widget.entry.movieID, _qualityProfile, _minimumAvailability, _path, _monitored, _static)) {
                    widget.entry.qualityProfile = _qualityProfile.id;
                    widget.entry.profile = _qualityProfile.name;
                    widget.entry.minimumAvailability = _minimumAvailability.id;
                    widget.entry.staticPath = _static;
                    widget.entry.path = _path;
                    widget.entry.monitored = _monitored;
                    Navigator.of(context).pop(['updated_movie', widget.entry]);
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
                            subtitle: Elements.getSubtitle('Monitor movie for new content'),
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
                            title: Elements.getTitle('Static Path'),
                            subtitle: Elements.getSubtitle('Prevent directory from changing'),
                            trailing: Switch(
                                value: _static,
                                onChanged: (value) {
                                    if(mounted) {
                                        setState(() {
                                            _static = value;
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
                            title: Elements.getTitle('Movie Path'),
                            subtitle: Elements.getSubtitle(_path, preventOverflow: true),
                            trailing: IconButton(
                                icon: Elements.getIcon(Icons.arrow_forward_ios),
                                onPressed: null,
                            ),
                            onTap: () async {
                                List<dynamic> _values = await SystemDialogs.showEditTextPrompt(context, 'Movie Path', prefill: _path);
                                if(_values[0] && mounted) {
                                    setState(() {
                                        _path = _values[1];
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
                                List<dynamic> _values = await RadarrDialogs.showEditQualityProfilePrompt(context, _qualityProfiles);
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
                            title: Elements.getTitle('Minimum Availability'),
                            subtitle: Elements.getSubtitle(_minimumAvailability.name, preventOverflow: true),
                            trailing: IconButton(
                                icon: Elements.getIcon(Icons.arrow_forward_ios),
                                onPressed: null,
                            ),
                            onTap: () async {
                                List<dynamic> _values = await RadarrDialogs.showMinimumAvailabilityPrompt(context, Constants.radarrMinAvailability);
                                if(_values[0] && mounted) {
                                    setState(() {
                                        _minimumAvailability = _values[1];
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
}