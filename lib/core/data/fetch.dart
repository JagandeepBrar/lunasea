enum LSFetchStatus {
    UNINITIALIZED,
    RUNNING,
    COMPLETED,
    ERROR,
}

class LSFetch<T> {
    Future<T> _future;
    LSFetchStatus _status;

    LSFetch(Future<T> future) {
        _status = LSFetchStatus.UNINITIALIZED;
        _run(future);
    }

    Future<void> _run(Future future) async {
        _future = future;
        _future
            ?.then((data) => _complete(data))
            ?.catchError((error) => _error(error));
    }

    dynamic _complete(dynamic data) {
        _status = LSFetchStatus.COMPLETED;
        return data;
    }

    dynamic _error(dynamic error) {
        _status = LSFetchStatus.ERROR;
        return Future.error(error);
    }

    dynamic get data => _future.then((data) => data).catchError((error) => Future.error(error));

    set future(Future<T> future) {
        assert(future != null);
        _status = LSFetchStatus.UNINITIALIZED;
        _run(future);
    }

    dynamic get status => _status;
}
