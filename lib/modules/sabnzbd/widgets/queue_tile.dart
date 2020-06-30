import 'dart:math';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sabnzbd.dart';

class SABnzbdQueueTile extends StatefulWidget {
    final SABnzbdQueueData data;
    final Function(String, String, SNACKBAR_TYPE) snackbar;
    final Function refresh;
    final BuildContext queueContext;

    SABnzbdQueueTile({
        @required this.data,
        @required this.snackbar,
        @required this.queueContext,
        @required this.refresh,
        Key key,
    }) : super(key: key);

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<SABnzbdQueueTile> {
    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(
            text: widget.data.name,
            darken: widget.data.isPaused,
        ),
        subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
                Padding(
                    child: LinearPercentIndicator(
                        percent: min(1.0, max(0, widget.data.percentageDone/100)),
                        padding: EdgeInsets.symmetric(horizontal: 2.0),
                        progressColor: widget.data.isPaused ? LSColors.accent.withOpacity(0.30) : LSColors.accent,
                        backgroundColor: widget.data.isPaused ? LSColors.accent.withOpacity(0.05) : LSColors.accent.withOpacity(0.15),
                        lineHeight: 4.0,
                    ),
                    padding: EdgeInsets.symmetric(vertical: 6.0),
                ),
                LSSubtitle(
                    text: widget.data.subtitle,
                    darken: widget.data.isPaused,
                ),
            ],
        ),
        trailing: LSIconButton(
            icon: Icons.more_vert,
            onPressed: () async => _handlePopup(),
            color: widget.data.isPaused ? Colors.white30 : Colors.white,
        ),
    );

    Future<void> _handlePopup() async {
        _Helper _helper = _Helper(widget.queueContext, widget.data, widget.snackbar, widget.refresh);
        List values = await SABnzbdDialogs.queueSettings(widget.queueContext, widget.data.name, widget.data.isPaused);
        if(values[0]) switch(values[1]) {
            case 'status': widget.data.isPaused
                ? _helper._resumeJob()
                : _helper._pauseJob();
            break;
            case 'category':  _helper._category(); break;
            case 'priority':  _helper._priority(); break;
            case 'password':  _helper._password(); break;
            case 'rename':  _helper._rename(); break;
            case 'delete':  _helper._delete(); break;
            default: Logger.warning('SABnzbdQueueTile', '_handlePopup', 'Unknown Case: ${values[1]}');
        }
    }
}

class _Helper {
    final BuildContext context;
    final SABnzbdQueueData data;
    final Function snackbar;
    final Function refresh;

    _Helper(
        this.context,
        this.data,
        this.snackbar,
        this.refresh,
    );

    Future<void> _pauseJob() async {
        await SABnzbdAPI.from(Database.currentProfileObject).pauseSingleJob(data.nzoId)
        .then((_) {
            snackbar(
                'Job Paused',
                data.name,
                SNACKBAR_TYPE.success,
            );
            refresh();
        })
        .catchError((_) => snackbar(
            'Failed to Pause Job',
            Constants.CHECK_LOGS_MESSAGE,
            SNACKBAR_TYPE.failure,
        ));
    }

    Future<void> _resumeJob() async {
        await SABnzbdAPI.from(Database.currentProfileObject).resumeSingleJob(data.nzoId)
        .then((_) {
            snackbar(
                'Job Resumed',
                data.name,
                SNACKBAR_TYPE.success,
            );
            refresh();
        })
        .catchError((_) => snackbar(
            'Failed to Resume Job',
            Constants.CHECK_LOGS_MESSAGE,
            SNACKBAR_TYPE.failure,
        ));
    }

    Future<void> _category() async {
        List<SABnzbdCategoryData> categories = await SABnzbdAPI.from(Database.currentProfileObject).getCategories();
        List values = await SABnzbdDialogs.changeCategory(context, categories);
        if(values[0]) await SABnzbdAPI.from(Database.currentProfileObject).setCategory(data.nzoId, values[1])
        .then((_) {
            snackbar(
                values[1] == '' ? 'Category Set (No Category)' : 'Category Set (${values[1]})',
                data.name,
                SNACKBAR_TYPE.success,
            );
            refresh();
        })
        .catchError((_) => snackbar(
            'Failed to Set Category',
            Constants.CHECK_LOGS_MESSAGE,
            SNACKBAR_TYPE.failure,
        ));
    }

    Future<void> _priority() async {
        List values = await SABnzbdDialogs.changePriority(context);
        if(values[0]) await SABnzbdAPI.from(Database.currentProfileObject).setJobPriority(data.nzoId, values[1])
        .then((_) {
            snackbar(
                'Priority Set (${(values[2])})',
                data.name,
                SNACKBAR_TYPE.success,
            );
            refresh();
        })
        .catchError((error) => snackbar(
            'Failed to Set Priority',
            Constants.CHECK_LOGS_MESSAGE,
            SNACKBAR_TYPE.failure,
        ));
    }

    Future<void> _rename() async {
        List values = await SABnzbdDialogs.renameJob(context, data.name);
        if(values[0]) SABnzbdAPI.from(Database.currentProfileObject).renameJob(data.nzoId, values[1])
        .then((_) {
            snackbar(
                'Job Renamed',
                values[1],
                SNACKBAR_TYPE.success,
            );
            refresh();
        })
        .catchError((_) => snackbar(
            'Failed to Rename Job',
            Constants.CHECK_LOGS_MESSAGE,
            SNACKBAR_TYPE.failure,
        ));
    }

    Future<void> _delete() async {
        List values = await SABnzbdDialogs.deleteJob(context);
        if(values[0]) await SABnzbdAPI.from(Database.currentProfileObject).deleteJob(data.nzoId)
        .then((_) {
            snackbar(
                'Job Deleted',
                data.name,
                SNACKBAR_TYPE.success,
            );
            refresh();
        })
        .catchError((_) => snackbar(
            'Failed to Delete Job',
            Constants.CHECK_LOGS_MESSAGE,
            SNACKBAR_TYPE.failure,
        ));
    }

    Future<void> _password() async {
        List values = await SABnzbdDialogs.setPassword(context);
        if(values[0]) await SABnzbdAPI.from(Database.currentProfileObject).setJobPassword(data.nzoId, data.name, values[1])
        .then((_) {
            snackbar(
                'Job Password Set',
                data.name,
                SNACKBAR_TYPE.success,
            );
            refresh();
        })
        .catchError((_) => snackbar(
            'Failed to Set Job Password',
            Constants.CHECK_LOGS_MESSAGE,
            SNACKBAR_TYPE.failure,
        ));
    }
}