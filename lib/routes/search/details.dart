import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lunasea/widgets/ui.dart';

class SearchDetailsArguments {
}

class SearchDetails extends StatefulWidget {
    static const ROUTE_NAME = '/search/details';

    @override
    State<SearchDetails> createState() =>  _State();
}

class _State extends State<SearchDetails> {
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    SearchDetailsArguments _arguments;

    @override
    void initState() {
        super.initState();
        SchedulerBinding.instance.addPostFrameCallback((_) {
            setState(() => _arguments = ModalRoute.of(context).settings.arguments);
        });
    }

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        body: _arguments == null ? null : _body,
    );

    Widget get _appBar => LSAppBar(title: 'Result Details');

    Widget get _body => Text('test');
}
