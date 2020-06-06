import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';
import '../../lidarr.dart';

class LidarrAddDetailsArguments {
    final LidarrSearchData data;

    LidarrAddDetailsArguments({
        @required this.data,
    });
}

class LidarrAddDetails extends StatefulWidget {
    static const ROUTE_NAME = '/lidarr/add/details';

    @override
    State<LidarrAddDetails> createState() => _State();
}

class _State extends State<LidarrAddDetails> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    LidarrAddDetailsArguments _arguments;
    Future<void> _future;
    List<LidarrRootFolder> _rootFolders = [];
    List<LidarrQualityProfile> _qualityProfiles = [];
    List<LidarrMetadataProfile> _metadataProfiles = [];

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
        LidarrAPI _api = LidarrAPI.from(Database.currentProfileObject);
        return _fetchRootFolders(_api)
        .then((_) => _fetchQualityProfiles(_api))
        .then((_) => _fetchMetadataProfiles(_api))
        .then((_) {})
        .catchError((error) => error);     
    }

    Future<void> _fetchRootFolders(LidarrAPI api) async {
        return await api.getRootFolders()
        .then((values) {
            final _database = Database.lunaSeaBox;
            LidarrRootFolder _rootfolder = _database.get(LidarrDatabaseValue.ADD_ROOT_FOLDER.key);
             _rootFolders = values;
            int index = _rootFolders.indexWhere((value) => 
                value.id == _rootfolder?.id &&
                value.path == _rootfolder?.path
            );
            _database.put(LidarrDatabaseValue.ADD_ROOT_FOLDER.key, index != -1 ? _rootFolders[index] : _rootFolders[0]);
        })
        .catchError((error) {
            Future.error(error);
        });
    }

    Future<void> _fetchQualityProfiles(LidarrAPI api) async {
        return await api.getQualityProfiles()
        .then((values) {
            final _database = Database.lunaSeaBox;
            LidarrQualityProfile _profile = _database.get(LidarrDatabaseValue.ADD_QUALITY_PROFILE.key);
            _qualityProfiles = values.values.toList();
            int index = _qualityProfiles.indexWhere((value) => 
                value.id == _profile?.id &&
                value.name == _profile?.name
            );
            _database.put(LidarrDatabaseValue.ADD_QUALITY_PROFILE.key, index != -1 ? _qualityProfiles[index] : _qualityProfiles[0]);
        })
        .catchError((error) => error);
    }

    Future<void> _fetchMetadataProfiles(LidarrAPI api) async {
        return await api.getMetadataProfiles()
        .then((values) {
            final _database = Database.lunaSeaBox;
            LidarrMetadataProfile _profile = _database.get(LidarrDatabaseValue.ADD_METADATA_PROFILE.key);
            _metadataProfiles = values.values.toList();
            int index = _metadataProfiles.indexWhere((value) => 
                value.id == _profile?.id &&
                value.name == _profile?.name
            );
            _database.put(LidarrDatabaseValue.ADD_METADATA_PROFILE.key, index != -1 ? _metadataProfiles[index] : _metadataProfiles[0]);
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
                    onPressed: () async => _arguments.data.discogsLink == null || _arguments.data.discogsLink == ''
                        ? LSSnackBar(
                            context: context,
                            title: 'No Discogs Page Available',
                            message: 'No Discogs URL is available',
                        )
                        : _arguments.data.discogsLink.lsLinks_OpenLink()
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
                fallbackImage: 'assets/images/lidarr/noartistposter.png',
                headers: Database.currentProfileObject.getLidarr()['headers'],
            ),
            LSDivider(),
            ValueListenableBuilder(
                valueListenable: Database.lunaSeaBox.listenable(keys: [LidarrDatabaseValue.ADD_MONITORED.key]),
                builder: (context, box, widget) {
                    return LSCardTile(
                        title: LSTitle(text: 'Monitored'),
                        subtitle: LSSubtitle(text: 'Monitor artist for new releases'),
                        trailing: Switch(
                            value: box.get(LidarrDatabaseValue.ADD_MONITORED.key, defaultValue: true),
                            onChanged: (value) => box.put(LidarrDatabaseValue.ADD_MONITORED.key, value),
                        ),
                    );
                }
            ),
            ValueListenableBuilder(
                valueListenable: Database.lunaSeaBox.listenable(keys: [LidarrDatabaseValue.ADD_ALBUM_FOLDERS.key]),
                builder: (context, box, widget) {
                    return LSCardTile(
                        title: LSTitle(text: 'Use Album Folders'),
                        subtitle: LSSubtitle(text: 'Sort tracks into album folders'),
                        trailing: Switch(
                            value: box.get(LidarrDatabaseValue.ADD_ALBUM_FOLDERS.key, defaultValue: true),
                            onChanged: (value) => box.put(LidarrDatabaseValue.ADD_ALBUM_FOLDERS.key, value),
                        ),
                    );
                }
            ),
            ValueListenableBuilder(
                valueListenable: Database.lunaSeaBox.listenable(keys: [LidarrDatabaseValue.ADD_ROOT_FOLDER.key]),
                builder: (context, box, widget) {
                    LidarrRootFolder _rootfolder = box.get(LidarrDatabaseValue.ADD_ROOT_FOLDER.key);
                    return LSCardTile(
                        title: LSTitle(text: 'Root Folder'),
                        subtitle: LSSubtitle(text: _rootfolder?.path ?? 'Unknown Root Folder'),
                        trailing: LSIconButton(icon: Icons.arrow_forward_ios),
                        onTap: () async {
                            List _values = await LSDialogLidarr.showEditRootFolderPrompt(context, _rootFolders);
                            if(_values[0]) box.put(LidarrDatabaseValue.ADD_ROOT_FOLDER.key, _values[1]);
                        },
                    );
                },
            ),
            ValueListenableBuilder(
                valueListenable: Database.lunaSeaBox.listenable(keys: [LidarrDatabaseValue.ADD_QUALITY_PROFILE.key]),
                builder: (context, box, widget) {
                    LidarrQualityProfile _profile = box.get(LidarrDatabaseValue.ADD_QUALITY_PROFILE.key);
                    return LSCardTile(
                        title: LSTitle(text: 'Quality Profile'),
                        subtitle: LSSubtitle(text: _profile?.name ?? 'Unknown Profile'),
                        trailing: LSIconButton(icon: Icons.arrow_forward_ios),
                        onTap: () async {
                            List _values = await LSDialogLidarr.showEditQualityProfilePrompt(context, _qualityProfiles);
                            if(_values[0]) box.put(LidarrDatabaseValue.ADD_QUALITY_PROFILE.key, _values[1]);
                        },
                    );
                },
            ),
            ValueListenableBuilder(
                valueListenable: Database.lunaSeaBox.listenable(keys: [LidarrDatabaseValue.ADD_METADATA_PROFILE.key]),
                builder: (context, box, widget) {
                    LidarrMetadataProfile _profile = box.get(LidarrDatabaseValue.ADD_METADATA_PROFILE.key);
                    return LSCardTile(
                        title: LSTitle(text: 'Metadata Profile'),
                        subtitle: LSSubtitle(text: _profile?.name ?? 'Unknown Profile'),
                        trailing: LSIconButton(icon: Icons.arrow_forward_ios),
                        onTap: () async {
                            List _values = await LSDialogLidarr.showEditMetadataProfilePrompt(context, _metadataProfiles);
                            if(_values[0]) box.put(LidarrDatabaseValue.ADD_METADATA_PROFILE.key, _values[1]);
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
                        onTap: () async => _addArtist(false),
                        reducedMargin: true,
                    ),
                    ),
                    Expanded(
                        child: LSButton(
                        text: 'Add + Search',
                        backgroundColor: LSColors.orange,
                        onTap: () async => _addArtist(true),
                        reducedMargin: true,
                    ),
                    ),
                ],
            ),
        ],
        padBottom: true,
    );

    Future<void> _addArtist(bool search) async {
        LidarrAPI _api = LidarrAPI.from(Database.currentProfileObject);
        final _database = Database.lunaSeaBox;
        await _api.addArtist(
            _arguments.data,
            _database.get(LidarrDatabaseValue.ADD_QUALITY_PROFILE.key),
            _database.get(LidarrDatabaseValue.ADD_ROOT_FOLDER.key),
            _database.get(LidarrDatabaseValue.ADD_METADATA_PROFILE.key),
            _database.get(LidarrDatabaseValue.ADD_MONITORED.key) ?? true,
            _database.get(LidarrDatabaseValue.ADD_ALBUM_FOLDERS.key) ?? true,
            search: search,
        )
        .then((_) => Navigator.of(context).pop(['artist_added', _arguments.data.title]))
        .catchError((_) => LSSnackBar(context: context, title: search ? 'Failed to Add Artist (With Search)' : 'Failed to Add Artist', message: Constants.CHECK_LOGS_MESSAGE, type: SNACKBAR_TYPE.failure));
    }
}
