import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/database/config.dart';
import 'package:lunasea/firebase/firestore.dart';
import 'package:lunasea/firebase/storage.dart';
import 'package:lunasea/modules/settings.dart';
import 'package:lunasea/utils/encryption.dart';
import 'package:lunasea/utils/uuid.dart';

class SettingsAccountBackupConfigurationTile extends ConsumerStatefulWidget {
  const SettingsAccountBackupConfigurationTile({
    Key? key,
  }) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends ConsumerState<SettingsAccountBackupConfigurationTile> {
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
        final encryption = ref.watch(encryptionProvider);

        String decrypted = LunaConfig().export();
        String encrypted = encryption.encrypt(_values.item2, decrypted);
        int timestamp = DateTime.now().millisecondsSinceEpoch;
        String id = ref.watch(uuidProvider).generate();
        String format = 'MMMM dd, yyyy\nhh:mm:ss a';
        String title = DateFormat(format).format(DateTime.now());

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
