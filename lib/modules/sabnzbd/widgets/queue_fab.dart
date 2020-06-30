import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:tuple/tuple.dart';
import 'package:lunasea/modules/sabnzbd.dart';

class SABnzbdQueueFAB extends StatefulWidget {
    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<SABnzbdQueueFAB> with SingleTickerProviderStateMixin {
    AnimationController _controller;

    @override
    void initState() {
        super.initState();
        _controller = AnimationController(
            vsync: this,
            duration: Duration(milliseconds: Constants.UI_NAVIGATION_SPEED),
        );
    }

    @override
    void dispose() {
        _controller.dispose();
        super.dispose();
    }

    @override
    Widget build(BuildContext context) => Selector<SABnzbdModel, Tuple2<bool, bool>>(
        selector: (_, model) => Tuple2(model.error, model.paused),
        builder: (context, data, _) {
            data.item2
                ? _controller.forward()
                : _controller.reverse();
            return data.item1
                ? Container()
                : InkWell(
                    child: LSFloatingActionButtonAnimated(
                        onPressed: () => _toggle(context, data.item2),
                        icon: AnimatedIcons.pause_play,
                        controller: _controller,
                    ),
                    onLongPress: () => _toggleFor(context),
                    borderRadius: BorderRadius.circular(28.0),
                );
        }
    );

    Future<void> _toggle(BuildContext context, bool paused) async {
        SABnzbdAPI _api = SABnzbdAPI.from(Database.currentProfileObject);
        paused
            ? _resume(context, _api)
            : _pause(context, _api);
    }

    Future<void> _toggleFor(BuildContext context) async {
        List values = await SABnzbdDialogs.pauseFor(context);
        if(values[0]) {
            if(values[1] == -1) {
                List values = await SABnzbdDialogs.customPauseFor(context);
                if(values[0]) await SABnzbdAPI.from(Database.currentProfileObject).pauseQueueFor(values[1])
                .then((_) => LSSnackBar(
                    context: context,
                    title: 'Pausing Queue',
                    message: 'For ${(values[1] as int).lsTime_durationString(multiplier: 60)}',
                    type: SNACKBAR_TYPE.success,
                ))
                .catchError((_) => LSSnackBar(
                    context: context,
                    title: 'Failed to Pause Queue',
                    message: Constants.CHECK_LOGS_MESSAGE,
                    type: SNACKBAR_TYPE.failure,
                ));
            } else {
                await SABnzbdAPI.from(Database.currentProfileObject).pauseQueueFor(values[1])
                .then((_) => LSSnackBar(
                    context: context,
                    title: 'Pausing Queue',
                    message: 'For ${(values[1] as int).lsTime_durationString(multiplier: 60)}',
                    type: SNACKBAR_TYPE.success,
                ))
                .catchError((_) => LSSnackBar(
                    context: context,
                    title: 'Failed to Pause Queue',
                    message: Constants.CHECK_LOGS_MESSAGE,
                    type: SNACKBAR_TYPE.failure,
                ));
            }
        }
    }

    Future<void> _pause(BuildContext context, SABnzbdAPI api) async {
        _controller.forward();
        await api.pauseQueue()
        .then((_) {
            Provider.of<SABnzbdModel>(context, listen: false).paused = true;
        })
        .catchError((_) {
            LSSnackBar(
                context: context,
                title: 'Failed to Pause Queue',
                message: Constants.CHECK_LOGS_MESSAGE,
                type: SNACKBAR_TYPE.failure,
            );
            _controller.reverse();
        });
    }

    Future<void> _resume(BuildContext context, SABnzbdAPI api) async {
        _controller.reverse();
        return await api.resumeQueue()
        .then((_) {
            Provider.of<SABnzbdModel>(context, listen: false).paused = false;
        })
        .catchError((_) {
            LSSnackBar(
                context: context,
                title: 'Failed to Resume Queue',
                message: Constants.CHECK_LOGS_MESSAGE,
                type: SNACKBAR_TYPE.failure,
            );
            _controller.forward();
        });
    }
}
