import 'package:dart_patterns/result.dart';
import 'package:test/test.dart';

void main() {
  group('Result', () {
    test('could be Pending', () {
      final Result<int> r = Pending<int>();

      final t = switch (r) {
        Pending() => true,
        _ => false,
      };

      expect(t, isTrue);
    });

    test('could be Failure', () {
      final Result<int> r = Failure<int>();

      final t = switch (r) {
        Failure() => true,
        _ => false,
      };

      expect(t, isTrue);
    });

    test('could be Success', () {
      final Result<int> r = Success<int>(42);

      switch (r) {
        case Success(value: final v):
          {
            expect(v, 42);
          }
        default:
          fail('Should be Success');
      }
    });
  });

  group('AsyncResult', () {
    test('could be Pending', () {
      final AsyncResult<int> r = Pending<int>();

      final t = switch (r) {
        Pending() => true,
        _ => false,
      };

      expect(t, isTrue);
    });

    test('could be Loading', () {
      final AsyncResult<int> r = Loading<int>(0.5);

      switch (r) {
        case Loading(progress: final p):
          expect(p, 0.5);
        default:
          fail('Should be Loading');
      }
    });

    test('could be Failure', () {
      final AsyncResult<int> r = Failure<int>();

      final t = switch (r) {
        Failure() => true,
        _ => false,
      };

      expect(t, isTrue);
    });

    test('could be Success', () {
      final AsyncResult<int> r = Success<int>(42);

      switch (r) {
        case Success(value: final v):
          expect(v, 42);
        default:
          fail('Should be Success');
      }
    });
  });
}
