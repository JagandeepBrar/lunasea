import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';
import '../../sabnzbd.dart';

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
                LSDivider(),
                LSButton(
                    text: 'Delete History',
                    backgroundColor: LSColors.red,
                    onTap: () => _delete(),
                )
            ],
            padBottom: true,
        );

    Future<void> _delete() async {
        List<dynamic> values = await SABnzbdDialogs.showDeleteHistoryPrompt(context);
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
