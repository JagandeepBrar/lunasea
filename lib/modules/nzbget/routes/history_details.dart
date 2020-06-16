import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/nzbget.dart';

class NZBGetHistoryDetailsArguments {
    NZBGetHistoryData data;

    NZBGetHistoryDetailsArguments({
        @required this.data,
    });
}

class NZBGetHistoryDetails extends StatefulWidget {
    static const ROUTE_NAME = '/nzbget/history/details';
    
    @override
    State<NZBGetHistoryDetails> createState() => _State();
}

class _State extends State<NZBGetHistoryDetails> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    NZBGetHistoryDetailsArguments _arguments;

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
            title: _arguments.data.name,
        );

    Widget get _body => _arguments == null
        ? null
        : LSListView(
            children: <Widget>[
                LSContainerRow(
                    children: <Widget>[
                        Expanded(
                            child: LSCardTile(
                                title: LSTitle(text: 'Status', centerText: true),
                                subtitle: LSSubtitle(text: _arguments.data.statusString, centerText: true),
                                reducedMargin: true,
                            ),
                        ),
                        Expanded(
                            child: LSCardTile(
                                title: LSTitle(text: 'Age', centerText: true),
                                subtitle: LSSubtitle(text: _arguments.data.completeTime, centerText: true),
                                reducedMargin: true,
                            ),
                        ),
                    ],
                ),
                LSContainerRow(
                    children: <Widget>[
                        Expanded(
                            child: LSCardTile(
                                title: LSTitle(text: 'Category', centerText: true),
                                subtitle: LSSubtitle(
                                    text: _arguments.data.category == ''
                                        ? 'No Category'
                                        : _arguments.data.category,
                                    centerText: true,
                                ),
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
                LSContainerRow(
                    children: <Widget>[
                        Expanded(
                            child: LSCardTile(
                                title: LSTitle(text: 'Health', centerText: true),
                                subtitle: LSSubtitle(
                                    text: _arguments.data.healthString,
                                    centerText: true,
                                ),
                                reducedMargin: true,
                            ),
                        ),
                        Expanded(
                            child: LSCardTile(
                                title: LSTitle(text: 'Average Speed', centerText: true),
                                subtitle: LSSubtitle(text: _arguments.data.downloadSpeed, centerText: true),
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
                LSDivider(),
                LSButton(
                    text: 'Delete History',
                    backgroundColor: LSColors.red,
                    onTap: () => _delete(),
                )
            ],
        );

    Future<void> _delete() async {
        List<dynamic> values = await NZBGetDialogs.deleteHistory(context);
        if(values[0]) await NZBGetAPI.from(Database.currentProfileObject).deleteHistoryEntry(
            _arguments.data.id,
            hide: values[1],
        )
        .then((_) {
            Navigator.of(context).pop([values[1] ? 'hide' : 'delete']);
        })
        .catchError((_) => LSSnackBar(
            context: context,
            title: 'Failed to Delete History',
            message: Constants.CHECK_LOGS_MESSAGE,
            type: SNACKBAR_TYPE.failure,
        ));
    }
}
