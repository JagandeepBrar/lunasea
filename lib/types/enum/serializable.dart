mixin EnumSerializable on Enum {
  String get value;

  String toJson() => this.value;

  @override
  String toString() => this.value;
}
