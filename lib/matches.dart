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

abstract class ComparisonResult<T> {
  const ComparisonResult();
}

class Greater<T> extends ComparisonResult<T> {
  final T difference;
  const Greater(this.difference);
}

class Less<T> extends ComparisonResult<T> {
  final T difference;
  const Less(this.difference);
}

class Equal<T> extends ComparisonResult<T> {
  const Equal();
}

extension IntComparison on int {
  ComparisonResult<int> compare(int other) {
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

extension DoubleComparison on double {
  ComparisonResult<double> compare(double other) {
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

extension NumbleComparison on num {
  ComparisonResult<num> compare(num other) {
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

extension StringComparison on String {
  ComparisonResult<void> compare(String other) {
    final difference = this.compareTo(other);

    if (difference > 0) {
      return Greater(null);
    } else if (difference < 0) {
      return Less(null);
    } else {
      return const Equal();
    }
  }
}

extension DateTimeComparison on DateTime {
  ComparisonResult<Duration> compare(DateTime other) {
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
