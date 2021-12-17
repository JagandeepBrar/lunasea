import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsAccountBackupConfigurationTile extends StatefulWidget {
  const SettingsAccountBackupConfigurationTile({
    Key key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<SettingsAccountBackupConfigurationTile> {
  LunaLoadingState _loadingState = LunaLoadingState.INACTIVE;

  void updateState(LunaLoadingState state) {
    if (mounted) setState(() => _loadingState = state);
  }

  @override
  Widget build(BuildContext context) {
    return LunaBlock(
      title: 'settings.BackupToCloud'.tr(),
      body: [TextSpan(text: 'settings.BackupToCloudDescription'.tr())],
      trailing: LunaIconButton(
        icon: LunaIcons.CLOUD_UPLOAD,
        loadingState: _loadingState,
      ),
      onTap: () async => _backup(context),
    );
  }

  Future<void> _backup(BuildContext context) async {
    if (_loadingState == LunaLoadingState.ACTIVE) return;
    updateState(LunaLoadingState.ACTIVE);

    try {
      Tuple2<bool, String> _values =
          await SettingsDialogs().backupConfiguration(context);
      if (_values.item1) {
        String decrypted = LunaConfiguration().export();
        String encrypted = LunaEncryption().encrypt(_values.item2, decrypted);
        int timestamp = DateTime.now().millisecondsSinceEpoch;
        String title =
            DateFormat('MMMM dd, yyyy\nhh:mm:ss a').format(DateTime.now());
        String id = LunaUUID().uuid;
        if (encrypted != LunaEncryption.ENCRYPTION_FAILURE)
          await LunaFirebaseFirestore()
              .addBackupEntry(id, timestamp, title: title)
              .then((_) => LunaFirebaseStorage().uploadBackup(encrypted, id))
              .then((_) {
            updateState(LunaLoadingState.INACTIVE);
            showLunaSuccessSnackBar(
              title: 'settings.BackupToCloudSuccess'.tr(),
              message: title.replaceAll('\n', ' ${LunaUI.TEXT_EMDASH} '),
            );
          }).catchError((error, stack) {
            LunaLogger().error(
              'Failed to backup configuration to the cloud',
              error,
              stack,
            );
            showLunaErrorSnackBar(
              title: 'settings.BackupToCloudFailure'.tr(),
              error: error,
            );
          });
      }
    } catch (error, stack) {
      LunaLogger().error('Backup Failed', error, stack);
      showLunaErrorSnackBar(
        title: 'settings.BackupToCloudFailure'.tr(),
        error: error,
      );
    }
    updateState(LunaLoadingState.INACTIVE);
  }
}
