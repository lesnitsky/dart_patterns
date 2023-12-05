import 'package:dart_patterns/expermiental.dart';
import 'package:test/test.dart';

void main() {
  group('Ordering', () {
    test('works for integers', () {
      final a = 42.compare(41);
      final b = 41.compare(42);
      final c = 42.compare(42);

      switch (a) {
        case Greater(difference: final d):
          expect(d, 1);
        default:
          fail('Should be Greater');
      }

      switch (b) {
        case Less(difference: final d):
          expect(d, 1);
        default:
          fail('Should be Less');
      }

      switch (c) {
        case Equal():
          expect(true, isTrue);
        default:
          fail('Should be Equal');
      }
    });

    test('works for doubles', () {
      final a = 42.0.compare(41.0);
      final b = 41.0.compare(42.0);
      final c = 42.0.compare(42.0);

      switch (a) {
        case Greater(difference: final d):
          expect(d, 1.0);

        default:
          fail('Should be Greater');
      }

      switch (b) {
        case Less(difference: final d):
          expect(d, 1.0);
        default:
          fail('Should be Less');
      }

      switch (c) {
        case Equal():
          expect(true, isTrue);
        default:
          fail('Should be Equal');
      }
    });

    test('works for strings', () {
      final a = 'b'.compare('a');
      final b = 'a'.compare('b');
      final c = 'b'.compare('b');

      switch (a) {
        case Greater():
          {}
        default:
          fail('Should be Greater');
      }

      switch (b) {
        case Less():
          {}
        default:
          fail('Should be Less');
      }

      switch (c) {
        case Equal():
          {}
        default:
          fail('Should be Equal');
      }
    });

    test('works for Dates', () {
      final a = DateTime(2021, 1, 1).compare(DateTime(2020, 1, 1));
      final b = DateTime(2020, 1, 1).compare(DateTime(2021, 1, 1));
      final c = DateTime(2021, 1, 1).compare(DateTime(2021, 1, 1));

      switch (a) {
        case Greater():
          {}
        default:
          fail('Should be Greater');
      }

      switch (b) {
        case Less():
          {}
        default:
          fail('Should be Less');
      }

      switch (c) {
        case Equal():
          {}
        default:
          fail('Should be Equal');
      }
    });
  });

  group('Maybe<T>', () {
    test('could be Just<T>', () {
      final Maybe<int> m = Just<int>(42);

      switch (m) {
        case Just(value: final v):
          expect(v, 42);
        default:
          fail('Should be Just');
      }
    });

    test('could be Nothing<T>', () {
      final Maybe<int> m = Nothing<int>();

      final t = switch (m) {
        Nothing() => true,
        _ => false,
      };

      expect(t, isTrue);
    });
  });

  group('Either<T, K>', () {
    test('could be Left', () {
      final Either<int, String> e = Left(42);

      switch (e) {
        case Left(value: final v):
          expect(v, 42);

        default:
          fail('Should be Left');
      }
    });

    test('could be Right', () {
      final Either<int, String> e = Right('42');

      switch (e) {
        case Right(value: final v):
          expect(v, '42');
        default:
          fail('Should be Right');
      }
    });
  });

  group('These<T, K>', () {
    test('could be This', () {
      final These<int, String> t = This(42);

      switch (t) {
        case This(value: final v):
          expect(v, 42);
        default:
          fail('Should be This');
      }
    });

    test('could be That', () {
      final These<int, String> t = That('42');

      switch (t) {
        case That(value: final v):
          expect(v, '42');
        default:
          fail('Should be That');
      }
    });

    test('could be Both', () {
      final These<int, String> t = Both(42, '42');

      switch (t) {
        case Both(a: final v1, b: final v2):
          expect(v1, 42);
          expect(v2, '42');
        default:
          fail('Should be Both');
      }
    });
  });
}
