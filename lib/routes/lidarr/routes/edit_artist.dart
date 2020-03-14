import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lunasea/widgets.dart';
import 'package:lunasea/core.dart';

class LidarrEditArtistArguments {
    final LidarrCatalogueData entry;

    LidarrEditArtistArguments({
        @required this.entry,
    });
}

class LidarrEditArtist extends StatefulWidget {
    static const ROUTE_NAME = '/lidarr/edit/artist';

    @override
    State<LidarrEditArtist> createState() => _State();
}

class _State extends State<LidarrEditArtist> {
    final _scaffoldKey = GlobalKey<ScaffoldState>();

    LidarrEditArtistArguments _arguments;
    Future<void> _future;
    bool _showFAB = false;

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
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        body: _body,
        appBar: _appBar,
        floatingActionButton: _floatingActionButton,
    );

    Future<void> _refresh() async => setState(() => { _future = _fetch() });

    Future<bool> _fetch() async {
        setState(() => _showFAB = false);
        final _api = LidarrAPI.from(Database.currentProfileObject);
        await _fetchProfiles(_api);
        await _fetchMetadata(_api);
        _path = _arguments.entry.path;
        _monitored = _arguments.entry.monitored;
        _albumFolders = _arguments.entry.albumFolders;
        setState(() => _showFAB = true);
        return true;
    }

    Future<void> _fetchProfiles(LidarrAPI api) async {
        final profiles = await api.getQualityProfiles();
        _qualityProfiles = profiles?.values?.toList();
        if(_qualityProfiles != null && _qualityProfiles.length != 0) {
            for(var profile in _qualityProfiles) {
                if(profile.id == _arguments.entry.qualityProfile) {
                    _qualityProfile = profile;
                }
            }
        }
    }

    Future<void> _fetchMetadata(LidarrAPI api) async {
        final metadatas = await api.getMetadataProfiles();
        _metadataProfiles = metadatas?.values?.toList();
        if(_metadataProfiles != null && _metadataProfiles.length != 0) {
            for(var profile in _metadataProfiles) {
                if(profile.id == _arguments.entry.metadataProfile) {
                    _metadataProfile = profile;
                }
            }
        }
    }

    Widget get _appBar => LSAppBar(title: _arguments?.entry?.title ?? 'Edit Artist');

    Widget get _floatingActionButton => _showFAB
        ? LSFloatingActionButton(
            icon: Icons.save,
            onPressed: () => _save(),
        )
        : Container();

    Widget get _body => FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
            switch(snapshot.connectionState) {
                case ConnectionState.done: {
                    if(snapshot.hasError || snapshot.data == null) return LSErrorMessage(onTapHandler: () => _refresh());
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
            LSCardTile(
                title: LSTitle(text: 'Monitored'),
                subtitle: LSSubtitle(text: 'Monitor artist for new releases'),
                trailing: Switch(
                    value: _monitored,
                    onChanged: (value) => setState(() => _monitored = value),
                ),
            ),
            LSCardTile(
                title: LSTitle(text: 'Use Album Folders'),
                subtitle: LSSubtitle(text: 'Sort tracks into album folders'),
                trailing: Switch(
                    value: _albumFolders,
                    onChanged: (value) => setState(() => _albumFolders = value),
                ),
            ),
            LSCardTile(
                title: LSTitle(text: 'Artist Path'),
                subtitle: LSSubtitle(text: _path),
                trailing: LSIconButton(icon: Icons.arrow_forward_ios),
                onTap: () => _changePath(),
            ),
            LSCardTile(
                title: LSTitle(text: 'Quality Profile'),
                subtitle: LSSubtitle(text: _qualityProfile.name),
                trailing: LSIconButton(icon: Icons.arrow_forward_ios),
                onTap: () => _changeProfile(),
            ),
            LSCardTile(
                title: LSTitle(text: 'Metadata Profile'),
                subtitle: LSSubtitle(text: _metadataProfile.name),
                trailing: LSIconButton(icon: Icons.arrow_forward_ios),
                onTap: () => _changeMetadata(),
            ),
        ],
        padBottom: true,
    );

    Future<void> _changePath() async {
        List<dynamic> _values = await SystemDialogs.showEditTextPrompt(context, 'Artist Path', prefill: _path);
        if(_values[0] && mounted) setState(() => _path = _values[1]);
    }

    Future<void> _changeProfile() async {
        List<dynamic> _values = await LidarrDialogs.showEditQualityProfilePrompt(context, _qualityProfiles);
        if(_values[0] && mounted) setState(() => _qualityProfile = _values[1]);
    }

    Future<void> _changeMetadata() async {
        List<dynamic> _values = await LidarrDialogs.showEditMetadataProfilePrompt(context, _metadataProfiles);
        if(_values[0] && mounted) setState(() => _metadataProfile = _values[1]);
    }

    Future<void> _save() async {
        final _api = LidarrAPI.from(Database.currentProfileObject);
        if(await _api.editArtist(_arguments.entry.artistID, _qualityProfile, _metadataProfile, _path, _monitored, _albumFolders)) {
            _arguments.entry.qualityProfile = _qualityProfile.id;
            _arguments.entry.quality = _qualityProfile.name;
            _arguments.entry.metadataProfile = _metadataProfile.id;
            _arguments.entry.metadata = _metadataProfile.name;
            _arguments.entry.path = _path;
            _arguments.entry.monitored = _monitored;
            _arguments.entry.albumFolders = _albumFolders;
            Navigator.of(context).pop([true]);
        } else {
            LSSnackBar(context: context, title: 'Failed to Update', message: _arguments.entry.title, type: SNACKBAR_TYPE.failure);
        }
    }
}
