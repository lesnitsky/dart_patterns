# Matches

A Future-proof package with utility classes that are useful already,
but will become even more useful when Dart 3 arrives.

[![GitHub stars](https://img.shields.io/github/stars/lesnitsky/matches.svg?style=social&hash=20230321)](https://github.com/lesnitsky/matches)
[![Twitter Follow](https://img.shields.io/twitter/follow/lesnitsky_dev.svg?label=Follow%20me&style=social)](https://twitter.com/intent/follow?user_id=2615671640)

## Installation

```sh
dart pub add matches
```

or

```sh
flutter pub add matches
```

If you're using Dart 3 already – feel free to use a pre-release version `1.0.0-dev`

## Usage

### Result

```dart
Result<int> result = Pending<int>();

await Future.delayed(Duration(seconds: 1));
result = Loading<int>();

await Future.delayed(Duration(seconds: 1));
result = Success(42)
```

Dart 2 usage

```dart
if (result is Loading) {
    return LinearProgressIndicator(value: result.loading().progress);
} else if (result is Success) {
    return Text('The number is ${result.success().value}')
} else if (result is Failure) {
    return Text('Error: ${result.failure().exception}')
} else {
    return SizedBox();
}
```

Dart 3 usage

```dart
final child = switch (result) {
  Success(value: var v) => Text('The number is $v'),
  Loading(progress: var p) => LinearProgressIndicator(value: p),
  Failure(exception: var e) => Text('Error: ${e.toString()}'),
  _ => const SizedBox()
};

```

### Ordering

Dart 3 usage

```dart
final random = Random();

final a = random.nextInt(10);
final b = random.nextInt(10);

final msg = switch (a.compare(b)) {
  Greater(difference: var d) => 'a is greater than b by $d',
  Less(difference: var d) => 'a is less than b by $d',
  Equal _ => 'a and b are equal',
};

print(msg);
```

`compare` method is available on `int`, `double`, `num`, `String`, `Date` via extension.

### Maybe

Dart 2 usage

```dart
final Maybe<int> a = Just(42);
final Maybe<int> b = Nothing();

if (a is Just) {
  print(a.just().value);
} else {
  print('nothing')
}
```

Dart 3 usage

```dart
switch (a) {
  case Just(value: final v): print(v);
  case Nothing: print('nothing');
}
```

### Either

Dart 2 usage

```dart
final Either<int, String> a = Left(42);
final Either<int, String> b = Right('42');

if (a is Left) {
  print(a.left().value);
} else {
  print(a.right().value);
}
```

Dart 3 usage

```dart
switch (a) {
  case Left(value: final v): print(v);
  case Right(value: final v): print(v);
}
```

### These

Dart 3 usage

```dart
switch (user) {
  case Both<User, Admin>(a: final customer, b: final admin): {
    applyAdminCoupon(admin.employeId);
  }
  case This<User>(value: final user): {
    verifyHasValidPaymentMethod(user)
  };
}

checkout();
```

[![GitHub stars](https://img.shields.io/github/stars/lesnitsky/matches.svg?style=social&hash=20230321)](https://github.com/lesnitsky/matches)
[![Twitter Follow](https://img.shields.io/twitter/follow/lesnitsky_dev.svg?label=Follow%20me&style=social)](https://twitter.com/lesnitsky_dev)

## LICENSE

Copyright 2023 Andrei Lesnitsky

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
