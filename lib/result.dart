typedef R<T> = Result<T>;
typedef Late<T> = LateResult<T>;
typedef Async<T> = AsyncResult<T>;
typedef LateAsync<T> = LateAsyncResult<T>;

sealed class Result<T> {
  /// Creates a [Success] result.
  const factory Result.success(T value) = Success<T>._;

  /// Creates a [Failure] result.
  const factory Result.failure([
    Object? failure,
    StackTrace? stackTrace,
  ]) = Failure<T>._;

  /// Wraps a function call in a try-catch block.
  /// Returns a [Success] result if the function call succeeds.
  /// Returns a [Failure] result if the function call throws.
  static Result<T> guard<T>(T Function() f) {
    try {
      return Result.success(f());
    } catch (e, s) {
      return Result.failure(e, s);
    }
  }
}

sealed class LateResult<T> {
  const factory LateResult.pending() = Pending<T>._;
  const factory LateResult.success(T value) = Success<T>._;
  const factory LateResult.failure([
    Object? failure,
    StackTrace? stackTrace,
  ]) = Failure<T>._;

  static Stream<LateResult<T>> fromStream<T>(Stream<T> stream) async* {
    yield Late<T>.pending();

    try {
      await for (final value in stream) {
        yield Late.success(value);
      }
    } catch (e, s) {
      yield Late.failure(e, s);
    }
  }
}

sealed class AsyncResult<T> {
  /// Creates a [Success] result.
  const factory AsyncResult.success(T value) = Success<T>._;

  /// Creates a [Failure] result.
  const factory AsyncResult.failure([
    Object? exception,
    StackTrace? stackTrace,
  ]) = Failure<T>._;

  /// Creates a [Loading] result.
  const factory AsyncResult.loading([double? progress]) = Loading<T>._;

  /// Wraps an async function call in a try-catch block.
  /// Returns a [Stream] of [AsyncResult]s.
  ///
  /// The first result is always [Loading].
  ///
  /// If the function call succeeds, the second result is [Success].
  /// If the function call throws, the second result is [Failure].
  static Stream<AsyncResult<T>> asStream<T>(Future<T> Function() fn) async* {
    yield Async<T>.loading();
    try {
      yield Async.success(await fn());
    } catch (e, s) {
      yield Async.failure(e, s);
    }
  }
}

class LateAsyncResult<T> {
  const factory LateAsyncResult.pending() = Pending<T>._;
  const factory LateAsyncResult.success(T value) = Success<T>._;
  const factory LateAsyncResult.failure([
    Object? exception,
    StackTrace? stackTrace,
  ]) = Failure<T>._;
}

final class Success<T> implements R<T>, Late<T>, Async<T>, LateAsync<T> {
  final T value;
  const Success._(this.value);
}

final class Failure<T> implements R<T>, Late<T>, Async<T>, LateAsync<T> {
  final Object? exception;
  final StackTrace? stackTrace;
  const Failure._([this.exception, this.stackTrace]);
}

final class Loading<T> implements Async<T>, LateAsync<T> {
  final double? progress;
  const Loading._([this.progress]);
}

final class Pending<T> implements Late<T>, Async<T>, LateAsync<T> {
  const Pending._();
}
