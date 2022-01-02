import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sabnzbd.dart';

class SABnzbdHistoryHideButton extends StatefulWidget {
  final ScrollController controller;

  const SABnzbdHistoryHideButton({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<SABnzbdHistoryHideButton> createState() => _State();
}

class _State extends State<SABnzbdHistoryHideButton> {
  @override
  Widget build(BuildContext context) => LunaCard(
        context: context,
        child: Consumer<SABnzbdState>(
          builder: (context, model, widget) => LunaIconButton(
            icon: model.historyHideFailed
                ? Icons.visibility_off_rounded
                : Icons.visibility_rounded,
            onPressed: () => model.historyHideFailed = !model.historyHideFailed,
          ),
        ),
        height: LunaTextInputBar.defaultHeight,
        width: LunaTextInputBar.defaultHeight,
        margin: const EdgeInsets.only(left: 12.0),
        color: Theme.of(context).canvasColor,
      );
}
