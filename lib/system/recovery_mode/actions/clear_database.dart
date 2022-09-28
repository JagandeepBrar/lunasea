import 'package:flutter/material.dart';
import 'package:lunasea/database/database.dart';
import 'package:lunasea/system/recovery_mode/action_tile.dart';

class ClearDatabaseTile extends RecoveryActionTile {
  const ClearDatabaseTile({
    super.key,
    super.title = 'Clear Database',
    super.description = 'Clear all configured settings and modules',
    super.showConfirmDialog = true,
  });

  @override
  Future<void> action(BuildContext context) async {
    await LunaDatabase().nuke();
  }
}
