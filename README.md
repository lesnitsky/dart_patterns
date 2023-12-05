# Dart patterns

Collection of useful patterns for Dart

[![GitHub stars](https://img.shields.io/github/stars/lesnitsky/dart_patterns.svg?style=social&hash=20230321)](https://github.com/lesnitsky/dart_patterns)
[![Twitter Follow](https://img.shields.io/twitter/follow/lesnitsky_dev.svg?label=Follow%20me&style=social)](https://twitter.com/intent/follow?user_id=2615671640)

## Documentation

### Result

```dart
final r = R.guard(() {
  final v = random.nextInt(2);
  if (v == 0) throw Exception('error');
  return v;
})

switch (r) {
  case Success(value: final v):
    print(v);
  case Failure(error: final e, stackTrace: final stackTrace):
    print(e);
    print(stackTrace);
}
```

### LateResult

```dart
final r = Late.fromStream(() async* {
  await Future.delayed(Duration(seconds: 1));
  final v = random.nextInt(2);
  if (v == 0) throw Exception('error');
  yield v;
})

r.forEach((r) {
  switch (r) {
    case Pending:
      print('no values recieved yet');
    case Success(value: final v):
      print(v);
    case Failure(error: final e, stackTrace: final stackTrace):
      print(e);
      print(stackTrace);
  }
});

```

### AsyncResult

```dart
final r = await Async.asStream(() async {
  await Future.delayed(Duration(seconds: 1));
  final v = random.nextInt(2);
  if (v == 0) throw Exception('error');
  return v;
});

stream.forEach((r) {
  switch (r) {
    case Loading:
      print('loading');
    case Success(value: final v):
      print(v);
    case Failure(error: final e, stackTrace: final stackTrace):
      print(e);
      print(stackTrace);
  }
});
```

### LateAsyncResult

```dart
final client = HttpClient();

final r = (() async* {
  yield LateAsync.pending();

  try {
    final req = await client.openUrl('GET', Uri.parse('https://example.com'));
    yield LateAsync.loading();

    final res = await req.close();
    final contentLength = res.contentLength;

    var received = 0;
    var sb = StringBuffer();

    await for (final chunk in res.transform(Utf8Decoder())) {
      received += chunk.length;
      yield LateAsync.loading(received / contentLength);
      sb.write(chunk);
    }

    yield LateAsync.success(sb.toString());
  } catch (e, stackTrace) {
    yield LateAsync.failure(e, stackTrace);
  }
})()

r.forEach((r) {
  switch (r) {
    case Pending:
      print('connection not established yet');
    case Loading(progress: final progress):
      print('loading: $progress');
    case Success(value: final v):
      print(v);
    case Failure(error: final e, stackTrace: final stackTrace):
      print(e);
      print(stackTrace);
  }
});
```

### Experimental

- [Maybe](https://pub.dev/documentation/dart_patterns/latest/expermiental/Maybe-class.html)
- [Ordering](https://pub.dev/documentation/dart_patterns/latest/expermiental/Ordering-class.html)
- [Either](https://pub.dev/documentation/dart_patterns/latest/expermiental/Either-class.html)
- [These](https://pub.dev/documentation/dart_patterns/latest/expermiental/These-class.html)

## LICENSE

Copyright 2023 Andrei Lesnitsky

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
