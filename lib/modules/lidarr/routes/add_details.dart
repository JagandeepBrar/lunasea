import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/lidarr.dart';

class LidarrAddDetailsArguments {
  final LidarrSearchData data;

  LidarrAddDetailsArguments({
    @required this.data,
  });
}

class LidarrAddDetails extends StatefulWidget {
  static const ROUTE_NAME = '/lidarr/add/details';

  const LidarrAddDetails({
    Key key,
  }) : super(key: key);

  @override
  State<LidarrAddDetails> createState() => _State();
}

class _State extends State<LidarrAddDetails> with LunaScrollControllerMixin {
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
    return await api.getRootFolders().then((values) {
      LidarrRootFolder _rootfolder = LidarrDatabaseValue.ADD_ROOT_FOLDER.data;
      _rootFolders = values;
      int index = _rootFolders.indexWhere((value) =>
          value.id == _rootfolder?.id && value.path == _rootfolder?.path);
      LidarrDatabaseValue.ADD_ROOT_FOLDER
          .put(index != -1 ? _rootFolders[index] : _rootFolders[0]);
    }).catchError((error) {
      Future.error(error);
    });
  }

  Future<void> _fetchQualityProfiles(LidarrAPI api) async {
    return await api.getQualityProfiles().then((values) {
      LidarrQualityProfile _profile =
          LidarrDatabaseValue.ADD_QUALITY_PROFILE.data;
      _qualityProfiles = values.values.toList();
      int index = _qualityProfiles.indexWhere(
          (value) => value.id == _profile?.id && value.name == _profile?.name);
      LidarrDatabaseValue.ADD_QUALITY_PROFILE
          .put(index != -1 ? _qualityProfiles[index] : _qualityProfiles[0]);
    }).catchError((error) => error);
  }

  Future<void> _fetchMetadataProfiles(LidarrAPI api) async {
    return await api.getMetadataProfiles().then((values) {
      LidarrMetadataProfile _profile =
          LidarrDatabaseValue.ADD_METADATA_PROFILE.data;
      _metadataProfiles = values.values.toList();
      int index = _metadataProfiles.indexWhere(
          (value) => value.id == _profile?.id && value.name == _profile?.name);
      LidarrDatabaseValue.ADD_METADATA_PROFILE
          .put(index != -1 ? _metadataProfiles[index] : _metadataProfiles[0]);
    }).catchError((error) => error);
  }

  @override
  Widget build(BuildContext context) => LunaScaffold(
        scaffoldKey: _scaffoldKey,
        appBar: _appBar,
        body: _body,
        bottomNavigationBar: _bottomActionBar(),
      );

  Widget _bottomActionBar() {
    return LunaBottomActionBar(
      actions: [
        LunaButton.text(
          text: 'Add',
          icon: Icons.add_rounded,
          onTap: () async => _addArtist(false),
        ),
        LunaButton.text(
          text: 'Add + Search',
          icon: Icons.search_rounded,
          onTap: () async => _addArtist(true),
        ),
      ],
    );
  }

  Widget get _appBar => _arguments == null
      ? null
      : LunaAppBar(
          title: _arguments.data.title,
          scrollControllers: [scrollController],
          actions: [
            LunaIconButton(
              icon: Icons.link_rounded,
              onPressed: () async {
                if (_arguments.data.discogsLink == null ||
                    _arguments.data.discogsLink == '')
                  showLunaInfoSnackBar(
                    title: 'No Discogs Page Available',
                    message: 'No Discogs URL is available',
                  );
                _arguments.data.discogsLink.lunaOpenGenericLink();
              },
            )
          ],
        );

  Widget get _body => _arguments == null
      ? null
      : FutureBuilder(
          future: _future,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                {
                  if (snapshot.hasError)
                    return LunaMessage.error(onTap: _refresh);
                  return _list;
                }
              case ConnectionState.none:
              case ConnectionState.waiting:
              case ConnectionState.active:
              default:
                return const LunaLoader();
            }
          },
        );

  Widget get _list => LunaListView(
        controller: scrollController,
        children: <Widget>[
          LidarrDescriptionBlock(
            title: _arguments.data.title ?? 'Unknown',
            description: _arguments.data.overview == ''
                ? 'No Summary Available'
                : _arguments.data.overview,
            uri: _arguments.data.posterURI ?? '',
            squareImage: true,
            headers: Database.currentProfileObject.getLidarr()['headers'],
          ),
          ValueListenableBuilder(
              valueListenable: Database.lunaSeaBox
                  .listenable(keys: [LidarrDatabaseValue.ADD_MONITORED.key]),
              builder: (context, box, widget) {
                return LunaBlock(
                  title: 'Monitored',
                  body: const [
                    TextSpan(text: 'Monitor artist for new releases'),
                  ],
                  trailing: LunaSwitch(
                    value: LidarrDatabaseValue.ADD_MONITORED.data,
                    onChanged: (value) =>
                        LidarrDatabaseValue.ADD_MONITORED.put(value),
                  ),
                );
              }),
          ValueListenableBuilder(
              valueListenable: Database.lunaSeaBox.listenable(
                  keys: [LidarrDatabaseValue.ADD_ALBUM_FOLDERS.key]),
              builder: (context, box, widget) {
                return LunaBlock(
                  title: 'Use Album Folders',
                  body: const [
                    TextSpan(text: 'Sort tracks into album folders'),
                  ],
                  trailing: LunaSwitch(
                    value: LidarrDatabaseValue.ADD_ALBUM_FOLDERS.data,
                    onChanged: (value) =>
                        LidarrDatabaseValue.ADD_ALBUM_FOLDERS.put(value),
                  ),
                );
              }),
          ValueListenableBuilder(
            valueListenable: Database.lunaSeaBox
                .listenable(keys: [LidarrDatabaseValue.ADD_ROOT_FOLDER.key]),
            builder: (context, box, widget) {
              LidarrRootFolder _rootfolder =
                  LidarrDatabaseValue.ADD_ROOT_FOLDER.data;
              return LunaBlock(
                title: 'Root Folder',
                body: [
                  TextSpan(text: _rootfolder?.path ?? 'Unknown Root Folder'),
                ],
                trailing: const LunaIconButton.arrow(),
                onTap: () async {
                  List _values =
                      await LidarrDialogs.editRootFolder(context, _rootFolders);
                  if (_values[0])
                    LidarrDatabaseValue.ADD_ROOT_FOLDER.put(_values[1]);
                },
              );
            },
          ),
          ValueListenableBuilder(
            valueListenable: Database.lunaSeaBox.listenable(
                keys: [LidarrDatabaseValue.ADD_QUALITY_PROFILE.key]),
            builder: (context, box, widget) {
              LidarrQualityProfile _profile =
                  LidarrDatabaseValue.ADD_QUALITY_PROFILE.data;
              return LunaBlock(
                title: 'Quality Profile',
                body: [
                  TextSpan(text: _profile?.name ?? 'Unknown Profile'),
                ],
                trailing: const LunaIconButton.arrow(),
                onTap: () async {
                  List _values = await LidarrDialogs.editQualityProfile(
                      context, _qualityProfiles);
                  if (_values[0])
                    LidarrDatabaseValue.ADD_QUALITY_PROFILE.put(_values[1]);
                },
              );
            },
          ),
          ValueListenableBuilder(
            valueListenable: Database.lunaSeaBox.listenable(
                keys: [LidarrDatabaseValue.ADD_METADATA_PROFILE.key]),
            builder: (context, box, widget) {
              LidarrMetadataProfile _profile =
                  LidarrDatabaseValue.ADD_METADATA_PROFILE.data;
              return LunaBlock(
                title: 'Metadata Profile',
                body: [
                  TextSpan(text: _profile?.name ?? 'Unknown Profile'),
                ],
                trailing: const LunaIconButton.arrow(),
                onTap: () async {
                  List _values = await LidarrDialogs.editMetadataProfile(
                      context, _metadataProfiles);
                  if (_values[0])
                    LidarrDatabaseValue.ADD_METADATA_PROFILE.put(_values[1]);
                },
              );
            },
          ),
        ],
      );

  Future<void> _addArtist(bool search) async {
    LidarrAPI _api = LidarrAPI.from(Database.currentProfileObject);
    await _api
        .addArtist(
          _arguments.data,
          LidarrDatabaseValue.ADD_QUALITY_PROFILE.data,
          LidarrDatabaseValue.ADD_ROOT_FOLDER.data,
          LidarrDatabaseValue.ADD_METADATA_PROFILE.data,
          LidarrDatabaseValue.ADD_MONITORED.data ?? true,
          LidarrDatabaseValue.ADD_ALBUM_FOLDERS.data ?? true,
          search: search,
        )
        .then((id) => Navigator.of(context)
            .pop(['artist_added', _arguments.data.title, id]))
        .catchError((error, stack) {
      LunaLogger().error('Failed to add artist', error, stack);
      showLunaErrorSnackBar(
        title: search
            ? 'Failed to Add Artist (With Search)'
            : 'Failed to Add Artist',
        error: error,
      );
    });
  }
}
