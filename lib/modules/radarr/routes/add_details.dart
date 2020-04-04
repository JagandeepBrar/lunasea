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
    bool _monitored = true;

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
            final _model = Provider.of<RadarrModel>(context, listen: false);
            _rootFolders = values;
            int index = _rootFolders.indexWhere((value) => 
                value.id == _model?.addRootFolder?.id &&
                value.path == _model?.addRootFolder?.path
            );
            _model.addRootFolder = index != -1 ? _rootFolders[index] : _rootFolders[0];
        })
        .catchError((error) => error);
    }

    Future<void> _fetchQualityProfiles(RadarrAPI api) async {
        return await api.getQualityProfiles()
        .then((values) {
            final _model = Provider.of<RadarrModel>(context, listen: false);
            _qualityProfiles = values.values.toList();
            int index = _qualityProfiles.indexWhere((value) => 
                value.id == _model?.addQualityProfile?.id &&
                value.name == _model?.addQualityProfile?.name
            );
            _model.addQualityProfile = index != -1 ? _qualityProfiles[index] : _qualityProfiles[0];
        })
        .catchError((error) => error);
    }

    Future<void> _fetchAvailability() async {
        final _model = Provider.of<RadarrModel>(context, listen: false);
        int index = Constants.radarrMinAvailability.indexWhere((value) => 
            value.id == _model?.addAvailability?.id &&
            value.name == _model?.addAvailability?.name
        );
        _model.addAvailability = index != -1 ? Constants.radarrMinAvailability[index] : Constants.radarrMinAvailability[0];
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
                    ? 'No summary is available.\n\n\n'
                    : _arguments.data.overview,
                uri: _arguments.data.posterURI ?? '',
                fallbackImage: 'assets/images/radarr/nomovieposter.png',
            ),
            LSDivider(),
            LSCardTile(
                title: LSTitle(text: 'Monitored'),
                subtitle: LSSubtitle(text: 'Monitor movie for new releases'),
                trailing: Switch(
                    value: _monitored,
                    onChanged: (value) => setState(() => _monitored = value),
                ),
            ),
            Consumer<RadarrModel>(
                builder: (context, model, widget) => LSCardTile(
                    title: LSTitle(text: 'Root Folder'),
                    subtitle: LSSubtitle(text: model.addRootFolder.path),
                    trailing: LSIconButton(icon: Icons.arrow_forward_ios),
                    onTap: () async {
                        List _values = await LSDialogRadarr.showEditRootFolderPrompt(context, _rootFolders);
                        if(_values[0]) model.addRootFolder = _values[1];
                    },
                ),
            ),
            Consumer<RadarrModel>(
                builder: (context, model, widget) => LSCardTile(
                    title: LSTitle(text: 'Quality Profile'),
                    subtitle: LSSubtitle(text: model.addQualityProfile.name),
                    trailing: LSIconButton(icon: Icons.arrow_forward_ios),
                    onTap: () async {
                        List _values = await LSDialogRadarr.showEditQualityProfilePrompt(context, _qualityProfiles);
                        if(_values[0]) model.addQualityProfile = _values[1];
                    },
                ),
            ),
            Consumer<RadarrModel>(
                builder: (context, model, widget) => LSCardTile(
                    title: LSTitle(text: 'Minimum Availability'),
                    subtitle: LSSubtitle(text: model.addAvailability.name),
                    trailing: LSIconButton(icon: Icons.arrow_forward_ios),
                    onTap: () async {
                        List _values = await LSDialogRadarr.showMinimumAvailabilityPrompt(context, Constants.radarrMinAvailability);
                        if(_values[0]) model.addAvailability = _values[1];
                    },
                ),
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
        final _model = Provider.of<RadarrModel>(context, listen: false);
        await _api.addMovie(
            _arguments.data,
            _model.addQualityProfile,
            _model.addRootFolder,
            _model.addAvailability,
            _monitored,
            search: search,
        )
        .then((_) => Navigator.of(context).pop(['movie_added', _arguments.data.title]))
        .catchError((_) => LSSnackBar(context: context, title: search ? 'Failed to Add Movie (With Search)' : 'Failed to Add Movie', message: Constants.CHECK_LOGS_MESSAGE, type: SNACKBAR_TYPE.failure));
    }
}
