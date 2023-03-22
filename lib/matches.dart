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

abstract class Ordering<T> {
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
