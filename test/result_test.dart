import 'dart:async';

import 'package:dart_patterns/result.dart';
import 'package:test/test.dart';

void main() {
  group('Result', () {
    test('could be Failure', () {
      const r = R<int>.failure();

      switch (r) {
        case Failure():
          expect(true, isTrue);
        default:
          fail('Should be Failure');
      }
    });

    test('could be Success', () {
      const r = R<int>.success(42);

      switch (r) {
        case Success(value: final v):
          expect(v, 42);
        default:
          fail('Should be Success');
      }
    });
  });

  group('LateResult', () {
    test('could be Pending', () {
      const r = Late<int>.pending();

      switch (r) {
        case Pending():
          expect(true, isTrue);
        default:
          fail('Should be Pending');
      }
    });

    test('could be Failure', () {
      const r = Late<int>.failure();

      switch (r) {
        case Failure():
          expect(true, isTrue);
        default:
          fail('Should be Failure');
      }
    });

    test('could be Success', () {
      const r = Late<int>.success(42);

      switch (r) {
        case Success(value: final v):
          expect(v, 42);
        default:
          fail('Should be Success');
      }
    });

    group('#fromStream', () {
      test('converts a Stream<T> to the Stream<LateResult<T>>', () async {
        final ctrl = StreamController<int>();

        final stream = Late.fromStream(ctrl.stream);
        final resultsFuture = stream.toList();

        ctrl.add(1);
        ctrl.add(2);
        ctrl.addError(Exception('error'));

        await ctrl.close();

        final results = await resultsFuture;

        expect(results[0], isA<Pending<int>>());
        expect(results[1], isA<Success<int>>());
        expect(results[2], isA<Success<int>>());
        expect(results[3], isA<Failure<int>>());
      });
    });
  });

  group('AsyncResult', () {
    test('could be Loading', () {
      const r = Async<int>.loading(0.5);

      switch (r) {
        case Loading(progress: final p):
          expect(p, 0.5);
        default:
          fail('Should be Loading');
      }
    });

    test('could be Failure', () {
      const r = Async<int>.failure();

      switch (r) {
        case Failure():
          expect(true, isTrue);
        default:
          fail('Should be Failure');
      }
    });

    test('could be Success', () {
      const r = Async<int>.success(42);

      switch (r) {
        case Success(value: final v):
          expect(v, 42);
        default:
          fail('Should be Success');
      }
    });

    group('#asStream', () {
      test(
        'calls a Future<T> Function() and returns a Stream<AsyncResult<T>>',
        () async {
          final stream = Async.asStream(() async {
            await Future.delayed(const Duration(milliseconds: 100));
            return 42;
          });

          final resultsFuture = stream.toList();

          final results = await resultsFuture;

          expect(results[0], isA<Loading<int>>());
          expect(results[1], isA<Success<int>>());

          final errorStream = Async.asStream(() async {
            await Future.delayed(const Duration(milliseconds: 100));
            throw Exception('error');
          });

          final errorResultsFuture = await errorStream.toList();

          expect(errorResultsFuture[0], isA<Loading<int>>());
          expect(errorResultsFuture[1], isA<Failure<int>>());
        },
      );
    });
  });
}
