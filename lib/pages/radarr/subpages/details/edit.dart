import 'package:flutter/material.dart';
import 'package:lunasea/logic/automation/radarr.dart';
import 'package:lunasea/system/constants.dart';
import 'package:lunasea/system/ui.dart';

class RadarrEditMovie extends StatelessWidget {
    final RadarrCatalogueEntry entry;
    RadarrEditMovie({Key key, @required this.entry}): super(key: key);

    @override
    Widget build(BuildContext context) {
        return _RadarrEditMovieWidget(entry: entry);
    }
}

class _RadarrEditMovieWidget extends StatefulWidget {
    final RadarrCatalogueEntry entry;
    _RadarrEditMovieWidget({Key key, @required this.entry}): super(key: key);

    @override
    State<StatefulWidget> createState() {
        return _RadarrEditMovieState(entry: entry);
    }  
}

class _RadarrEditMovieState extends State<StatefulWidget> {
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    final RadarrCatalogueEntry entry;
    bool _loading = true;
    bool _monitored;
    bool _static;
    String _path;
    List<RadarrQualityProfile> _qualityProfiles = [];
    RadarrQualityProfile _qualityProfile;
    RadarrAvailabilityEntry _minimumAvailability;

    _RadarrEditMovieState({Key key, @required this.entry});

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
        final profiles = await RadarrAPI.getQualityProfiles();
        _qualityProfiles = profiles?.values?.toList();
        if(_qualityProfiles != null && _qualityProfiles.length != 0) {
            for(var profile in _qualityProfiles) {
                if(profile.id == entry.qualityProfile) {
                    _qualityProfile = profile;
                }
            }
        }
        _monitored = entry.monitored;
        _static = entry.staticPath;
        _path = entry.path;
        for(var min in Constants.radarrMinAvailability) {
            if(entry.minimumAvailability == min.id) {
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
            appBar: Navigation.getAppBar(entry.title, context),
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
                if(await RadarrAPI.editMovie(entry.movieID, _qualityProfile, _minimumAvailability, _path, _monitored, _static)) {
                    entry.qualityProfile = _qualityProfile.id;
                    entry.profile = _qualityProfile.name;
                    entry.minimumAvailability = _minimumAvailability.id;
                    entry.staticPath = _static;
                    entry.path = _path;
                    entry.monitored = _monitored;
                    Navigator.of(context).pop(['updated_movie', entry]);
                } else {
                    Notifications.showSnackBar(_scaffoldKey, 'Failed to update ${entry.title}');
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
                            title: Elements.getTitle('Static Path'),
                            subtitle: Elements.getSubtitle('Prevent directory from changing'),
                            trailing: Switch(
                                value: _static,
                                onChanged: (value) {
                                    setState(() {
                                        _static = value;
                                    });
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
                                if(_values[0]) {
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
                            title: Elements.getTitle('Minimum Availability'),
                            subtitle: Elements.getSubtitle(_minimumAvailability.name, preventOverflow: true),
                            trailing: IconButton(
                                icon: Elements.getIcon(Icons.arrow_forward_ios),
                                onPressed: null,
                            ),
                            onTap: () async {
                                List<dynamic> _values = await RadarrDialogs.showMinimumAvailabilityPrompt(context, Constants.radarrMinAvailability);
                                if(_values[0]) {
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