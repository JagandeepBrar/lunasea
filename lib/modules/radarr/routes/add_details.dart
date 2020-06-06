import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';
import '../../radarr.dart';

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
            final _database = Database.lunaSeaBox;
            RadarrRootFolder _rootfolder = _database.get(RadarrDatabaseValue.ADD_ROOT_FOLDER.key);
            _rootFolders = values;
            int index = _rootFolders.indexWhere((value) => 
                value.id == _rootfolder?.id &&
                value.path == _rootfolder?.path
            );
            _database.put(RadarrDatabaseValue.ADD_ROOT_FOLDER.key, index != -1 ? _rootFolders[index] : _rootFolders[0]);
        })
        .catchError((error) => error);
    }

    Future<void> _fetchQualityProfiles(RadarrAPI api) async {
        return await api.getQualityProfiles()
        .then((values) {
            final _database = Database.lunaSeaBox;
            RadarrQualityProfile _profile = _database.get(RadarrDatabaseValue.ADD_QUALITY_PROFILE.key);
            _qualityProfiles = values.values.toList();
            int index = _qualityProfiles.indexWhere((value) => 
                value.id == _profile?.id &&
                value.name == _profile?.name
            );
            _database.put(RadarrDatabaseValue.ADD_QUALITY_PROFILE.key, index != -1 ? _qualityProfiles[index] : _qualityProfiles[0]);
        })
        .catchError((error) => error);
    }

    Future<void> _fetchAvailability() async {
        final _database = Database.lunaSeaBox;
        RadarrAvailability _availability = _database.get(RadarrDatabaseValue.ADD_AVAILABILITY.key);
        int index = RadarrConstants.MINIMUM_AVAILBILITIES.indexWhere((value) =>
            value.id == _availability?.id,
        );
        _database.put(RadarrDatabaseValue.ADD_AVAILABILITY.key, index != -1 ? RadarrConstants.MINIMUM_AVAILBILITIES[index] : RadarrConstants.MINIMUM_AVAILBILITIES[1]);
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
                            value: box.get(RadarrDatabaseValue.ADD_MONITORED.key, defaultValue: true),
                            onChanged: (value) => box.put(RadarrDatabaseValue.ADD_MONITORED.key, value),
                        ),
                    );
                },
            ),
            ValueListenableBuilder(
                valueListenable: Database.lunaSeaBox.listenable(keys: [RadarrDatabaseValue.ADD_ROOT_FOLDER.key]),
                builder: (context, box, widget) {
                    RadarrRootFolder _rootfolder = box.get(RadarrDatabaseValue.ADD_ROOT_FOLDER.key);
                    return LSCardTile(
                        title: LSTitle(text: 'Root Folder'),
                        subtitle: LSSubtitle(text: _rootfolder?.path ?? 'Unknown Root Folder'),
                        trailing: LSIconButton(icon: Icons.arrow_forward_ios),
                        onTap: () async {
                            List _values = await LSDialogRadarr.showEditRootFolderPrompt(context, _rootFolders);
                            if(_values[0]) box.put(RadarrDatabaseValue.ADD_ROOT_FOLDER.key, _values[1]);
                        },
                    );
                },
            ),
            ValueListenableBuilder(
                valueListenable: Database.lunaSeaBox.listenable(keys: [RadarrDatabaseValue.ADD_QUALITY_PROFILE.key]),
                builder: (context, box, widget) {
                    RadarrQualityProfile _profile = box.get(RadarrDatabaseValue.ADD_QUALITY_PROFILE.key);
                    return LSCardTile(
                        title: LSTitle(text: 'Quality Profile'),
                        subtitle: LSSubtitle(text: _profile?.name ?? 'Unknown Profile'),
                        trailing: LSIconButton(icon: Icons.arrow_forward_ios),
                        onTap: () async {
                            List _values = await LSDialogRadarr.showEditQualityProfilePrompt(context, _qualityProfiles);
                            if(_values[0]) box.put(RadarrDatabaseValue.ADD_QUALITY_PROFILE.key, _values[1]);
                        },
                    );
                },
            ),
            ValueListenableBuilder(
                valueListenable: Database.lunaSeaBox.listenable(keys: [RadarrDatabaseValue.ADD_AVAILABILITY.key]),
                builder: (context, box, widget) {
                    RadarrAvailability _availability = box.get(RadarrDatabaseValue.ADD_AVAILABILITY.key);
                    return LSCardTile(
                        title: LSTitle(text: 'Minimum Availability'),
                        subtitle: LSSubtitle(text: _availability?.name ?? 'Unknown Availability'),
                        trailing: LSIconButton(icon: Icons.arrow_forward_ios),
                        onTap: () async {
                            List _values = await LSDialogRadarr.showMinimumAvailabilityPrompt(context, RadarrConstants.MINIMUM_AVAILBILITIES);
                            if(_values[0]) box.put(RadarrDatabaseValue.ADD_AVAILABILITY.key, _values[1]);
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
        padBottom: true,
    );

    Future<void> _addMovie(bool search) async {
        RadarrAPI _api = RadarrAPI.from(Database.currentProfileObject);
        final _database = Database.lunaSeaBox;
        await _api.addMovie(
            _arguments.data,
            _database.get(RadarrDatabaseValue.ADD_QUALITY_PROFILE.key),
            _database.get(RadarrDatabaseValue.ADD_ROOT_FOLDER.key),
            _database.get(RadarrDatabaseValue.ADD_AVAILABILITY.key),
            _database.get(RadarrDatabaseValue.ADD_MONITORED.key) ?? true,
            search: search,
        )
        .then((_) => Navigator.of(context).pop(['movie_added', _arguments.data.title]))
        .catchError((_) => LSSnackBar(context: context, title: search ? 'Failed to Add Movie (With Search)' : 'Failed to Add Movie', message: Constants.CHECK_LOGS_MESSAGE, type: SNACKBAR_TYPE.failure));
    }
}
