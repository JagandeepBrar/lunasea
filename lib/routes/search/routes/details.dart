import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/widgets/pages/search/details.dart';
import 'package:lunasea/widgets/ui.dart';

class SearchDetails extends StatefulWidget {
    static const ROUTE_NAME = '/search/details';

    @override
    State<SearchDetails> createState() =>  _State();
}

class _State extends State<SearchDetails> {
    final _scaffoldKey = GlobalKey<ScaffoldState>();

    @override
    void initState() {
        super.initState();
    }

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        floatingActionButton: _floatingActionButton,
        body: _body,
    );

    Widget get _appBar {
        final details = Provider.of<SearchModel>(context, listen: false).resultDetails;
        return LSAppBar(
            title: details?.title ?? 'Result Details',
            actions: <Widget>[
                if(details?.linkComments != '') LSIconButton(
                    icon: Icons.link,
                    onPressed: () => details?.linkComments?.lsLinks_OpenLink(),
                ),
            ],
        );
    }

    Widget get _body => LSListView(
        children: <Widget>[
            Consumer<SearchModel>(
                builder: (context, _state, child) => LSSearchDetailsTitle(_state?.resultDetails?.title),
            ),
        ],
        padBottom: true,
    );

    Widget get _floatingActionButton => Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
            Padding(
                child: LSSearchDetailsDownloadFAB(scaffoldKey: _scaffoldKey),
                padding: EdgeInsets.symmetric(vertical: 16.0),
            ),
            LSSearchDetailsClientFAB(),
        ],
    );
}
