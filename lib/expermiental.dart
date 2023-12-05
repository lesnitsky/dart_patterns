sealed class Ordering<T> {
  const Ordering();
}

class Greater<T> extends Ordering<T> {
  final T difference;
  const Greater(this.difference);
}

class Less<T> extends Ordering<T> {
  final T difference;
  const Less(this.difference);
}

class Equal<T> extends Ordering<T> {
  const Equal();
}

extension IntOrdering on int {
  Ordering<int> compare(int other) {
    final difference = this - other;

    if (difference > 0) {
      return Greater(difference);
    } else if (difference < 0) {
      return Less(-difference);
    } else {
      return const Equal();
    }
  }
}

extension DoubleOrdering on double {
  Ordering<double> compare(double other) {
    final difference = this - other;

    if (difference > 0) {
      return Greater(difference);
    } else if (difference < 0) {
      return Less(-difference);
    } else {
      return const Equal();
    }
  }
}

extension NumbleOrdering on num {
  Ordering<num> compare(num other) {
    final difference = this - other;

    if (difference > 0) {
      return Greater(difference);
    } else if (difference < 0) {
      return Less(-difference);
    } else {
      return const Equal();
    }
  }
}

extension StringOrdering on String {
  Ordering<void> compare(String other) {
    final difference = compareTo(other);

    if (difference > 0) {
      return Greater(null);
    } else if (difference < 0) {
      return Less(null);
    } else {
      return const Equal();
    }
  }
}

extension DateTimeOrdering on DateTime {
  Ordering<Duration> compare(DateTime other) {
    final difference = this.difference(other);

    if (difference > Duration.zero) {
      return Greater(difference);
    } else if (difference < Duration.zero) {
      return Less(-difference);
    } else {
      return const Equal();
    }
  }
}

sealed class Maybe<T> {
  const Maybe();
}

extension MaybeExtension<T> on T? {
  Maybe<T> toMaybe() {
    if (this == null) {
      return const Nothing();
    } else {
      return Just(this as T);
    }
  }
}

extension JustExtension<T> on T {
  Maybe<T> toMaybe() => Just(this);
}

class Just<T> extends Maybe<T> {
  final T value;
  const Just(this.value) : assert(null is! T);
}

class Nothing<T> extends Maybe<T> {
  const Nothing();
}

sealed class Either<T, K> {
  const Either();
}

class Left<L, R> extends Either<L, R> {
  final L value;
  const Left(this.value);
}

class Right<R, L> extends Either<L, R> {
  final R value;
  const Right(this.value);
}

sealed class These<T, K> {
  const These();
}

class This<T, K> extends These<T, K> {
  final T value;

  const This(this.value);
}

class That<K, T> extends These<T, K> {
  final K value;

  const That(this.value);
}

class Both<T, K> extends These<T, K> {
  final T a;
  final K b;

  Both(this.a, this.b);
}
