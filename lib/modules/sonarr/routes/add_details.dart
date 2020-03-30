import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';
import '../../sonarr.dart';

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
    bool _monitored = true;
    bool _seasonFolders = true;

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
        .then((_) {})
        .catchError((error) => error);
    }

    Future<void> _fetchRootFolders(SonarrAPI api) async {
        return await api.getRootFolders()
        .then((values) {
            final _model = Provider.of<SonarrModel>(context, listen: false);
            _rootFolders = values;
            int index = _rootFolders.indexWhere((value) => 
                value.id == _model?.addRootFolder?.id &&
                value.path == _model?.addRootFolder?.path
            );
            _model.addRootFolder = index != -1 ? _rootFolders[index] : _rootFolders[0];
        })
        .catchError((error) => error);
    }

    Future<void> _fetchSeriesTypes() async {
        final _model = Provider.of<SonarrModel>(context, listen: false);
        int index = Constants.sonarrSeriesTypes.indexWhere((value) =>
            value.type == _model?.addSeriesType?.type,
        );
        _model.addSeriesType = index != -1 ? Constants.sonarrSeriesTypes[index] : Constants.sonarrSeriesTypes[0];
    }

    Future<void> _fetchQualityProfiles(SonarrAPI api) async {
        return await api.getQualityProfiles()
        .then((values) {
            final _model = Provider.of<SonarrModel>(context, listen: false);
            _qualityProfiles = values.values.toList();
            int index = _qualityProfiles.indexWhere((value) => 
                value.id == _model?.addQualityProfile?.id &&
                value.name == _model?.addQualityProfile?.name
            );
            _model.addQualityProfile = index != -1 ? _qualityProfiles[index] : _qualityProfiles[0];
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
                    ? 'No summary is available.\n\n\n'
                    : _arguments.data.overview,
                uri: _arguments.data.posterURI ?? '',
                fallbackImage: 'assets/images/sonarr/noseriesposter.png',
            ),
            LSDivider(),
            LSCardTile(
                title: LSTitle(text: 'Monitored'),
                subtitle: LSSubtitle(text: 'Monitor series for new releases'),
                trailing: Switch(
                    value: _monitored,
                    onChanged: (value) => setState(() => _monitored = value),
                ),
            ),
            LSCardTile(
                title: LSTitle(text: 'Use Season Folders'),
                subtitle: LSSubtitle(text: 'Sort episodes into season folders'),
                trailing: Switch(
                    value: _seasonFolders,
                    onChanged: (value) => setState(() => _seasonFolders = value),
                ),
            ),
            Consumer<SonarrModel>(
                builder: (context, model, widget) => LSCardTile(
                    title: LSTitle(text: 'Root Folder'),
                    subtitle: LSSubtitle(text: model.addRootFolder.path),
                    trailing: LSIconButton(icon: Icons.arrow_forward_ios),
                    onTap: () async {
                        List _values = await LSDialogSonarr.showEditRootFolderPrompt(context, _rootFolders);
                        if(_values[0]) model.addRootFolder = _values[1];
                    },
                ),
            ),
            Consumer<SonarrModel>(
                builder: (context, model, widget) => LSCardTile(
                    title: LSTitle(text: 'Quality Profile'),
                    subtitle: LSSubtitle(text: model.addQualityProfile.name),
                    trailing: LSIconButton(icon: Icons.arrow_forward_ios),
                    onTap: () async {
                        List _values = await LSDialogSonarr.showEditQualityProfilePrompt(context, _qualityProfiles);
                        if(_values[0]) model.addQualityProfile = _values[1];
                    },
                ),
            ),
            Consumer<SonarrModel>(
                builder: (context, model, widget) => LSCardTile(
                    title: LSTitle(text: 'Series Type'),
                    subtitle: LSSubtitle(text: model.addSeriesType.type.lsLanguage_Capitalize()),
                    trailing: LSIconButton(icon: Icons.arrow_forward_ios),
                    onTap: () async {
                        List _values = await LSDialogSonarr.showEditSeriesTypePrompt(context);
                        if(_values[0]) model.addSeriesType = _values[1];
                    },
                ),
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
        final _model = Provider.of<SonarrModel>(context, listen: false);
        await _api.addSeries(
            _arguments.data,
            _model.addQualityProfile,
            _model.addRootFolder,
            _model.addSeriesType,
            _seasonFolders,
            _monitored,
            search: search,
        )
        .then((_) => Navigator.of(context).pop(['series_added', _arguments.data.title]))
        .catchError((_) => LSSnackBar(context: context, title: search ? 'Failed to Add Series (With Search)' : 'Failed to Add Series', message: Constants.CHECK_LOGS_MESSAGE, type: SNACKBAR_TYPE.failure));
    }
}
