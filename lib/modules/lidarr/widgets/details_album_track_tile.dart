import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/extensions/int/duration.dart';
import 'package:lunasea/modules/lidarr.dart';

class LidarrDetailsTrackTile extends StatefulWidget {
  final LidarrTrackData data;
  final bool monitored;

  const LidarrDetailsTrackTile({
    Key? key,
    required this.data,
    required this.monitored,
  }) : super(key: key);

  @override
  State<LidarrDetailsTrackTile> createState() => _State();
}

class _State extends State<LidarrDetailsTrackTile> {
  @override
  Widget build(BuildContext context) => LunaBlock(
        title: widget.data.title,
        body: [
          TextSpan(text: widget.data.duration.asTrackDuration(divisor: 1000)),
          widget.data.file(widget.monitored),
        ],
        disabled: !widget.monitored,
        leading: LunaIconButton(
          text: widget.data.trackNumber,
          textSize: LunaUI.FONT_SIZE_H4,
        ),
      );
}
