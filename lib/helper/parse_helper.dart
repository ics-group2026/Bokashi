/// Helpers for tolerantly parsing numbers coming from the API.
///
/// The backend serializes numeric fields inconsistently: sometimes as real
/// numbers (`12`), sometimes as strings, and often as decimal strings such as
/// `"1.000"` or `"100.000"`. Using `int.parse` on those throws a
/// `FormatException`, and assigning a `String` straight into an `int?`/`double?`
/// field throws a type error. These helpers absorb all of those shapes.
library;

/// Parses [value] into an `int?`, returning [defaultValue] when it is null or
/// unparseable. Handles ints, doubles, int strings and decimal strings
/// (`"1.000"` -> `1`).
int? parseInt(dynamic value, {int? defaultValue}) {
  if (value == null) return defaultValue;
  if (value is int) return value;
  if (value is double) return value.toInt();
  return double.tryParse(value.toString())?.toInt() ?? defaultValue;
}

/// Parses [value] into a `double?`, returning [defaultValue] when it is null or
/// unparseable. Handles ints, doubles and numeric strings.
double? parseDouble(dynamic value, {double? defaultValue}) {
  if (value == null) return defaultValue;
  if (value is double) return value;
  if (value is int) return value.toDouble();
  return double.tryParse(value.toString()) ?? defaultValue;
}
