



extension NullableList on List? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;
}

extension NullableString on String? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;
}
