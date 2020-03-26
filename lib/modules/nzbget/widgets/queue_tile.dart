import 'dart:math';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:lunasea/core.dart';
import '../../nzbget.dart';

class NZBGetQueueTile extends StatefulWidget {
    final NZBGetQueueData data;
    final Function(String, String, SNACKBAR_TYPE) snackbar;

    NZBGetQueueTile({
        @required this.data,
        @required this.snackbar,
        Key key,
    }) : super(key: key);

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<NZBGetQueueTile> {
    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(
            text: widget.data.name,
            darken: widget.data.paused,
        ),
        subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
                Padding(
                    child: LinearPercentIndicator(
                        percent: min(1.0, max(0, widget.data.percentageDone/100)),
                        padding: EdgeInsets.symmetric(horizontal: 2.0),
                        progressColor: widget.data.paused ? LSColors.accent.withOpacity(0.30) : LSColors.accent,
                        backgroundColor: widget.data.paused ? LSColors.accent.withOpacity(0.05) : LSColors.accent.withOpacity(0.15),
                        lineHeight: 4.0,
                    ),
                    padding: EdgeInsets.symmetric(vertical: 6.0),
                ),
                LSSubtitle(
                    text: widget.data.subtitle,
                    darken: widget.data.paused,
                ),
            ],
        ),
        trailing: LSIconButton(
            icon: Icons.more_vert,
            onPressed: () async => _handlePopup(context),
            color: widget.data.paused ? Colors.white30 : Colors.white,
        ),
    );

    Future<void> _handlePopup(BuildContext context) async {
        List values = await NZBGetDialogs.showQueueSettingsPrompt(context, widget.data.name, widget.data.paused);
        if(values[0]) switch(values[1]) {
            case 'status': widget.data.paused ? _resumeJob(context) : _pauseJob(context); break;
            case 'category': break;
            case 'priority': break;
            case 'password': break;
            case 'rename': break;
            case 'delete': break;
            default: Logger.warning('NZBGetQueueTile', '_handlePopup', 'Unknown Case: ${values[1]}');
        }
    }

    Future<void> _pauseJob(BuildContext context) async {
        await NZBGetAPI.from(Database.currentProfileObject).pauseSingleJob(widget.data.id)
        .then((_) {
            widget.snackbar(
                'Job Paused',
                widget.data.name,
                SNACKBAR_TYPE.success,
            );
        })
        .catchError((_) => widget.snackbar(
            'Failed to Pause Job',
            Constants.CHECK_LOGS_MESSAGE,
            SNACKBAR_TYPE.failure,
        ));
    }

    Future<void> _resumeJob(BuildContext context) async {
        await NZBGetAPI.from(Database.currentProfileObject).resumeSingleJob(widget.data.id)
        .then((_) {
            widget.snackbar(
                'Job Resumed',
                widget.data.name,
                SNACKBAR_TYPE.success,
            );
        })
        .catchError((_) => widget.snackbar(
            'Failed to Resume Job',
            Constants.CHECK_LOGS_MESSAGE,
            SNACKBAR_TYPE.failure,
        ));
    }
}
