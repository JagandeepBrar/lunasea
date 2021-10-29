import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/search.dart';

class NewznabCategoryData {
  int id;
  String name;
  List<NewznabSubcategoryData> subcategories = [];

  NewznabCategoryData({
    @required this.id,
    @required this.name,
  });

  @override
  String toString() => {
        'id': id,
        'name': name,
        'subcatagories': [
          for (NewznabSubcategoryData subcatagory in subcategories)
            subcatagory.toString()
        ],
      }.toString();

  IconData get icon {
    if (id >= 1000 && id <= 1999) return Icons.games;
    if (id >= 2000 && id <= 2999) return Icons.movie;
    if (id >= 3000 && id <= 3999) return Icons.library_music;
    if (id >= 4000 && id <= 4999) return Icons.computer;
    if (id >= 5000 && id <= 5999) return Icons.live_tv;
    if (id >= 6000 && id <= 6999) return Icons.lock;
    if (id >= 7000 && id <= 7999) return Icons.book;
    return Icons.category;
  }

  String get subcategoriesTitleList {
    if (subcategories.isEmpty) return 'search.NoSubcategoriesFound'.tr();
    return subcategories.map<String>((subcat) => subcat.name).join(', ');
  }
}
