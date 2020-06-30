import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/nzbget.dart';

class NZBGetQueue extends StatefulWidget {
    static const ROUTE_NAME = '/nzbget/queue';
    final GlobalKey<RefreshIndicatorState> refreshIndicatorKey;

    NZBGetQueue({
        Key key,
        @required this.refreshIndicatorKey,
    }) : super(key: key);
    
    @override
    State<NZBGetQueue> createState() => _State();
}

class _State extends State<NZBGetQueue> with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    Timer _timer;
    Future _future;
    List<NZBGetQueueData> _queue = [];

    @override
    bool get wantKeepAlive => true;

    @override
    void initState() {
        super.initState();
        _refresh();
    }

    @override
    Widget build(BuildContext context) {
        super.build(context);
        return Scaffold(
            key: _scaffoldKey,
            body: _body,
            floatingActionButton: NZBGetQueueFAB(),
        );
    }

    @override
    void dispose() {
        _timer?.cancel();
        super.dispose();
    }

    void _createTimer() => _timer = Timer(Duration(seconds: 2), () => _fetchWithoutMessage());

    Future<void> _refresh() async => setState(() {
        _future = _fetch();
    });

    Future<void> _fetchWithoutMessage() async {
        _fetch().then((_) => { if(mounted) setState(() {}) })
        .catchError((_) => _queue = null);
    }

    Future _fetch() async {
        NZBGetAPI _api = NZBGetAPI.from(Database.currentProfileObject);
        return _fetchStatus(_api)
        .then((_) => _fetchQueue(_api))
        .then((_) {
            try {
                if(_timer == null || !_timer.isActive) _createTimer();
                _setError(false);
                return true;
            } catch (error) {
                return Future.error(error);
            }
        })
        .catchError((error) {
            _queue = null;
            _setError(true);
            return Future.error(error);
        });
    }

    Future<void> _fetchQueue(NZBGetAPI api) async {
        final _model = Provider.of<NZBGetModel>(context, listen: false);
        return await api.getQueue(_model.speed, 100)
        .then((data) => _queue = data)
        .catchError((error) => Future.error(error));
    }

    Future<void> _fetchStatus(NZBGetAPI api) async {
        return await api.getStatus()
        .then((data) {
            if(mounted) {
                final _model = Provider.of<NZBGetModel>(context, listen: false);
                _model.paused = data.paused;
                _model.speed = data.speed;
                _model.currentSpeed = data.currentSpeed;
                _model.queueSizeLeft = data.remainingString;
                _model.queueTimeLeft = data.timeLeft;
                _model.speedLimit = data.speedlimitString;
            }
        })
        .catchError((error) => Future.error(error));
    }

    void _setError(bool error) {
        final _model = Provider.of<NZBGetModel>(context, listen: false);
        _model.error = error;
    }

    Widget get _body => LSRefreshIndicator(
        refreshKey: widget.refreshIndicatorKey,
        onRefresh: () => _fetchWithoutMessage(),
        child: FutureBuilder(
            future: _future,
            builder: (context, snapshot) {
                if(
                    snapshot.connectionState == ConnectionState.done
                    && (snapshot.hasError || snapshot.data == null)
                ) return LSErrorMessage(onTapHandler: () => _refresh());
                return _list;
            },
        ),
    );

    Widget get _list => _queue == null
        ? LSErrorMessage(onTapHandler: () => _refresh())
        : _queue.length == 0
            ? LSGenericMessage(
                text: 'Empty Queue',
                showButton: true,
                buttonText: 'Refresh',
                onTapHandler: () => _fetchWithoutMessage(),
            )
            : _reorderableList;

    Widget get _reorderableList => Scrollbar(
        child: LSReorderableListView(
            onReorder: (oIndex, nIndex) async {
                if (oIndex > _queue.length) oIndex = _queue.length;
                if (oIndex < nIndex) nIndex--;
                NZBGetQueueData data = _queue[oIndex];
                if(mounted) setState(() {
                    _queue.remove(data);
                    _queue.insert(nIndex, data);
                });
                await NZBGetAPI.from(Database.currentProfileObject).moveQueue(data.id, (nIndex - oIndex))
                .then((_) => LSSnackBar(
                    context: context,
                    title: 'Moved Job in Queue',
                    message: data.name,
                    type: SNACKBAR_TYPE.success,
                ))
                .catchError((_) => LSSnackBar(
                    context: context,
                    title: 'Failed to Move Job',
                    message: Constants.CHECK_LOGS_MESSAGE,
                    type: SNACKBAR_TYPE.failure,
                ));
            },
            children: List.generate(
                _queue.length,
                (index) => NZBGetQueueTile(
                    key: Key(_queue[index].id.toString()),
                    data: _queue[index],
                    snackbar: _snackBar,
                    queueContext: context,
                    refresh: () => _fetchWithoutMessage(),
                ),
            ),
            padding: EdgeInsets.only(top: 8.0),
        ),
    );

    void _snackBar(String title, String message, SNACKBAR_TYPE type) => LSSnackBar(
        context: context,
        title: title,
        message: message,
        type: type,
    );
}
