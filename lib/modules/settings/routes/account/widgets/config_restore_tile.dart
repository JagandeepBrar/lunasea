import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsAccountRestoreConfigurationTile extends StatefulWidget {
  const SettingsAccountRestoreConfigurationTile({
    Key key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<SettingsAccountRestoreConfigurationTile> {
  LunaLoadingState _loadingState = LunaLoadingState.INACTIVE;

  void updateState(LunaLoadingState state) {
    if (mounted) setState(() => _loadingState = state);
  }

  @override
  Widget build(BuildContext context) {
    return LunaBlock(
      title: 'settings.RestoreFromCloud'.tr(),
      body: [TextSpan(text: 'settings.RestoreFromCloudDescription'.tr())],
      trailing: LunaIconButton(
        icon: LunaIcons.CLOUD_DOWNLOAD,
        loadingState: _loadingState,
      ),
      onTap: () async => _restore(context),
    );
  }

  Future<void> _restore(BuildContext context) async {
    if (_loadingState == LunaLoadingState.ACTIVE) return;
    updateState(LunaLoadingState.ACTIVE);
    try {
      List<LunaFirebaseBackupDocument> documents =
          await LunaFirebaseFirestore().getBackupEntries();
      Tuple2<bool, LunaFirebaseBackupDocument> result =
          await SettingsDialogs().getBackupFromCloud(context, documents);
      if (result.item1) {
        String encrypted =
            await LunaFirebaseStorage().downloadBackup(result.item2.id);
        Tuple2<bool, String> key =
            await SettingsDialogs().decryptBackup(context);
        if (key.item1) {
          String decrypted = LunaEncryption().decrypt(key.item2, encrypted);
          if (decrypted != LunaEncryption.ENCRYPTION_FAILURE) {
            await LunaConfiguration().import(context, decrypted).then((_) {
              updateState(LunaLoadingState.INACTIVE);
              showLunaSuccessSnackBar(
                title: 'settings.RestoreFromCloudSuccess'.tr(),
                message: 'settings.RestoreFromCloudSuccessMessage'.tr(),
              );
            });
          } else {
            showLunaErrorSnackBar(
              title: 'settings.RestoreFromCloudFailure'.tr(),
              message: 'lunasea.IncorrectEncryptionKey'.tr(),
            );
          }
        }
      }
    } catch (error, stack) {
      LunaLogger().error('Restore Failed', error, stack);
      showLunaErrorSnackBar(
        title: 'settings.RestoreFromCloudFailure'.tr(),
        error: error,
      );
    }
    updateState(LunaLoadingState.INACTIVE);
  }
}
