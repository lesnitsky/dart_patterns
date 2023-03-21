abstract class Result<T> {
  const Result();

  Loading<T> loading() => this as Loading<T>;
  Failure<T> failure() => this as Failure<T>;
  Success<T> success() => this as Success<T>;
}

class Pending<T> extends Result<T> {
  const Pending();
}

class Loading<T> extends Result<T> {
  final double? progress;

  const Loading([this.progress]);
}

class Failure<T> extends Result<T> {
  final Object? exception;
  final StackTrace? stackTrace;

  const Failure([this.exception, this.stackTrace]);
}

class Success<T> extends Result<T> {
  final T value;

  const Success(this.value);
}
