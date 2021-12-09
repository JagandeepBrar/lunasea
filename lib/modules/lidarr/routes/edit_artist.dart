import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/lidarr.dart';

class LidarrEditArtistArguments {
  final LidarrCatalogueData entry;

  LidarrEditArtistArguments({
    @required this.entry,
  });
}

class LidarrEditArtist extends StatefulWidget {
  static const ROUTE_NAME = '/lidarr/edit/artist';

  const LidarrEditArtist({
    Key key,
  }) : super(key: key);

  @override
  State<LidarrEditArtist> createState() => _State();
}

class _State extends State<LidarrEditArtist> with LunaScrollControllerMixin {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  LidarrEditArtistArguments _arguments;
  Future<void> _future;

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
    SchedulerBinding.instance.addPostFrameCallback((_) {
      setState(() => _arguments = ModalRoute.of(context).settings.arguments);
      _refresh();
    });
  }

  @override
  Widget build(BuildContext context) => LunaScaffold(
        scaffoldKey: _scaffoldKey,
        body: _body,
        appBar: _appBar,
        bottomNavigationBar: _bottomActionBar(),
      );

  Future<void> _refresh() async => setState(() => {_future = _fetch()});

  Future<bool> _fetch() async {
    final _api = LidarrAPI.from(Database.currentProfileObject);
    return _fetchProfiles(_api).then((_) => _fetchMetadata(_api)).then((_) {
      _path = _arguments.entry.path;
      _monitored = _arguments.entry.monitored;
      _albumFolders = _arguments.entry.albumFolders;
      return true;
    });
  }

  Future<void> _fetchProfiles(LidarrAPI api) async {
    return await api.getQualityProfiles().then((profiles) {
      _qualityProfiles = profiles?.values?.toList();
      if (_qualityProfiles?.isNotEmpty ?? false) {
        for (var profile in _qualityProfiles) {
          if (profile.id == _arguments.entry.qualityProfile) {
            _qualityProfile = profile;
          }
        }
      }
    });
  }

  Future<void> _fetchMetadata(LidarrAPI api) async {
    return await api.getMetadataProfiles().then((metadatas) {
      _metadataProfiles = metadatas?.values?.toList();
      if (_metadataProfiles?.isNotEmpty ?? false) {
        for (var profile in _metadataProfiles) {
          if (profile.id == _arguments.entry.metadataProfile) {
            _metadataProfile = profile;
          }
        }
      }
    });
  }

  Widget get _appBar => LunaAppBar(
        title: _arguments?.entry?.title ?? 'Edit Artist',
        scrollControllers: [scrollController],
      );

  Widget _bottomActionBar() {
    return LunaBottomActionBar(
      actions: [
        LunaButton.text(
          text: 'lunasea.Update'.tr(),
          icon: Icons.edit_rounded,
          onTap: _save,
        ),
      ],
    );
  }

  Widget get _body => FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              {
                if (snapshot.hasError || snapshot.data == null)
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
        itemExtent: LunaListTile.itemExtent,
        children: <Widget>[
          LunaListTile(
            context: context,
            title: LunaText.title(text: 'Monitored'),
            subtitle:
                LunaText.subtitle(text: 'Monitor artist for new releases'),
            trailing: LunaSwitch(
              value: _monitored,
              onChanged: (value) => setState(() => _monitored = value),
            ),
          ),
          LunaListTile(
            context: context,
            title: LunaText.title(text: 'Use Album Folders'),
            subtitle: LunaText.subtitle(text: 'Sort tracks into album folders'),
            trailing: LunaSwitch(
              value: _albumFolders,
              onChanged: (value) => setState(() => _albumFolders = value),
            ),
          ),
          LunaListTile(
            context: context,
            title: LunaText.title(text: 'Artist Path'),
            subtitle: LunaText.subtitle(text: _path),
            trailing: LunaIconButton(icon: Icons.arrow_forward_ios_rounded),
            onTap: _changePath,
          ),
          LunaListTile(
            context: context,
            title: LunaText.title(text: 'Quality Profile'),
            subtitle: LunaText.subtitle(text: _qualityProfile.name),
            trailing: LunaIconButton(icon: Icons.arrow_forward_ios_rounded),
            onTap: _changeProfile,
          ),
          LunaListTile(
            context: context,
            title: LunaText.title(text: 'Metadata Profile'),
            subtitle: LunaText.subtitle(text: _metadataProfile.name),
            trailing: LunaIconButton(icon: Icons.arrow_forward_ios_rounded),
            onTap: _changeMetadata,
          ),
        ],
      );

  Future<void> _changePath() async {
    Tuple2<bool, String> _values =
        await LunaDialogs().editText(context, 'Artist Path', prefill: _path);
    if (_values.item1 && mounted) setState(() => _path = _values.item2);
  }

  Future<void> _changeProfile() async {
    List<dynamic> _values =
        await LidarrDialogs.editQualityProfile(context, _qualityProfiles);
    if (_values[0] && mounted) setState(() => _qualityProfile = _values[1]);
  }

  Future<void> _changeMetadata() async {
    List<dynamic> _values =
        await LidarrDialogs.editMetadataProfile(context, _metadataProfiles);
    if (_values[0] && mounted) setState(() => _metadataProfile = _values[1]);
  }

  Future<void> _save() async {
    final _api = LidarrAPI.from(Database.currentProfileObject);
    await _api
        .editArtist(
      _arguments.entry.artistID,
      _qualityProfile,
      _metadataProfile,
      _path,
      _monitored,
      _albumFolders,
    )
        .then((_) {
      _arguments.entry.qualityProfile = _qualityProfile.id;
      _arguments.entry.quality = _qualityProfile.name;
      _arguments.entry.metadataProfile = _metadataProfile.id;
      _arguments.entry.metadata = _metadataProfile.name;
      _arguments.entry.path = _path;
      _arguments.entry.monitored = _monitored;
      _arguments.entry.albumFolders = _albumFolders;
      Navigator.of(context).pop([true]);
    }).catchError((error, stack) {
      LunaLogger().error('Failed to update artist', error, stack);
      showLunaErrorSnackBar(
        title: 'Failed to Update',
        error: error,
      );
    });
  }
}
