import 'package:flutter/foundation.dart';

class NewznabSubcategoryData {
    int id;
    String name;

    NewznabSubcategoryData({
        @required this.id,
        @required this.name,
    });

    String toString() => {
        'id': id,
        'name': name,
    }.toString();
}