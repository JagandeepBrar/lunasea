import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/nzbget.dart';

class NZBGetLogTile extends StatelessWidget {
  final NZBGetLogData data;

  const NZBGetLogTile({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LunaBlock(
      title: data.text,
      body: [TextSpan(text: data.timestamp)],
      trailing: const LunaIconButton.arrow(),
      onTap: () async =>
          LunaDialogs().textPreview(context, 'Log Entry', data.text!),
    );
  }
}
