enum FutureContainerStatus {
    UNINITIALIZED,
    RUNNING,
    COMPLETED,
    ERROR,
}

class FutureContainer<T> {
    final Function() callback;
    FutureContainerStatus _status = FutureContainerStatus.UNINITIALIZED;
    Future<T> _future;
    T _data;

    FutureContainer(this.callback);

    void start() {
        status = FutureContainerStatus.RUNNING;
        _future.then((data) => _complete(data)).catchError((error) => _error(error));
    }

    void close() {
        _future = null;
        _data = null;
        status = FutureContainerStatus.UNINITIALIZED;
    }

    T _complete(T data) {
        _data = data;
        status = FutureContainerStatus.COMPLETED;
        return _data;
    }

    dynamic _error(dynamic error) {
        _data = null;
        status = FutureContainerStatus.ERROR;
        return Future.error(error);
    }
    
    FutureContainerStatus get status => _status;
    set status(FutureContainerStatus status) {
        assert(status != null);
        _status = status;
        callback();
    }

    Future<T> get future => _future;
    set future(Future<T> future) {
        assert(future != null);
        _status = FutureContainerStatus.UNINITIALIZED;
        _future = future;
        start();
    }

    T get data => _data;
}
