import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/widgets/ui.dart';
import '../../lidarr.dart';

class LidarrDetailsTrackTile extends StatefulWidget {
    final LidarrTrackData data;
    final bool monitored;

    LidarrDetailsTrackTile({
        Key key,
        @required this.data,
        @required this.monitored,
    }) : super(key: key);

    @override
    State<LidarrDetailsTrackTile> createState() => _State();
}

class _State extends State<LidarrDetailsTrackTile> {
    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(text: widget.data.title, darken: !widget.monitored),
        subtitle: RichText(
            text: TextSpan(
                style: TextStyle(
                    color: widget.monitored ? Colors.white70 : Colors.white30,
                    letterSpacing: Constants.UI_LETTER_SPACING,
                ),
                children: <TextSpan>[
                    TextSpan(
                        text: '${widget?.data?.duration?.lsTime_timestampString(divisor: 1000)}\n',
                    ),
                    widget?.data?.file(widget.monitored),
                ]
            ),
        ),
        leading: IconButton(
            icon: Text(
                '${widget?.data?.trackNumber}',
                style: TextStyle(
                    color: widget.monitored ? Colors.white : Colors.white30,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                ),
            ),
            onPressed: null,
        ),
        padContent: true,
    );
}