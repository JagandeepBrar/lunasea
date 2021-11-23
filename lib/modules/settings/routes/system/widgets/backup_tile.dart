import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsSystemBackupRestoreBackupTile extends StatelessWidget {
  const SettingsSystemBackupRestoreBackupTile({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LunaListTile(
      context: context,
      title: LunaText.title(text: 'Backup to Device'),
      subtitle: LunaText.subtitle(text: 'Backup Configuration Data'),
      trailing: LunaIconButton(icon: Icons.upload_rounded),
      onTap: () async => _backup(context),
    );
  }

  Future<void> _backup(BuildContext context) async {
    try {
      Tuple2<bool, String> _values =
          await SettingsDialogs().backupConfiguration(context);
      if (_values.item1) {
        String data = LunaConfiguration().export();
        String encrypted = LunaEncryption().encrypt(_values.item2, data);
        String name = DateFormat('y-MM-dd kk-mm-ss').format(DateTime.now());
        if (encrypted != LunaEncryption.ENCRYPTION_FAILURE) {
          bool result = await LunaFileSystem().export(
            context,
            '$name.lunasea',
            utf8.encode(encrypted),
          );
          if (result)
            showLunaSuccessSnackBar(
                title: 'Saved Backup',
                message: 'Backup has been successfully saved');
        }
      }
    } catch (error, stack) {
      LunaLogger().error('Backup Failed', error, stack);
      showLunaErrorSnackBar(
        title: 'Failed to Backup',
        error: error,
      );
    }
  }
}
