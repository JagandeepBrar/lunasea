import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sabnzbd.dart';

class SABnzbdHistoryDetailsArguments {
    SABnzbdHistoryData data;

    SABnzbdHistoryDetailsArguments({
        @required this.data,
    });
}

class SABnzbdHistoryDetails extends StatefulWidget {
    static const ROUTE_NAME = '/sabnzbd/history/details';
    
    @override
    State<SABnzbdHistoryDetails> createState() => _State();
}

class _State extends State<SABnzbdHistoryDetails> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    SABnzbdHistoryDetailsArguments _arguments;

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
        : LSAppBar(title: _arguments.data.name);

    Widget get _body => _arguments == null
        ? null
        : LSListView(
            children: <Widget>[
                ..._statusBlock,
                ..._stagesBlock,
                ..._deleteBlock,
            ],
        );

    List<Widget> get _statusBlock => [
        LSHeader(text: 'Status'),
        LSContainerRow(
            children: <Widget>[
                Expanded(
                    child: LSCardTile(
                        title: LSTitle(text: 'Status', centerText: true),
                        subtitle: LSSubtitle(text: _arguments.data.status, centerText: true),
                        reducedMargin: true,
                    ),
                ),
                Expanded(
                    child: LSCardTile(
                        title: LSTitle(text: 'Category', centerText: true),
                        subtitle: LSSubtitle(text: _arguments.data.category, centerText: true),
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
                        subtitle: LSSubtitle(text: _arguments.data.completeTimeString, centerText: true),
                        reducedMargin: true,
                    ),
                ),
                Expanded(
                    child: LSCardTile(
                        title: LSTitle(text: 'Size', centerText: true),
                        subtitle: LSSubtitle(text: _arguments.data.sizeReadable, centerText: true),
                        reducedMargin: true,
                    ),
                ),
            ],
        ),
        LSCardTile(
            title: LSTitle(text: 'Storage Location'),
            subtitle: LSSubtitle(text: _arguments.data.storageLocation),
            trailing: LSIconButton(icon: Icons.arrow_forward_ios),
            onTap: () async => GlobalDialogs.textPreview(context, 'Storage Location', _arguments.data.storageLocation),
        ),
    ];

    List<Widget> get _stagesBlock => [
        LSHeader(text: 'Stages'),
        for(var stage in _arguments.data.stageLog) LSCardTile(
            title: LSTitle(text: stage['name']),
            subtitle: LSSubtitle(text: stage['actions'][0].replaceAll('<br/>', '.\n')),
            trailing: LSIconButton(icon: Icons.arrow_forward_ios),
            onTap: () async {
                String _data = stage['actions'].join(',\n').replaceAll('<br/>', '.\n');
                GlobalDialogs.textPreview(context, stage['name'], _data);
            }
        ),
    ];

    List<Widget> get _deleteBlock => [
        LSDivider(),
        LSButton(
            text: 'Delete History',
            backgroundColor: LSColors.red,
            onTap: () => _delete(),
        ),
    ];

    Future<void> _delete() async {
        List<dynamic> values = await SABnzbdDialogs.deleteHistory(context);
        if(values[0]) await SABnzbdAPI.from(Database.currentProfileObject).deleteHistory(_arguments.data.nzoId)
        .then((_) {
            Navigator.of(context).pop(['delete']);
        })
        .catchError((_) => LSSnackBar(
            context: context,
            title: 'Failed to Delete History',
            message: Constants.CHECK_LOGS_MESSAGE,
            type: SNACKBAR_TYPE.failure,
        ));
    }
}
