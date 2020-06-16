import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrEditMovieArguments {
    final RadarrCatalogueData data;

    RadarrEditMovieArguments({
        @required this.data,
    });
}

class RadarrEditMovie extends StatefulWidget {
    static const ROUTE_NAME = '/radarr/edit/movie';

    @override
    State<RadarrEditMovie> createState() => _State();
}

class _State extends State<RadarrEditMovie> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    
    RadarrEditMovieArguments _arguments;
    Future<void> _future;

    List<RadarrQualityProfile> _qualityProfiles = [];
    RadarrQualityProfile _qualityProfile;
    RadarrAvailability _minimumAvailability;
    String _path;
    bool _monitored;
    bool _staticPath;

    @override
    void initState() {
        super.initState();
        SchedulerBinding.instance.addPostFrameCallback((_) { 
            setState(() => _arguments = ModalRoute.of(context).settings.arguments);
            _refresh();
        });
    }

    Future<void> _refresh() async => setState(() => { _future = _fetch() });

    Future<bool> _fetch() async {
        final _api = RadarrAPI.from(Database.currentProfileObject);
        return _fetchProfiles(_api)
        .then((_) => _fetchMinimumAvailability())
        .then((_) {
            _path = _arguments.data.path;
            _monitored = _arguments.data.monitored;
            _staticPath = _arguments.data.staticPath;
            return true;
        })
        .catchError((error) => Future.error(error));
    }

    Future<void> _fetchProfiles(RadarrAPI api) async {
        return await api.getQualityProfiles()
        .then((profiles) {
            _qualityProfiles = profiles?.values?.toList();
            if(_qualityProfiles != null && _qualityProfiles.length > 0)
                _qualityProfile = _qualityProfiles.firstWhere((profile) => profile.id == _arguments.data.qualityProfile);
        })
        .catchError((error) => Future.error(error));
    }

    Future<void> _fetchMinimumAvailability() async {
        _minimumAvailability = RadarrConstants.MINIMUM_AVAILBILITIES.firstWhere((profile) => profile.id == _arguments.data.minimumAvailability, orElse: () => RadarrConstants.MINIMUM_AVAILBILITIES[0]);
    }

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        body: _body,
    );

    Widget get _appBar => LSAppBar(title: _arguments?.data?.title ?? 'Edit Movie');

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
                subtitle: LSSubtitle(text: 'Monitor movie for new releases'),
                trailing: Switch(
                    value: _monitored,
                    onChanged: (value) => setState(() => _monitored = value),
                ),
            ),
            LSCardTile(
                title: LSTitle(text: 'Static Path'),
                subtitle: LSSubtitle(text: 'Prevent directory from changing'),
                trailing: Switch(
                    value: _staticPath,
                    onChanged: (value) => setState(() => _staticPath = value),
                ),
            ),
            LSCardTile(
                title: LSTitle(text: 'Movie Path'),
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
                title: LSTitle(text: 'Minimum Availability'),
                subtitle: LSSubtitle(text: _minimumAvailability.name),
                trailing: LSIconButton(icon: Icons.arrow_forward_ios),
                onTap: () => _changeMinimumAvailability(),
            ),
            LSDivider(),
            LSButton(
                text: 'Update Movie',
                onTap: () async => _save().catchError((_) {}),
            ),
        ],
    );

    Future<void> _changePath() async {
        List<dynamic> _values = await GlobalDialogs.editText(context, 'Movie Path', prefill: _path);
        if(_values[0] && mounted) setState(() => _path = _values[1]);
    }

    Future<void> _changeProfile() async {
        List<dynamic> _values = await RadarrDialogs.editQualityProfile(context, _qualityProfiles);
        if(_values[0] && mounted) setState(() => _qualityProfile = _values[1]);
    }

    Future<void> _changeMinimumAvailability() async {
        List<dynamic> _values = await RadarrDialogs.editMinimumAvailability(context, RadarrConstants.MINIMUM_AVAILBILITIES);
        if(_values[0] && mounted) setState(() => _minimumAvailability = _values[1]);
    }

    Future<void> _save() async {
        final _api = RadarrAPI.from(Database.currentProfileObject);
        await _api.editMovie(
            _arguments.data.movieID,
            _qualityProfile,
            _minimumAvailability,
            _path,
            _monitored,
            _staticPath,
        )
        .then((_) {
            _arguments.data.qualityProfile = _qualityProfile.id;
            _arguments.data.profile = _qualityProfile.name;
            _arguments.data.minimumAvailability = _minimumAvailability.id;
            _arguments.data.staticPath = _staticPath;
            _arguments.data.path = _path;
            _arguments.data.monitored = _monitored;
            Navigator.of(context).pop([true]);
        })
        .catchError((_) => LSSnackBar(context: context, title: 'Failed to Update', message: Constants.CHECK_LOGS_MESSAGE, type: SNACKBAR_TYPE.failure));
    }
}
