import 'package:flutter/material.dart';
import 'package:lunasea/logic/automation/sonarr.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/widgets/ui.dart';
import 'package:intl/intl.dart';

class SonarrEditSeries extends StatefulWidget {
    final SonarrCatalogueEntry entry;

    SonarrEditSeries({
        Key key,
        @required this.entry
    }): super(key: key);

    @override
    State<SonarrEditSeries> createState() {
        return _State();
    }  
}

class _State extends State<SonarrEditSeries> {
    final _scaffoldKey = GlobalKey<ScaffoldState>();

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
                if(profile.id == widget.entry.qualityProfile) {
                    _qualityProfile = profile;
                }
            }
        }
        _seriesType = SonarrSeriesType(Constants.sonarrSeriesTypes[Constants.sonarrSeriesTypes.indexOf(widget.entry.type)]);
        _path = widget.entry.path;
        _monitored = widget.entry.monitored;
        _seasonFolder = widget.entry.seasonFolder;
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
            appBar: Navigation.getAppBar(widget.entry.title, context),
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
                if(await SonarrAPI.editSeries(widget.entry.seriesID, _qualityProfile, _seriesType, _path, _monitored, _seasonFolder)) {
                    widget.entry.qualityProfile = _qualityProfile.id;
                    widget.entry.profile = _qualityProfile.name;
                    widget.entry.type = _seriesType.type;
                    widget.entry.path = _path;
                    widget.entry.monitored = _monitored;
                    widget.entry.seasonFolder = _seasonFolder;
                    Navigator.of(context).pop(['updated_series', widget.entry]);
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
                            subtitle: Elements.getSubtitle('Monitor series for new releases'),
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
                            title: Elements.getTitle('Use Season Folders'),
                            subtitle: Elements.getSubtitle('Sort episodes into season folders'),
                            trailing: Switch(
                                value: _seasonFolder,
                                onChanged: (value) {
                                    if(mounted) {
                                        setState(() {
                                            _seasonFolder = value;
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
                            title: Elements.getTitle('Series Path'),
                            subtitle: Elements.getSubtitle(_path, preventOverflow: true),
                            trailing: IconButton(
                                icon: Elements.getIcon(Icons.arrow_forward_ios),
                                onPressed: null,
                            ),
                            onTap: () async {
                                List<dynamic> _values = await SystemDialogs.showEditTextPrompt(context, 'Series Path', prefill: _path);
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
                            subtitle: Elements.getSubtitle(toBeginningOfSentenceCase(_seriesType.type)),
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
