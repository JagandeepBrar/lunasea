enum StateFutureContainerStatus {
    UNINITIALIZED,
    RUNNING,
    COMPLETED,
    ERROR,
}

class StateFutureContainer<T> {
    final Function() callback;
    StateFutureContainerStatus _status = StateFutureContainerStatus.UNINITIALIZED;
    Future<T> _future;
    T _data;

    StateFutureContainer(this.callback);

    void start() {
        status = StateFutureContainerStatus.RUNNING;
        _future.then((data) => _complete(data)).catchError((error) => _error(error));
    }

    void close() {
        _future = null;
        _data = null;
        status = StateFutureContainerStatus.UNINITIALIZED;
    }

    T _complete(T data) {
        _data = data;
        status = StateFutureContainerStatus.COMPLETED;
        return _data;
    }

    dynamic _error(dynamic error) {
        _data = null;
        status = StateFutureContainerStatus.ERROR;
        return Future.error(error);
    }
    
    StateFutureContainerStatus get status => _status;
    set status(StateFutureContainerStatus status) {
        assert(status != null);
        _status = status;
        callback();
    }

    Future<T> get future => _future;
    set future(Future<T> future) {
        assert(future != null);
        _status = StateFutureContainerStatus.UNINITIALIZED;
        _future = future;
        start();
    }

    T get data => _data;
}
