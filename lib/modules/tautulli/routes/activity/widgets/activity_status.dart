import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliActivityStatus extends StatelessWidget {
  final TautulliActivity? activity;

  const TautulliActivityStatus({
    required this.activity,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LunaHeader(
      text: activity!.lunaSessionsHeader,
      subtitle: [
        activity!.lunaSessions,
        activity!.lunaBandwidth,
      ].join('\n'),
    );
  }
}
