sealed class Result<T> {
  const Result();
}

sealed class AsyncResult<T> {
  const AsyncResult();
}

class Loading<T> extends AsyncResult<T> {
  final double? progress;
  Loading(this.progress);
}

class Pending<T> extends Result<T> implements AsyncResult<T> {
  const Pending();
}

class Failure<T> extends Result<T> implements AsyncResult<T> {
  final Object? exception;
  final StackTrace? stackTrace;
  const Failure([this.exception, this.stackTrace]);
}

class Success<T> extends Result<T> implements AsyncResult<T> {
  final T value;
  const Success(this.value);
}
