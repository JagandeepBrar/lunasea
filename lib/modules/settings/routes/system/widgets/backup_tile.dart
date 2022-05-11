import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';
import 'package:lunasea/system/filesystem/filesystem.dart';
import 'package:lunasea/utils/encryption.dart';

class SettingsSystemBackupRestoreBackupTile extends ConsumerWidget {
  const SettingsSystemBackupRestoreBackupTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LunaBlock(
      title: 'settings.BackupToDevice'.tr(),
      body: [TextSpan(text: 'settings.BackupToDeviceDescription'.tr())],
      trailing: const LunaIconButton(icon: Icons.upload_rounded),
      onTap: () async => _backup(context, ref),
    );
  }

  Future<void> _backup(BuildContext context, WidgetRef ref) async {
    try {
      final _values = await SettingsDialogs().backupConfiguration(context);
      if (_values.item1) {
        final encryption = ref.watch(encryptionProvider);
        String data = LunaConfiguration().export();
        String encrypted = encryption.encrypt(_values.item2, data);
        String name = DateFormat('y-MM-dd kk-mm-ss').format(DateTime.now());
        bool result = await LunaFileSystem().save(
          context,
          '$name.lunasea',
          utf8.encode(encrypted),
        );
        if (result) {
          showLunaSuccessSnackBar(
            title: 'settings.BackupToCloudSuccess'.tr(),
            message: '$name.lunasea',
          );
        }
      }
    } catch (error, stack) {
      LunaLogger().error('Failed to create device backup', error, stack);
      showLunaErrorSnackBar(
        title: 'settings.BackupToCloudFailure'.tr(),
        error: error,
      );
    }
  }
}
