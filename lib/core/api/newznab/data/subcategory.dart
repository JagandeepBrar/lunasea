import 'package:flutter/foundation.dart';

class NewznabSubcategoryData {
    final int id;
    final String name;

    NewznabSubcategoryData({
        @required this.id,
        @required this.name,
    });

    String toString() => {
        'id': id,
        'name': name,
    }.toString();
}