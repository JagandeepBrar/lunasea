import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/widgets/ui.dart';

class LidarrSearchDetailsArguments {
    final LidarrReleaseData data;

    LidarrSearchDetailsArguments({
        @required this.data,
    });
}

class LidarrSearchDetails extends StatefulWidget {
    static const ROUTE_NAME = '/lidarr/search/details';

    @override
    State<LidarrSearchDetails> createState() => _State();
}

class _State extends State<LidarrSearchDetails> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    LidarrSearchDetailsArguments _arguments;

    @override
    void initState() {
        super.initState();
        SchedulerBinding.instance.scheduleFrameCallback((_) {
            setState(() => _arguments = ModalRoute.of(context).settings.arguments);
        });
    }

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        body: _body,
        appBar: _appBar,
        floatingActionButton: _floatingActionButton,
    );

    Widget get _appBar => LSAppBar(
        title: _arguments == null ? 'Result Details' : _arguments.data.title,
        actions: <Widget>[
            LSIconButton(
                icon: Icons.link,
                onPressed: () async {
                    _arguments.data.infoUrl != null && _arguments.data.infoUrl != ''
                        ? await _arguments.data.infoUrl.lsLinks_OpenLink()
                        : LSSnackBar(
                            context: context,
                            title: 'Information URL',
                            message: 'No information URL is available',
                        );
                },
            ),
        ],
    );

    Widget get _body => _arguments == null
        ? null
        : LSListView(
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
            ],
            padBottom: true,
        );

    Widget get _floatingActionButton => _arguments == null
        ? null
        : Column(
            children: <Widget>[
                if(!_arguments.data.approved) Padding(
                    child: LSFloatingActionButton(
                        icon: Icons.report,
                        backgroundColor: Colors.red,
                        onPressed: () async => await _warningFABAction(),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                ),
                LSFloatingActionButton(
                    icon: Icons.cloud_download,
                    onPressed: () async => _downloadFABAction(),
                ),
            ],
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
        );

    Future<void> _warningFABAction() async => _showWarnings();

    Future<void> _downloadFABAction() async {
        if(_arguments.data.approved) {
            await _startDownload()
                ? LSSnackBar(
                    context: context,
                    title: 'Downloading...',
                    message: _arguments.data.title,
                    type: SNACKBAR_TYPE.success,
                )
                : LSSnackBar(
                    context: context,
                    title: 'Failed to Start Downloading',
                    message: Constants.CHECK_LOGS_MESSAGE,
                    type: SNACKBAR_TYPE.failure,
                );
        } else {
            List<dynamic> values = await LidarrDialogs.showDownloadWarningPrompt(context);
            if(values[0]) await _startDownload()
                ? LSSnackBar(
                    context: context,
                    title: 'Downloading...',
                    message: _arguments.data.title,
                    type: SNACKBAR_TYPE.success,
                )
                : LSSnackBar(
                    context: context,
                    title: 'Failed to Start Downloading',
                    message: Constants.CHECK_LOGS_MESSAGE,
                    type: SNACKBAR_TYPE.failure,
                );
        }
    }

    Future<void> _showWarnings() async {
        String reject = '';
        for(var i=0; i<_arguments.data.rejections.length; i++) {
            reject += '${i+1}. ${_arguments.data.rejections[i]}\n';
        }
        await SystemDialogs.showTextPreviewPrompt(context, 'Rejection Reasons', reject.substring(0, reject.length-1));
    }

    Future<bool> _startDownload() async {
        LidarrAPI _api = LidarrAPI.from(Database.currentProfileObject);
        return await _api.downloadRelease(_arguments.data.guid, _arguments.data.indexerId);
    }
}
