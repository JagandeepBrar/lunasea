import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/widgets/ui.dart';

class RadarrEditMovieArguments {
    final RadarrCatalogueData entry;

    RadarrEditMovieArguments({
        @required this.entry,
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

    @override
    void initState() {
        super.initState();
        SchedulerBinding.instance.addPostFrameCallback((_) { 
            setState(() => _arguments = ModalRoute.of(context).settings.arguments);
            _refresh();
        });
    }

    Future<void> _refresh() async {}

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
    );

    Widget get _appBar => LSAppBar(title: _arguments?.entry?.title ?? 'Edit Movie');
}
