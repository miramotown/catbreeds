extension NullableBoolExtension on bool? {
  bool safe() => this ?? false;
}