import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

part 'list_view_option.g.dart';

@HiveType(typeId: 29, adapterName: 'LunaListViewOptionAdapter')
enum LunaListViewOption {
  @HiveField(0)
  BLOCK_VIEW,
  @HiveField(1)
  GRID_VIEW,
}

extension LunaListViewOptionExtension on LunaListViewOption {
  String get key => this.name;

  String get readable {
    switch (this) {
      case LunaListViewOption.BLOCK_VIEW:
        return 'lunasea.BlockView'.tr();
      case LunaListViewOption.GRID_VIEW:
        return 'lunasea.GridView'.tr();
    }
    throw Exception('Invalid LunaListViewOption');
  }

  IconData get icon {
    switch (this) {
      case LunaListViewOption.BLOCK_VIEW:
        return Icons.view_list_rounded;
      case LunaListViewOption.GRID_VIEW:
        return Icons.grid_view_rounded;
    }
    throw Exception('Invalid LunaListViewOption');
  }

  LunaListViewOption fromKey(String key) {
    switch (key) {
      case 'BLOCK_VIEW':
        return LunaListViewOption.BLOCK_VIEW;
      case 'GRID_VIEW':
        return LunaListViewOption.GRID_VIEW;
    }
    return null;
  }
}
