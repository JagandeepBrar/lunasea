import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/database/config.dart';
import 'package:lunasea/modules/settings.dart';
import 'package:lunasea/system/filesystem/file.dart';
import 'package:lunasea/system/filesystem/filesystem.dart';
import 'package:lunasea/utils/encryption.dart';

class SettingsSystemBackupRestoreRestoreTile extends StatelessWidget {
  const SettingsSystemBackupRestoreRestoreTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LunaBlock(
      title: 'settings.RestoreFromDevice'.tr(),
      body: [TextSpan(text: 'settings.RestoreFromDeviceDescription'.tr())],
      trailing: const LunaIconButton(icon: Icons.download_rounded),
      onTap: () async => _restore(context),
    );
  }

  Future<void> _restore(BuildContext context) async {
    try {
      LunaFile? file = await LunaFileSystem().read(context, ['lunasea']);
      if (file != null) await _decryptBackup(context, file);
    } catch (error, stack) {
      LunaLogger().error('Failed to restore device backup', error, stack);
      showLunaErrorSnackBar(
        title: 'settings.RestoreFromCloudFailure'.tr(),
        error: error,
      );
    }
  }

  Future<void> _decryptBackup(
    BuildContext context,
    LunaFile file,
  ) async {
    Tuple2<bool, String> _key = await SettingsDialogs().decryptBackup(context);
    if (_key.item1) {
      String encrypted = String.fromCharCodes(file.data);
      try {
        String decrypted = LunaEncryption().decrypt(_key.item2, encrypted);
        await LunaConfig().import(context, decrypted);
        showLunaSuccessSnackBar(
          title: 'settings.RestoreFromCloudSuccess'.tr(),
          message: 'settings.RestoreFromCloudSuccessMessage'.tr(),
        );
      } catch (_) {
        showLunaErrorSnackBar(
          title: 'settings.RestoreFromCloudFailure'.tr(),
          message: 'lunasea.IncorrectEncryptionKey'.tr(),
          showButton: true,
          buttonText: 'lunasea.Retry'.tr(),
          buttonOnPressed: () async => _decryptBackup(context, file),
        );
      }
    }
  }
}
