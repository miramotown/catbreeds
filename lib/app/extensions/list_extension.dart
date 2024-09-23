extension NullableListExtension<T> on List<T>? {
  List<T> safeEmpty() => this ?? [];
}