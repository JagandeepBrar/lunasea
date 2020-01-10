import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lunasea/logic/clients/nzbget.dart';

class NZBGetQueue extends StatefulWidget {
    final GlobalKey<ScaffoldState> scaffoldKey;
    final GlobalKey<RefreshIndicatorState> refreshIndicatorKey;
    final Function refreshStatus;

    NZBGetQueue({
        Key key,
        @required this.scaffoldKey,
        @required this.refreshIndicatorKey,
        @required this.refreshStatus,
    }) : super(key: key);

    @override
    State<NZBGetQueue> createState() {
        return _State();
    }
}

class _State extends State<NZBGetQueue> with TickerProviderStateMixin {
    Timer timer;
    bool _connectionError = false;
    bool _paused = false;

    @override
    void initState() {
        super.initState();
        Future.delayed(Duration(milliseconds: 200)).then((_) {
            _createTimer();
        });
    }

    @override
    void dispose() {
        timer?.cancel();
        super.dispose();
    }

    void _createTimer() {
        timer = Timer.periodic(Duration(seconds: 1), (timer) {
            _refreshData();
        });
    }

    Future<void> _refreshData() async {
        NZBGetStatusEntry status = await NZBGetAPI.getStatus();
        if(status != null) {
            widget.refreshStatus(status);
            if(mounted) {
                setState(() {
                    _connectionError = false;
                    _paused = status.paused;
                });
            }
        } else {
            widget.refreshStatus(null);
            if(mounted) {
                setState(() {
                    _connectionError = true;
                    _paused = true;
                });
            }
        }
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            key: widget.scaffoldKey,
            floatingActionButton: _connectionError ?
                null :
                _buildFloatingActionButton(),
        );
    }

    FloatingActionButton _buildFloatingActionButton() {
        return FloatingActionButton(
            heroTag: null,
            tooltip: 'Start/Pause NZBGet',
            child: _paused ? Icon(
                Icons.play_arrow,
                color: Colors.white,
            ) : Icon(
                Icons.pause,
                color: Colors.white,
            ),
            onPressed: () async {
                if(_paused) {
                    if(await NZBGetAPI.resumeQueue() && mounted) {
                        setState(() {
                            _paused = false;
                        });
                    }
                } else {
                    if(await NZBGetAPI.pauseQueue() && mounted) {
                        setState(() {
                            _paused = true;
                        });
                    }
                }
            },
        );
    }
}
