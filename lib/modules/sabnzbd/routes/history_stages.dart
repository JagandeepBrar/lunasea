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

  const SABnzbdHistoryStages({
    Key key,
  }) : super(key: key);

  @override
  State<SABnzbdHistoryStages> createState() => _State();
}

class _State extends State<SABnzbdHistoryStages>
    with LunaScrollControllerMixin {
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
  Widget build(BuildContext context) => LunaScaffold(
        scaffoldKey: _scaffoldKey,
        appBar: _appBar,
        body: _body,
      );

  Widget get _appBar => LunaAppBar(
        title: 'Stages',
        scrollControllers: [scrollController],
      );

  Widget get _body => _arguments == null
      ? null
      : LunaListView(
          controller: scrollController,
          children: List.generate(
            _arguments.data.stageLog.length,
            (index) => LunaBlock(
              title: _arguments.data.stageLog[index]['name'],
              body: [
                TextSpan(
                  text: _arguments.data.stageLog[index]['actions'][0]
                      .replaceAll('<br/>', '.\n'),
                ),
              ],
              trailing: const LunaIconButton.arrow(),
              onTap: () async {
                String _data = _arguments.data.stageLog[index]['actions']
                    .join(',\n')
                    .replaceAll('<br/>', '.\n');
                LunaDialogs().textPreview(
                    context, _arguments.data.stageLog[index]['name'], _data);
              },
            ),
          ),
        );
}
