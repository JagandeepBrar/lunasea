import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/lidarr.dart';

class LidarrDetailsTrackTile extends StatefulWidget {
  final LidarrTrackData data;
  final bool monitored;

  const LidarrDetailsTrackTile({
    Key key,
    @required this.data,
    @required this.monitored,
  }) : super(key: key);

  @override
  State<LidarrDetailsTrackTile> createState() => _State();
}

class _State extends State<LidarrDetailsTrackTile> {
  @override
  Widget build(BuildContext context) => LunaListTile(
        context: context,
        title:
            LunaText.title(text: widget.data.title, darken: !widget.monitored),
        subtitle: RichText(
          text: TextSpan(
              style: TextStyle(
                color: widget.monitored ? Colors.white70 : Colors.white30,
                fontSize: LunaUI.FONT_SIZE_H3,
              ),
              children: <TextSpan>[
                TextSpan(
                  text:
                      '${widget?.data?.duration?.lunaTimestamp(divisor: 1000)}\n',
                ),
                widget?.data?.file(widget.monitored),
              ]),
        ),
        leading: IconButton(
          icon: Text(
            widget?.data?.trackNumber,
            style: TextStyle(
              color: widget.monitored ? Colors.white : Colors.white30,
              fontWeight: LunaUI.FONT_WEIGHT_BOLD,
              fontSize: LunaUI.FONT_SIZE_TITLE,
            ),
          ),
          onPressed: null,
        ),
        contentPadding: true,
      );
}
