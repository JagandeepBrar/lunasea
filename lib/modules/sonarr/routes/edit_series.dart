import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrEditSeriesArguments {
    final SonarrCatalogueData data;

    SonarrEditSeriesArguments({
        @required this.data,
    });
}

class SonarrEditSeries extends StatefulWidget {
    static const ROUTE_NAME = '/sonarr/edit/series';

    @override
    State<SonarrEditSeries> createState() => _State();
}

class _State extends State<SonarrEditSeries> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    
    SonarrEditSeriesArguments _arguments;
    Future<void> _future;

    List<SonarrQualityProfile> _qualityProfiles = [];
    SonarrQualityProfile _qualityProfile;
    SonarrSeriesType _seriesType;

    String _path;
    bool _monitored;
    bool _seasonFolders;

    @override
    void initState() {
        super.initState();
        SchedulerBinding.instance.addPostFrameCallback((_) { 
            setState(() => _arguments = ModalRoute.of(context).settings.arguments);
            _refresh();
        });
    }

    Future<void> _refresh() async => setState(() { _future = _fetch().catchError((error) {}); });

    Future<bool> _fetch() async {
        final _api = SonarrAPI.from(Database.currentProfileObject);
        return _fetchProfiles(_api)
        .then((_) {
            int index = SonarrConstants.SERIES_TYPES.indexWhere((type) => type.type == _arguments.data.type);
            _seriesType = SonarrConstants.SERIES_TYPES[index == -1 ? 0 : index];
            _path = _arguments.data.path;
            _monitored = _arguments.data.monitored;
            _seasonFolders = _arguments.data.seasonFolder;
            return true;
        })
        .catchError((error) => Future.error(error));
    }

    Future<void> _fetchProfiles(SonarrAPI api) async {
        return await api.getQualityProfiles()
        .then((profiles) {
            _qualityProfiles = profiles?.values?.toList();
            if(_qualityProfiles != null && _qualityProfiles.length > 0)
                _qualityProfile = _qualityProfiles.firstWhere((profile) => profile.id == _arguments.data.qualityProfile);
        })
        .catchError((error) => error);
    }

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        body: _body,
    );

    Widget get _appBar => LSAppBar(title: _arguments?.data?.title ?? 'Edit Series');

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
                subtitle: LSSubtitle(text: 'Monitor series for new releases'),
                trailing: Switch(
                    value: _monitored,
                    onChanged: (value) => setState(() => _monitored = value),
                ),
            ),
            LSCardTile(
                title: LSTitle(text: 'Season Folders'),
                subtitle: LSSubtitle(text: 'Sort episodes into season folders'),
                trailing: Switch(
                    value: _seasonFolders,
                    onChanged: (value) => setState(() => _seasonFolders = value),
                ),
            ),
            LSCardTile(
                title: LSTitle(text: 'Series Path'),
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
                title: LSTitle(text: 'Series Type'),
                subtitle: LSSubtitle(text: _seriesType.type.lsLanguage_Capitalize()),
                trailing: LSIconButton(icon: Icons.arrow_forward_ios),
                onTap: () => _changeType(),
            ),
            LSDivider(),
            LSButton(
                text: 'Update Series',
                onTap: () async => _save().catchError((_) {}),
            ),
        ],
    );

    Future<void> _changePath() async {
        List<dynamic> _values = await GlobalDialogs.editText(context, 'Series Path', prefill: _path);
        if(_values[0] && mounted) setState(() => _path = _values[1]);
    }

    Future<void> _changeProfile() async {
        List<dynamic> _values = await SonarrDialogs.editQualityProfile(context, _qualityProfiles);
        if(_values[0] && mounted) setState(() => _qualityProfile = _values[1]);
    }

    Future<void> _changeType() async {
        List<dynamic> _values = await SonarrDialogs.editSeriesType(context);
        if(_values[0] && mounted) setState(() => _seriesType = _values[1]);
    }

    Future<void> _save() async {
        final _api = SonarrAPI.from(Database.currentProfileObject);
        await _api.editSeries(
            _arguments.data.seriesID,
            _qualityProfile,
            _seriesType,
            _path,
            _monitored,
            _seasonFolders,
        )
        .then((_) {
            _arguments.data.qualityProfile = _qualityProfile.id;
            _arguments.data.profile = _qualityProfile.name;
            _arguments.data.type = _seriesType.type;
            _arguments.data.seasonFolder = _seasonFolders;
            _arguments.data.path = _path;
            _arguments.data.monitored = _monitored;
            Navigator.of(context).pop([true]);
        })
        .catchError((_) => LSSnackBar(context: context, title: 'Failed to Update', message: Constants.CHECK_LOGS_MESSAGE, type: SNACKBAR_TYPE.failure));
    }
}