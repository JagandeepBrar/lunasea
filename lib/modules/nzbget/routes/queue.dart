import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/nzbget.dart';

class NZBGetQueue extends StatefulWidget {
  static const ROUTE_NAME = '/nzbget/queue';
  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey;

  const NZBGetQueue({
    Key? key,
    required this.refreshIndicatorKey,
  }) : super(key: key);

  @override
  State<NZBGetQueue> createState() => _State();
}

class _State extends State<NZBGetQueue>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  Timer? _timer;
  Future? _future;
  List<NZBGetQueueData>? _queue = [];

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
    return LunaScaffold(
      scaffoldKey: _scaffoldKey,
      body: _body,
      floatingActionButton: context.watch<NZBGetState>().error
          ? null
          : NZBGetQueueFAB(
              scrollController: NZBGetNavigationBar.scrollControllers[0]),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _createTimer() =>
      _timer = Timer(const Duration(seconds: 2), _fetchWithoutMessage);

  Future<void> _refresh() async => setState(() {
        _future = _fetch();
      });

  Future<void> _fetchWithoutMessage() async {
    _fetch().then((_) {
      if (mounted) setState(() {});
    }).catchError((error) {
      _queue = null;
    });
  }

  Future _fetch() async {
    NZBGetAPI _api = NZBGetAPI.from(LunaProfile.current);
    return _fetchStatus(_api).then((_) => _fetchQueue(_api)).then((_) {
      try {
        if (_timer == null || !_timer!.isActive) _createTimer();
        _setError(false);
        return true;
      } catch (error) {
        return Future.error(error);
      }
    }).catchError((error) {
      _queue = null;
      _setError(true);
      throw error;
    });
  }

  Future<void> _fetchQueue(NZBGetAPI api) async {
    final _model = Provider.of<NZBGetState>(context, listen: false);
    return await api.getQueue(_model.speed, 100).then((data) => _queue = data);
  }

  Future<void> _fetchStatus(NZBGetAPI api) async {
    return await api.getStatus().then((data) {
      if (mounted) {
        final _model = Provider.of<NZBGetState>(context, listen: false);
        _model.paused = data.paused;
        _model.speed = data.speed;
        _model.currentSpeed = data.currentSpeed;
        _model.queueSizeLeft = data.remainingString;
        _model.queueTimeLeft = data.timeLeft;
        _model.speedLimit = data.speedlimitString;
      }
    });
  }

  void _setError(bool error) {
    final _model = Provider.of<NZBGetState>(context, listen: false);
    _model.error = error;
  }

  Widget get _body => LunaRefreshIndicator(
        context: context,
        key: widget.refreshIndicatorKey,
        onRefresh: _fetchWithoutMessage,
        child: FutureBuilder(
          future: _future,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                context.read<NZBGetState>().error)
              return LunaMessage.error(onTap: _refresh);
            if (snapshot.hasData) return _list;
            return const LunaLoader();
          },
        ),
      );

  Widget get _list {
    if (_queue == null) {
      return LunaMessage.error(onTap: _refresh);
    }
    if (_queue!.isEmpty) {
      return LunaMessage(
        text: 'Empty Queue',
        buttonText: 'Refresh',
        onTap: _fetchWithoutMessage,
      );
    }
    return _reorderableList();
  }

  Widget _reorderableList() {
    return LunaReorderableListViewBuilder(
      controller: NZBGetNavigationBar.scrollControllers[0],
      onReorder: (oIndex, nIndex) async {
        if (oIndex > _queue!.length) oIndex = _queue!.length;
        if (oIndex < nIndex) nIndex--;
        NZBGetQueueData data = _queue![oIndex];
        if (mounted)
          setState(() {
            _queue!.remove(data);
            _queue!.insert(nIndex, data);
          });
        await NZBGetAPI.from(LunaProfile.current)
            .moveQueue(data.id, (nIndex - oIndex))
            .then((_) => showLunaSuccessSnackBar(
                title: 'Moved Job in Queue', message: data.name))
            .catchError((error) => showLunaErrorSnackBar(
                title: 'Failed to Move Job', error: error));
      },
      itemCount: _queue!.length,
      itemBuilder: (context, index) => NZBGetQueueTile(
        key: Key(_queue![index].id.toString()),
        index: index,
        data: _queue![index],
        queueContext: context,
        refresh: _fetchWithoutMessage,
      ),
    );
  }
}
