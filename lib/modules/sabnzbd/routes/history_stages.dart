import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sabnzbd.dart';
import 'package:lunasea/widgets/pages/invalid_route.dart';

class HistoryStagesRoute extends StatefulWidget {
  final SABnzbdHistoryData? history;

  const HistoryStagesRoute({
    Key? key,
    required this.history,
  }) : super(key: key);

  @override
  State<HistoryStagesRoute> createState() => _State();
}

class _State extends State<HistoryStagesRoute> with LunaScrollControllerMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    if (widget.history == null) {
      return InvalidRoutePage(
        title: 'Stages',
        message: 'History Record Not Found',
      );
    }

    return LunaScaffold(
      scaffoldKey: _scaffoldKey,
      appBar: _appBar(),
      body: _body(),
    );
  }

  PreferredSizeWidget _appBar() => LunaAppBar(
        title: 'Stages',
        scrollControllers: [scrollController],
      );

  Widget _body() {
    return LunaListView(
      controller: scrollController,
      children: List.generate(
        widget.history!.stageLog.length,
        (index) => LunaBlock(
          title: widget.history!.stageLog[index]['name'],
          body: [
            TextSpan(
              text: widget.history!.stageLog[index]['actions'][0]
                  .replaceAll('<br/>', '.\n'),
            ),
          ],
          trailing: const LunaIconButton.arrow(),
          onTap: () async {
            String _data = widget.history!.stageLog[index]['actions']
                .join(',\n')
                .replaceAll('<br/>', '.\n');
            LunaDialogs().textPreview(
                context, widget.history!.stageLog[index]['name'], _data);
          },
        ),
      ),
    );
  }
}
