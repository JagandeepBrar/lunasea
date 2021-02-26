import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sabnzbd.dart';

class SABnzbdHistoryStagesArguments {
    SABnzbdHistoryData data;

    SABnzbdHistoryStagesArguments({
        @required this.data,
    });
}

class SABnzbdHistoryStages extends StatefulWidget {
    static const ROUTE_NAME = '/sabnzbd/history/stages';
    
    @override
    State<SABnzbdHistoryStages> createState() => _State();
}

class _State extends State<SABnzbdHistoryStages> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    SABnzbdHistoryStagesArguments _arguments;

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

    Widget get _appBar => LunaAppBar(title: 'Stages');

    Widget get _body => _arguments == null
        ? null
        : LSListView(
            children: List.generate(
                _arguments.data.stageLog.length,
                (index) => LSCardTile(
                    title: LSTitle(text: _arguments.data.stageLog[index]['name']),
                    subtitle: LSSubtitle(text: _arguments.data.stageLog[index]['actions'][0].replaceAll('<br/>', '.\n')),
                    trailing: LSIconButton(icon: Icons.arrow_forward_ios_rounded),
                    onTap: () async {
                        String _data = _arguments.data.stageLog[index]['actions'].join(',\n').replaceAll('<br/>', '.\n');
                        LunaDialogs().textPreview(context, _arguments.data.stageLog[index]['name'], _data);
                    }
                ),
            ),
        );
}
