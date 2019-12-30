import 'package:flutter/material.dart';
import 'package:lunasea/logic/automation/sonarr.dart';
import 'package:lunasea/system/constants.dart';
import 'package:lunasea/system/ui.dart';
import 'package:intl/intl.dart';

class SonarrEditSeries extends StatelessWidget {
    final SonarrCatalogueEntry entry;
    SonarrEditSeries({Key key, @required this.entry}): super(key: key);

    @override
    Widget build(BuildContext context) {
        return _SonarrEditSeriesWidget(entry: entry);
    }
}

class _SonarrEditSeriesWidget extends StatefulWidget {
    final SonarrCatalogueEntry entry;
    _SonarrEditSeriesWidget({Key key, @required this.entry}): super(key: key);

    @override
    State<StatefulWidget> createState() {
        return _SonarrEditSeriesState(entry: entry);
    }  
}

class _SonarrEditSeriesState extends State<StatefulWidget> {
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    final SonarrCatalogueEntry entry;
    _SonarrEditSeriesState({Key key, @required this.entry});

    List<SonarrQualityProfile> _qualityProfiles = [];
    SonarrQualityProfile _qualityProfile;
    SonarrSeriesType _seriesType;

    String _path;
    bool _monitored;
    bool _seasonFolder;
    bool _loading = true;

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
        final profiles = await SonarrAPI.getQualityProfiles();
        _qualityProfiles = profiles?.values?.toList();
        if(_qualityProfiles != null && _qualityProfiles.length != 0) {
            for(var profile in _qualityProfiles) {
                if(profile.id == entry.qualityProfile) {
                    _qualityProfile = profile;
                }
            }
        }
        _seriesType = SonarrSeriesType(Constants.sonarrSeriesTypes[Constants.sonarrSeriesTypes.indexOf(entry.type)]);
        _path = entry.path;
        _monitored = entry.monitored;
        _seasonFolder = entry.seasonFolder;
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
            _qualityProfile != null &&
            _qualityProfiles != null
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
                if(await SonarrAPI.editSeries(entry.seriesID, _qualityProfile, _seriesType, _path, _monitored, _seasonFolder)) {
                    entry.qualityProfile = _qualityProfile.id;
                    entry.profile = _qualityProfile.name;
                    entry.type = _seriesType.type;
                    entry.path = _path;
                    entry.monitored = _monitored;
                    entry.seasonFolder = _seasonFolder;
                    Navigator.of(context).pop(['updated_series', entry]);
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
                            subtitle: Elements.getSubtitle('Monitor series for new releases'),
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
                            title: Elements.getTitle('Use Season Folders'),
                            subtitle: Elements.getSubtitle('Sort episodes into season folders'),
                            trailing: Switch(
                                value: _seasonFolder,
                                onChanged: (value) {
                                    setState(() {
                                        _seasonFolder = value;
                                    });
                                },
                            ),
                        ),
                        margin: Elements.getCardMargin(),
                        elevation: 4.0,
                    ),
                    Card(
                        child: ListTile(
                            title: Elements.getTitle('Series Path'),
                            subtitle: Elements.getSubtitle(_path, preventOverflow: true),
                            trailing: IconButton(
                                icon: Elements.getIcon(Icons.arrow_forward_ios),
                                onPressed: null,
                            ),
                            onTap: () async {
                                List<dynamic> _values = await SystemDialogs.showEditTextPrompt(context, 'Series Path', prefill: _path);
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
                                List<dynamic> _values = await SonarrDialogs.showEditQualityProfilePrompt(context, _qualityProfiles);
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
                            title: Elements.getTitle('Series Type'),
                            subtitle: Elements.getSubtitle(toBeginningOfSentenceCase(_seriesType.type)),
                            trailing: IconButton(
                                icon: Elements.getIcon(Icons.arrow_forward_ios),
                                onPressed: null,
                            ),
                            onTap: () async {
                                List<dynamic> _values = await SonarrDialogs.showEditSeriesTypePrompt(context);
                                if(_values[0]) {
                                    setState(() {
                                        _seriesType = _values[1];
                                    });
                                }
                            }
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
