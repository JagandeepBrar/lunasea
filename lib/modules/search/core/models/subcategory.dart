class NewznabSubcategoryData {
  int id;
  String? name;

  NewznabSubcategoryData({
    required this.id,
    required this.name,
  });

  @override
  String toString() => {
        'id': id,
        'name': name,
      }.toString();
}
