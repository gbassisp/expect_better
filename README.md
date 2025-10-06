Better assertions, but still using dart test library. Better readability and discovery when using code completion, without compromises.

## Features

- `expectThat(...)` with many built-in methods
- Easy to extend with extension methods

## Usage

```dart
expectThat('something').isTruthy(because: 'it is a non-empty string');
```

