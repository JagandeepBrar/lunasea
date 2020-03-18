import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/widgets/ui.dart';

class RadarrDetailsSearchResultsArguments {
    final RadarrReleaseData data;

    RadarrDetailsSearchResultsArguments({
        @required this.data,
    });
}

class RadarrDetailsSearchResults extends StatefulWidget {    
    static const ROUTE_NAME = '/radarr/details/search/details';

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<RadarrDetailsSearchResults> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    RadarrDetailsSearchResultsArguments _arguments;

    @override
    void initState() {
        super.initState();
        SchedulerBinding.instance.addPostFrameCallback((_) => setState(() {
            _arguments = ModalRoute.of(context).settings.arguments;
        }));
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
                    onPressed: () async => _arguments.data.infoUrl == null || _arguments.data.infoUrl == ''
                        ? LSSnackBar(
                            context: context,
                            title: 'No Information Page Available',
                            message: 'No information URL is available',
                        )
                        : _arguments.data.infoUrl.lsLinks_OpenLink()
                )
            ],
        );

    Widget get _body => _arguments == null
        ? null
        : _list;
    
    Widget get _list => LSListView(
        children: <Widget>[
            LSCardTile(
                title: LSTitle(text: 'Release Title'),
                subtitle: LSSubtitle(text: _arguments.data.title),
                trailing: LSIconButton(icon: Icons.arrow_forward_ios),
                onTap: () async => SystemDialogs.showTextPreviewPrompt(context, 'Release Title', _arguments.data.title),
            ),
            LSContainerRow(
                children: <Widget>[
                    Expanded(
                        child: LSCardTile(
                            title: LSTitle(text: 'Protocol', centerText: true),
                            subtitle: LSSubtitle(text: _arguments.data.protocol.lsLanguage_Capitalize(), centerText: true),
                            reducedMargin: true,
                        ),
                    ),
                    Expanded(
                        child: LSCardTile(
                            title: LSTitle(text: 'Indexer', centerText: true),
                            subtitle: LSSubtitle(text: _arguments.data.indexer, centerText: true),
                            reducedMargin: true,
                        ),
                    ),
                ],
            ),
            LSContainerRow(
                children: <Widget>[
                    Expanded(
                        child: LSCardTile(
                            title: LSTitle(text: 'Age', centerText: true),
                            subtitle: LSSubtitle(text: _arguments.data.ageHours.lsTime_releaseAgeString(), centerText: true),
                            reducedMargin: true,
                        ),
                    ),
                    Expanded(
                        child: LSCardTile(
                            title: LSTitle(text: 'Size', centerText: true),
                            subtitle: LSSubtitle(text: _arguments.data.size.lsBytes_BytesToString(), centerText: true),
                            reducedMargin: true,
                        ),
                    ),
                ],
            ),
            if(_arguments.data.isTorrent) LSContainerRow(
                children: <Widget>[
                    Expanded(
                        child: LSCardTile(
                            title: LSTitle(text: 'Seeders', centerText: true),
                            subtitle: LSSubtitle(
                                text: _arguments.data.seeders == 1
                                    ? '${_arguments.data.seeders} Seeder'
                                    : '${_arguments.data.seeders} Seeders',
                                centerText: true,
                            ),
                            reducedMargin: true,
                        ),
                    ),
                    Expanded(
                        child: LSCardTile(
                            title: LSTitle(text: 'Leechers', centerText: true),
                            subtitle: LSSubtitle(
                                text: _arguments.data.leechers == 1
                                    ? '${_arguments.data.leechers} Leecher'
                                    : '${_arguments.data.leechers} Leechers',
                                centerText: true,
                            ),
                            reducedMargin: true,
                        ),
                    ),
                ],
            ),
            LSContainerRow(
                children: <Widget>[
                    Expanded(
                        child: LSButton(
                            text: 'Download',
                            onTap: () => _download(),
                            reducedMargin: true,
                        ),
                    ),
                    if(!_arguments.data.approved) Expanded(
                        child: LSButton(
                            text: 'Rejected',
                            backgroundColor: LSColors.red,
                            onTap: () => _warnings(),
                            reducedMargin: true,
                        ),
                    ),
                ],
            ),
        ],
        padBottom: true,
    );

    Future<void> _download() async {
        if(_arguments.data.approved) {
            await _startDownload()
            .then((_) => LSSnackBar(context: context, title: 'Downloading...', message: _arguments.data.title, type: SNACKBAR_TYPE.success))
            .catchError((_) => LSSnackBar(context: context, title: 'Failed to Start Downloading', message: Constants.CHECK_LOGS_MESSAGE, type: SNACKBAR_TYPE.failure));
        } else {
            List<dynamic> values = await RadarrDialogs.showDownloadWarningPrompt(context);
            if(values[0]) await _startDownload()
            .then((_) => LSSnackBar(context: context, title: 'Downloading...', message: _arguments.data.title, type: SNACKBAR_TYPE.success))
            .catchError((_) => LSSnackBar(context: context, title: 'Failed to Start Downloading', message: Constants.CHECK_LOGS_MESSAGE, type: SNACKBAR_TYPE.failure));
        }
    }

    Future<bool> _startDownload() async {
        RadarrAPI _api = RadarrAPI.from(Database.currentProfileObject);
        return await _api.downloadRelease(_arguments.data.guid, _arguments.data.indexerId);
    }

    Future<void> _warnings() async {
        String reject = '';
        for(var i=0; i<_arguments.data.rejections.length; i++) {
            reject += '${i+1}. ${_arguments.data.rejections[i]}\n';
        }
        await SystemDialogs.showTextPreviewPrompt(context, 'Rejection Reasons', reject.substring(0, reject.length-1));
    }
}
