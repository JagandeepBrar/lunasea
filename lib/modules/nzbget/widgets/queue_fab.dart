import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lunasea/core.dart';
import 'package:tuple/tuple.dart';
import 'package:lunasea/modules/nzbget.dart';

class NZBGetQueueFAB extends StatefulWidget {
    final ScrollController scrollController;

    NZBGetQueueFAB({
        Key key,
        @required this.scrollController,
    }) : super(key: key);

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<NZBGetQueueFAB> with TickerProviderStateMixin {
    AnimationController _iconController;
    AnimationController _hideController;
    bool _visible = true;

    @override
    void initState() {
        super.initState();
        _setupIconController();
        _setupHideController();
    }

    @override
    void dispose() {
        _iconController?.dispose();
        _hideController?.dispose();
        super.dispose();
    }

    void _setupIconController() {
        _iconController = AnimationController(
            vsync: this,
            duration: Duration(milliseconds: Constants.UI_NAVIGATION_SPEED),
        );
    }

    void _setupHideController() {
        _hideController = AnimationController(
            vsync: this,
            duration: Duration(milliseconds: Constants.UI_NAVIGATION_SPEED),
        );
        _hideController.forward();
        widget.scrollController.addListener(() {
            switch(widget.scrollController.position.userScrollDirection) {
                case ScrollDirection.forward: if(!_visible) {
                    _hideController.forward();
                    _visible = true;
                 } break;
                case ScrollDirection.reverse: if(_visible) {
                    _hideController.reverse();
                    _visible = false;
                 } break;
                case ScrollDirection.idle: break;
            }
        });
    }

    @override
    Widget build(BuildContext context) => Selector<NZBGetState, Tuple2<bool, bool>>(
        selector: (_, model) => Tuple2(model.error, model.paused),
        builder: (context, data, _) {
            data.item2
                ? _iconController.forward()
                : _iconController.reverse();
            return data.item1
                ? Container()
                : ScaleTransition(
                    scale: _hideController,
                    child: InkWell(
                        child: LSFloatingActionButtonAnimated(
                            controller: _iconController,
                            icon: AnimatedIcons.pause_play,
                            onPressed: () => _toggle(context, data.item2),
                        ),
                        onLongPress: () => _toggleFor(context),
                        borderRadius: BorderRadius.circular(28.0),
                    ),
                );
        }
    );

    Future<void> _toggle(BuildContext context, bool paused) async {
        NZBGetAPI _api = NZBGetAPI.from(Database.currentProfileObject);
        paused
            ? _resume(context, _api)
            : _pause(context, _api);
    }

    Future<void> _toggleFor(BuildContext context) async {
        List values = await NZBGetDialogs.pauseFor(context);
        if(values[0]) {
            if(values[1] == -1) {
                List values = await NZBGetDialogs.customPauseFor(context);
                if(values[0]) await NZBGetAPI.from(Database.currentProfileObject).pauseQueueFor(values[1])
                .then((_) => LSSnackBar(
                    context: context,
                    title: 'Pausing Queue',
                    message: 'For ${(values[1] as int).lunaDuration(multiplier: 60)}',
                    type: SNACKBAR_TYPE.success,
                ))
                .catchError((_) => LSSnackBar(
                    context: context,
                    title: 'Failed to Pause Queue',
                    message: Constants.CHECK_LOGS_MESSAGE,
                    type: SNACKBAR_TYPE.failure,
                ));
            } else {
                await NZBGetAPI.from(Database.currentProfileObject).pauseQueueFor(values[1])
                .then((_) => LSSnackBar(
                    context: context,
                    title: 'Pausing Queue',
                    message: 'For ${(values[1] as int).lunaDuration(multiplier: 60)}',
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

    Future<void> _pause(BuildContext context, NZBGetAPI api) async {
        _iconController.forward();
        await api.pauseQueue()
        .then((_) {
            Provider.of<NZBGetState>(context, listen: false).paused = true;
        })
        .catchError((_) {
            _iconController.reverse();
            LSSnackBar(
                context: context,
                title: 'Failed to Pause Queue',
                message: Constants.CHECK_LOGS_MESSAGE,
                type: SNACKBAR_TYPE.failure,
            );
        });
    }

    Future<void> _resume(BuildContext context, NZBGetAPI api) async {
        _iconController.reverse();
        return await api.resumeQueue()
        .then((_) {
            Provider.of<NZBGetState>(context, listen: false).paused = false;
        })
        .catchError((_) {
            _iconController.forward();
            LSSnackBar(
                context: context,
                title: 'Failed to Resume Queue',
                message: Constants.CHECK_LOGS_MESSAGE,
                type: SNACKBAR_TYPE.failure,
            );
        });
    }
}
