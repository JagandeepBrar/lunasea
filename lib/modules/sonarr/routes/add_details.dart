import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrAddDetailsArguments {
    final SonarrSearchData data;

    SonarrAddDetailsArguments({
        @required this.data,
    });
}

class SonarrAddDetails extends StatefulWidget {
    static const ROUTE_NAME = '/sonarr/add/details';

    @override
    State<SonarrAddDetails> createState() => _State();
}

class _State extends State<SonarrAddDetails> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    SonarrAddDetailsArguments _arguments;
    Future<void> _future;
    List<SonarrRootFolder> _rootFolders = [];
    List<SonarrQualityProfile> _qualityProfiles = [];

    @override
    void initState() {
        super.initState();
        SchedulerBinding.instance.scheduleFrameCallback((_) {
            setState(() => _arguments = ModalRoute.of(context).settings.arguments);
            _refresh();
        });
    }

    void _refresh() => setState(() {
        _future = _fetchParameters();
    });

    Future<void> _fetchParameters() async {
        SonarrAPI _api = SonarrAPI.from(Database.currentProfileObject);
        return _fetchRootFolders(_api)
        .then((_) => _fetchQualityProfiles(_api))
        .then((_) => _fetchSeriesTypes())
        .then((_) => _fetchMonitorStatuses())
        .then((_) {})
        .catchError((error) => Future.error(error));
    }

    Future<void> _fetchRootFolders(SonarrAPI api) async {
        return await api.getRootFolders()
        .then((values) {
            SonarrRootFolder _rootfolder = SonarrDatabaseValue.ADD_ROOT_FOLDER.data;
             _rootFolders = values;
            int index = _rootFolders.indexWhere((value) => 
                value.id == _rootfolder?.id &&
                value.path == _rootfolder?.path
            );
            SonarrDatabaseValue.ADD_ROOT_FOLDER.put(index != -1 ? _rootFolders[index] : _rootFolders[0]);
        })
        .catchError((error) {
            Future.error(error);
        });
    }

    Future<void> _fetchSeriesTypes() async {
        SonarrSeriesType _seriesType = SonarrDatabaseValue.ADD_SERIES_TYPE.data;
        int index = SonarrConstants.SERIES_TYPES.indexWhere((value) =>
            value.type == _seriesType?.type,
        );
        SonarrDatabaseValue.ADD_SERIES_TYPE.put(index != -1 ? SonarrConstants.SERIES_TYPES[index] : SonarrConstants.SERIES_TYPES[2]);
    }

    Future<void> _fetchMonitorStatuses() async {
        SonarrMonitorStatus _monitorStatus = SonarrDatabaseValue.ADD_MONITOR_STATUS.data;
        _monitorStatus ??= SonarrMonitorStatus.ALL;
        SonarrDatabaseValue.ADD_MONITOR_STATUS.put(_monitorStatus);
    }

    Future<void> _fetchQualityProfiles(SonarrAPI api) async {
        return await api.getQualityProfiles()
        .then((values) {
            SonarrQualityProfile _profile = SonarrDatabaseValue.ADD_QUALITY_PROFILE.data;
            _qualityProfiles = values.values.toList();
            int index = _qualityProfiles.indexWhere((value) => 
                value.id == _profile?.id &&
                value.name == _profile?.name
            );
            SonarrDatabaseValue.ADD_QUALITY_PROFILE.put(index != -1 ? _qualityProfiles[index] : _qualityProfiles[0]);
        })
        .catchError((error) => error);
    }

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        body: _body,
    );

    Widget get _appBar => _arguments == null
        ? null
        : LSAppBar(
            title: _arguments.data.title,
            actions: [
                LSIconButton(
                    icon: Icons.link,
                    onPressed: () async => _arguments.data.tvdbId == 0
                        ? LSSnackBar(
                            context: context,
                            title: 'No TVDB Page Available',
                            message: 'No TVDB URL is available',
                        )
                        : _arguments.data.tvdbId.toString().lsLinks_OpenTVDB(),
                )
            ],
        );

    Widget get _body => _arguments == null
        ? null
        : FutureBuilder(
            future: _future,
            builder: (context, snapshot) {
                switch(snapshot.connectionState) {
                    case ConnectionState.done: {
                        if(snapshot.hasError) return LSErrorMessage(onTapHandler: () => _refresh());
                        return _list;
                    }
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                    case ConnectionState.active:
                    default: return LSLoading();
                }
            },
        );

    Widget get _list => LSListView(
        children: <Widget>[
            LSDescriptionBlock(
                title: _arguments.data.title ?? 'Unknown',
                description: _arguments.data.overview == ''
                    ? 'No summary is available.'
                    : _arguments.data.overview,
                uri: _arguments.data.posterURI ?? '',
                fallbackImage: 'assets/images/sonarr/noseriesposter.png',
                headers: Database.currentProfileObject.getSonarr()['headers'],
            ),
            LSDivider(),
            ValueListenableBuilder(
                valueListenable: Database.lunaSeaBox.listenable(keys: [SonarrDatabaseValue.ADD_MONITORED.key]),
                builder: (context, box, widget) {
                    return LSCardTile(
                        title: LSTitle(text: 'Monitored'),
                        subtitle: LSSubtitle(text: 'Monitor series for new releases'),
                        trailing: Switch(
                            value: SonarrDatabaseValue.ADD_MONITORED.data,
                            onChanged: (value) => SonarrDatabaseValue.ADD_MONITORED.put(value),
                        ),
                    );
                }
            ),
            ValueListenableBuilder(
                valueListenable: Database.lunaSeaBox.listenable(keys: [SonarrDatabaseValue.ADD_SEASON_FOLDERS.key]),
                builder: (context, box, widget) {
                    return LSCardTile(
                        title: LSTitle(text: 'Use Season Folders'),
                        subtitle: LSSubtitle(text: 'Sort episodes into season folders'),
                        trailing: Switch(
                            value: SonarrDatabaseValue.ADD_SEASON_FOLDERS.data,
                            onChanged: (value) => SonarrDatabaseValue.ADD_SEASON_FOLDERS.put(value),
                        ),
                    );
                }
            ),
            ValueListenableBuilder(
                valueListenable: Database.lunaSeaBox.listenable(keys: [SonarrDatabaseValue.ADD_MONITOR_STATUS.key]),
                builder: (context, box, widget) {
                    SonarrMonitorStatus _status = SonarrDatabaseValue.ADD_MONITOR_STATUS.data;
                    return LSCardTile(
                        title: LSTitle(text: 'Monitoring Status'),
                        subtitle: LSSubtitle(text: _status.name ?? 'Unknown Status'),
                        trailing: LSIconButton(icon: Icons.arrow_forward_ios),
                        onTap: () async {
                            List _values = await SonarrDialogs.editMonitoringStatus(context);
                            if(_values[0]) SonarrDatabaseValue.ADD_MONITOR_STATUS.put(_values[1]);
                        },
                    );
                },
            ),
            ValueListenableBuilder(
                valueListenable: Database.lunaSeaBox.listenable(keys: [SonarrDatabaseValue.ADD_QUALITY_PROFILE.key]),
                builder: (context, box, widget) {
                    SonarrQualityProfile _profile = SonarrDatabaseValue.ADD_QUALITY_PROFILE.data;
                    return LSCardTile(
                        title: LSTitle(text: 'Quality Profile'),
                        subtitle: LSSubtitle(text: _profile?.name ?? 'Unknown Profile'),
                        trailing: LSIconButton(icon: Icons.arrow_forward_ios),
                        onTap: () async {
                            List _values = await SonarrDialogs.editQualityProfile(context, _qualityProfiles);
                            if(_values[0]) SonarrDatabaseValue.ADD_QUALITY_PROFILE.put(_values[1]);
                        },
                    );
                },
            ),
            ValueListenableBuilder(
                valueListenable: Database.lunaSeaBox.listenable(keys: [SonarrDatabaseValue.ADD_ROOT_FOLDER.key]),
                builder: (context, box, widget) {
                    SonarrRootFolder _rootfolder = SonarrDatabaseValue.ADD_ROOT_FOLDER.data;
                    return LSCardTile(
                        title: LSTitle(text: 'Root Folder'),
                        subtitle: LSSubtitle(text: _rootfolder?.path ?? 'Unknown Root Folder'),
                        trailing: LSIconButton(icon: Icons.arrow_forward_ios),
                        onTap: () async {
                            List _values = await SonarrDialogs.editRootFolder(context, _rootFolders);
                            if(_values[0]) SonarrDatabaseValue.ADD_ROOT_FOLDER.put(_values[1]);
                        },
                    );
                },
            ),
            ValueListenableBuilder(
                valueListenable: Database.lunaSeaBox.listenable(keys: [SonarrDatabaseValue.ADD_SERIES_TYPE.key]),
                builder: (context, box, widget) {
                    SonarrSeriesType _type = SonarrDatabaseValue.ADD_SERIES_TYPE.data;
                    return LSCardTile(
                        title: LSTitle(text: 'Series Type'),
                        subtitle: LSSubtitle(text: _type?.type?.lsLanguage_Capitalize() ?? 'Unknown Type'),
                        trailing: LSIconButton(icon: Icons.arrow_forward_ios),
                        onTap: () async {
                            List _values = await SonarrDialogs.editSeriesType(context);
                            if(_values[0]) SonarrDatabaseValue.ADD_SERIES_TYPE.put(_values[1]);
                        },
                    );
                },
            ),
            LSDivider(),
            LSContainerRow(
                children: <Widget>[
                    Expanded(
                        child: LSButton(
                            text: 'Add',
                            onTap: () async => _add(search: false),
                            reducedMargin: true,
                        ),
                    ),
                    Expanded(
                        child: LSButton(
                            text: 'Add + Search',
                            backgroundColor: LSColors.orange,
                            onTap: () async => _add(search: true),
                            reducedMargin: true,
                        ),
                    ),
                ],
            )
        ],
    );

    Future<void> _add({ bool search = false }) async {
        SonarrAPI _api = SonarrAPI.from(Database.currentProfileObject);
        await _api.addSeries(
            _arguments.data,
            SonarrDatabaseValue.ADD_QUALITY_PROFILE.data,
            SonarrDatabaseValue.ADD_ROOT_FOLDER.data,
            SonarrDatabaseValue.ADD_SERIES_TYPE.data,
            SonarrDatabaseValue.ADD_MONITOR_STATUS.data,
            SonarrDatabaseValue.ADD_SEASON_FOLDERS.data ?? true,
            SonarrDatabaseValue.ADD_MONITORED.data ?? true,
            search: search,
        )
        .then((_) => Navigator.of(context).pop(['series_added', _arguments.data.title]))
        .catchError((_) => LSSnackBar(context: context, title: search ? 'Failed to Add Series (With Search)' : 'Failed to Add Series', message: Constants.CHECK_LOGS_MESSAGE, type: SNACKBAR_TYPE.failure));
    }
}
