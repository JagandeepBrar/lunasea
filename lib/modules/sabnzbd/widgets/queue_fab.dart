import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/extensions/int/duration.dart';
import 'package:lunasea/modules/sabnzbd.dart';

class SABnzbdQueueFAB extends StatefulWidget {
  final ScrollController scrollController;

  const SABnzbdQueueFAB({
    Key? key,
    required this.scrollController,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<SABnzbdQueueFAB> with TickerProviderStateMixin {
  AnimationController? _iconController;
  AnimationController? _hideController;
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
    widget.scrollController.removeListener(scrollControllerListener);
    super.dispose();
  }

  void _setupIconController() {
    _iconController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: LunaUI.ANIMATION_SPEED),
    );
  }

  void _setupHideController() {
    _hideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: LunaUI.ANIMATION_SPEED),
    );
    _hideController!.forward();
    widget.scrollController.addListener(scrollControllerListener);
  }

  void scrollControllerListener() {
    if (!widget.scrollController.hasClients) return;
    switch (widget.scrollController.position.userScrollDirection) {
      case ScrollDirection.forward:
        if (!_visible) {
          _hideController!.forward();
          _visible = true;
        }
        break;
      case ScrollDirection.reverse:
        if (_visible) {
          _hideController!.reverse();
          _visible = false;
        }
        break;
      case ScrollDirection.idle:
        break;
    }
  }

  @override
  Widget build(BuildContext context) =>
      Selector<SABnzbdState, Tuple2<bool, bool>>(
          selector: (_, model) => Tuple2(model.error, model.paused),
          builder: (context, data, _) {
            data.item2
                ? _iconController!.forward()
                : _iconController!.reverse();
            return data.item1
                ? Container()
                : ScaleTransition(
                    scale: _hideController!,
                    child: InkWell(
                      child: LunaFloatingActionButtonAnimated(
                        onPressed: () => _toggle(context, data.item2),
                        icon: AnimatedIcons.pause_play,
                        controller: _iconController,
                      ),
                      onLongPress: () => _toggleFor(context),
                      borderRadius: BorderRadius.circular(28.0),
                    ),
                  );
          });

  Future<void> _toggle(BuildContext context, bool paused) async {
    HapticFeedback.lightImpact();
    SABnzbdAPI _api = SABnzbdAPI.from(LunaProfile.current);
    paused ? _resume(context, _api) : _pause(context, _api);
  }

  Future<void> _toggleFor(BuildContext context) async {
    HapticFeedback.heavyImpact();
    List values = await SABnzbdDialogs.pauseFor(context);
    if (values[0]) {
      if (values[1] == -1) {
        List values = await SABnzbdDialogs.customPauseFor(context);
        if (values[0])
          await SABnzbdAPI.from(LunaProfile.current)
              .pauseQueueFor(values[1])
              .then((_) => showLunaSuccessSnackBar(
                    title: 'Pausing Queue',
                    message:
                        'For ${(values[1] as int?).asWordDuration(multiplier: 60)}',
                  ))
              .catchError((error) => showLunaErrorSnackBar(
                    title: 'Failed to Pause Queue',
                    error: error,
                  ));
      } else {
        await SABnzbdAPI.from(LunaProfile.current)
            .pauseQueueFor(values[1])
            .then((_) => showLunaSuccessSnackBar(
                  title: 'Pausing Queue',
                  message:
                      'For ${(values[1] as int).asWordDuration(multiplier: 60)}',
                ))
            .catchError((error) => showLunaErrorSnackBar(
                  title: 'Failed to Pause Queue',
                  error: error,
                ));
      }
    }
  }

  Future<void> _pause(BuildContext context, SABnzbdAPI api) async {
    _iconController!.forward();
    await api.pauseQueue().then((_) {
      Provider.of<SABnzbdState>(context, listen: false).paused = true;
    }).catchError((error) {
      showLunaErrorSnackBar(
        title: 'Failed to Pause Queue',
        error: error,
      );
      _iconController!.reverse();
    });
  }

  Future<void> _resume(BuildContext context, SABnzbdAPI api) async {
    _iconController!.reverse();
    return await api.resumeQueue().then((_) {
      Provider.of<SABnzbdState>(context, listen: false).paused = false;
    }).catchError((error) {
      showLunaErrorSnackBar(
        title: 'Failed to Resume Queue',
        error: error,
      );
      _iconController!.forward();
    });
  }
}
