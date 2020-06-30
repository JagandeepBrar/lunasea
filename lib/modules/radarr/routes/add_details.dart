import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrAddDetailsArguments {
    final RadarrSearchData data;

    RadarrAddDetailsArguments({
        @required this.data,
    });
}

class RadarrAddDetails extends StatefulWidget {
    static const ROUTE_NAME = '/radarr/add/details';

    @override
    State<RadarrAddDetails> createState() => _State();
}

class _State extends State<RadarrAddDetails> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    RadarrAddDetailsArguments _arguments;
    Future<void> _future;
    List<RadarrRootFolder> _rootFolders = [];
    List<RadarrQualityProfile> _qualityProfiles = [];

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
        RadarrAPI _api = RadarrAPI.from(Database.currentProfileObject);
        return _fetchRootFolders(_api)
        .then((_) => _fetchQualityProfiles(_api))
        .then((_) => _fetchAvailability())
        .then((_) {})
        .catchError((error) => error);
    }

    Future<void> _fetchRootFolders(RadarrAPI api) async {
        return await api.getRootFolders()
        .then((values) {
            RadarrRootFolder _rootfolder = RadarrDatabaseValue.ADD_ROOT_FOLDER.data;
            _rootFolders = values;
            int index = _rootFolders.indexWhere((value) => 
                value.id == _rootfolder?.id &&
                value.path == _rootfolder?.path
            );
            RadarrDatabaseValue.ADD_ROOT_FOLDER.put(index != -1 ? _rootFolders[index] : _rootFolders[0]);
        })
        .catchError((error) => error);
    }

    Future<void> _fetchQualityProfiles(RadarrAPI api) async {
        return await api.getQualityProfiles()
        .then((values) {
            RadarrQualityProfile _profile = RadarrDatabaseValue.ADD_QUALITY_PROFILE.data;
            _qualityProfiles = values.values.toList();
            int index = _qualityProfiles.indexWhere((value) => 
                value.id == _profile?.id &&
                value.name == _profile?.name
            );
            RadarrDatabaseValue.ADD_QUALITY_PROFILE.put(index != -1 ? _qualityProfiles[index] : _qualityProfiles[0]);
        })
        .catchError((error) => error);
    }

    Future<void> _fetchAvailability() async {
        RadarrAvailability _availability = RadarrDatabaseValue.ADD_AVAILABILITY.data;
        int index = RadarrConstants.MINIMUM_AVAILBILITIES.indexWhere((value) =>
            value.id == _availability?.id,
        );
        RadarrDatabaseValue.ADD_AVAILABILITY.put(index != -1 ? RadarrConstants.MINIMUM_AVAILBILITIES[index] : RadarrConstants.MINIMUM_AVAILBILITIES[1]);
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
                    onPressed: () async => _arguments.data.tmdbId == 0
                        ? LSSnackBar(
                            context: context,
                            title: 'No TMDB Page Available',
                            message: 'No TMDB URL is available',
                        )
                        : _arguments.data.tmdbId.toString().lsLinks_OpenMovieDB(),
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
                fallbackImage: 'assets/images/radarr/nomovieposter.png',
                headers: Database.currentProfileObject.getRadarr()['headers'],
            ),
            LSDivider(),
            ValueListenableBuilder(
                valueListenable: Database.lunaSeaBox.listenable(keys: [RadarrDatabaseValue.ADD_MONITORED.key]),
                builder: (context, box, widget) {
                    return LSCardTile(
                        title: LSTitle(text: 'Monitored'),
                        subtitle: LSSubtitle(text: 'Monitor movie for new releases'),
                        trailing: Switch(
                            value: RadarrDatabaseValue.ADD_MONITORED.data,
                            onChanged: (value) => RadarrDatabaseValue.ADD_MONITORED.put(value),
                        ),
                    );
                },
            ),
            ValueListenableBuilder(
                valueListenable: Database.lunaSeaBox.listenable(keys: [RadarrDatabaseValue.ADD_ROOT_FOLDER.key]),
                builder: (context, box, widget) {
                    RadarrRootFolder _rootfolder = RadarrDatabaseValue.ADD_ROOT_FOLDER.data;
                    return LSCardTile(
                        title: LSTitle(text: 'Root Folder'),
                        subtitle: LSSubtitle(text: _rootfolder?.path ?? 'Unknown Root Folder'),
                        trailing: LSIconButton(icon: Icons.arrow_forward_ios),
                        onTap: () async {
                            List _values = await RadarrDialogs.editRootFolder(context, _rootFolders);
                            if(_values[0]) RadarrDatabaseValue.ADD_ROOT_FOLDER.put(_values[1]);
                        },
                    );
                },
            ),
            ValueListenableBuilder(
                valueListenable: Database.lunaSeaBox.listenable(keys: [RadarrDatabaseValue.ADD_QUALITY_PROFILE.key]),
                builder: (context, box, widget) {
                    RadarrQualityProfile _profile = RadarrDatabaseValue.ADD_QUALITY_PROFILE.data;
                    return LSCardTile(
                        title: LSTitle(text: 'Quality Profile'),
                        subtitle: LSSubtitle(text: _profile?.name ?? 'Unknown Profile'),
                        trailing: LSIconButton(icon: Icons.arrow_forward_ios),
                        onTap: () async {
                            List _values = await RadarrDialogs.editQualityProfile(context, _qualityProfiles);
                            if(_values[0]) RadarrDatabaseValue.ADD_QUALITY_PROFILE.put(_values[1]);
                        },
                    );
                },
            ),
            ValueListenableBuilder(
                valueListenable: Database.lunaSeaBox.listenable(keys: [RadarrDatabaseValue.ADD_AVAILABILITY.key]),
                builder: (context, box, widget) {
                    RadarrAvailability _availability = RadarrDatabaseValue.ADD_AVAILABILITY.data;
                    return LSCardTile(
                        title: LSTitle(text: 'Minimum Availability'),
                        subtitle: LSSubtitle(text: _availability?.name ?? 'Unknown Availability'),
                        trailing: LSIconButton(icon: Icons.arrow_forward_ios),
                        onTap: () async {
                            List _values = await RadarrDialogs.editMinimumAvailability(context, RadarrConstants.MINIMUM_AVAILBILITIES);
                            if(_values[0]) RadarrDatabaseValue.ADD_AVAILABILITY.put(_values[1]);
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
                        onTap: () async => _addMovie(false),
                        reducedMargin: true,
                    ),
                    ),
                    Expanded(
                        child: LSButton(
                        text: 'Add + Search',
                        backgroundColor: LSColors.orange,
                        onTap: () async => _addMovie(true),
                        reducedMargin: true,
                    ),
                    ),
                ],
            ),
        ],
    );

    Future<void> _addMovie(bool search) async {
        RadarrAPI _api = RadarrAPI.from(Database.currentProfileObject);
        await _api.addMovie(
            _arguments.data,
            RadarrDatabaseValue.ADD_QUALITY_PROFILE.data,
            RadarrDatabaseValue.ADD_ROOT_FOLDER.data,
            RadarrDatabaseValue.ADD_AVAILABILITY.data,
            RadarrDatabaseValue.ADD_MONITORED.data ?? true,
            search: search,
        )
        .then((_) => Navigator.of(context).pop(['movie_added', _arguments.data.title]))
        .catchError((_) => LSSnackBar(context: context, title: search ? 'Failed to Add Movie (With Search)' : 'Failed to Add Movie', message: Constants.CHECK_LOGS_MESSAGE, type: SNACKBAR_TYPE.failure));
    }
}
