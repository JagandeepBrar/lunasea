import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/extensions/datetime.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliLogsNewsletterLogTile extends StatelessWidget {
  final TautulliNewsletterLogRecord newsletter;

  const TautulliLogsNewsletterLogTile({
    Key? key,
    required this.newsletter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LunaBlock(
      title: newsletter.agentName,
      body: _body(),
      trailing: _trailing(),
    );
  }

  List<TextSpan> _body() {
    return [
      TextSpan(text: newsletter.notifyAction),
      TextSpan(text: newsletter.subjectText),
      TextSpan(text: newsletter.bodyText),
      TextSpan(
        text: newsletter.timestamp!.asDateTime(),
        style: const TextStyle(
          color: LunaColours.accent,
          fontWeight: LunaUI.FONT_WEIGHT_BOLD,
        ),
      ),
    ];
  }

  Widget _trailing() => Column(
        children: [
          LunaIconButton(
            icon: newsletter.success!
                ? Icons.check_circle_rounded
                : Icons.cancel_rounded,
            color: newsletter.success! ? LunaColours.white : LunaColours.red,
          ),
        ],
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
      );
}
