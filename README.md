# Matches

A Future-proof package with utility classes that are useful already,
but will become even more useful when Dart 3 arrives.

## Installation

```sh
flutter pub add matches
```

## Usage

```dart
Result<int> result = Pending<int>();

await Future.delayed(Duration(seconds: 1));
result = Loading<int>();

await Future.delayed(Duration(seconds: 1));
result = Success(42)
```

Dart 2

```dart
if (result is Loading) {
    return LinearProgressIndicator(value: result.loading().progress);
} else if (result is Success<int>) {
    return Text('The number is ${result.success().value}')
}
```

Dart 3

```dart
final child = switch (result) {
  Success(value: var v) => Text('The number is $v'),
  Loading(value: var p) => LinearProgressIndicator(value: p),
  Failure(value: var e) => Text('Error: ${e.toString()}')
  _ => SizedBox()
};

```

## LICENSE

Copyright 2023 Andrei Lesnitsky

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
