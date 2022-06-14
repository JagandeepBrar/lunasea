import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

part 'list_view_option.g.dart';

const _BLOCK_VIEW = 'BLOCK_VIEW';
const _GRID_VIEW = 'GRID_VIEW';

@HiveType(typeId: 29, adapterName: 'LunaListViewOptionAdapter')
enum LunaListViewOption {
  @HiveField(0)
  BLOCK_VIEW(_BLOCK_VIEW),
  @HiveField(1)
  GRID_VIEW(_GRID_VIEW);

  final String key;
  const LunaListViewOption(this.key);

  static LunaListViewOption? fromKey(String? key) {
    switch (key) {
      case _BLOCK_VIEW:
        return LunaListViewOption.BLOCK_VIEW;
      case _GRID_VIEW:
        return LunaListViewOption.GRID_VIEW;
    }
    return null;
  }
}

extension LunaListViewOptionExtension on LunaListViewOption {
  String get readable {
    switch (this) {
      case LunaListViewOption.BLOCK_VIEW:
        return 'lunasea.BlockView'.tr();
      case LunaListViewOption.GRID_VIEW:
        return 'lunasea.GridView'.tr();
    }
  }

  IconData get icon {
    switch (this) {
      case LunaListViewOption.BLOCK_VIEW:
        return Icons.view_list_rounded;
      case LunaListViewOption.GRID_VIEW:
        return Icons.grid_view_rounded;
    }
  }
}
