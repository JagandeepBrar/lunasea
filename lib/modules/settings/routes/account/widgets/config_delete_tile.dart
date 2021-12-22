import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsAccountDeleteConfigurationTile extends StatefulWidget {
  const SettingsAccountDeleteConfigurationTile({
    Key key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<SettingsAccountDeleteConfigurationTile> {
  LunaLoadingState _loadingState = LunaLoadingState.INACTIVE;

  void updateState(LunaLoadingState state) {
    if (mounted) setState(() => _loadingState = state);
  }

  @override
  Widget build(BuildContext context) {
    return LunaBlock(
      title: 'settings.DeleteCloudBackup'.tr(),
      body: [TextSpan(text: 'settings.DeleteCloudBackupDescription'.tr())],
      trailing: LunaIconButton(
        icon: LunaIcons.CLOUD_DELETE,
        loadingState: _loadingState,
      ),
      onTap: () async => _delete(context),
    );
  }

  Future<void> _delete(BuildContext context) async {
    if (_loadingState == LunaLoadingState.ACTIVE) return;
    updateState(LunaLoadingState.ACTIVE);

    try {
      List<LunaFirebaseBackupDocument> documents =
          await LunaFirebaseFirestore().getBackupEntries();
      Tuple2<bool, LunaFirebaseBackupDocument> result =
          await SettingsDialogs().getBackupFromCloud(context, documents);
      if (result.item1) {
        await LunaFirebaseFirestore()
            .deleteBackupEntry(result.item2.id)
            .then((_) => LunaFirebaseStorage().deleteBackup(result.item2.id))
            .then((_) {
          updateState(LunaLoadingState.INACTIVE);
          showLunaSuccessSnackBar(
            title: 'settings.DeleteCloudBackupSuccess'.tr(),
            message:
                result.item2.title.replaceAll('\n', ' ${LunaUI.TEXT_EMDASH} '),
          );
        }).catchError((error, stack) {
          LunaLogger().error('Firebase Backup Deletion Failed', error, stack);
          showLunaErrorSnackBar(
            title: 'settings.DeleteCloudBackupFailure'.tr(),
            error: error,
          );
        });
      }
    } catch (error, stack) {
      LunaLogger().error('Firebase Backup Deletion Failed', error, stack);
      showLunaErrorSnackBar(
        title: 'settings.DeleteCloudBackupFailure'.tr(),
        error: error,
      );
    }
    updateState(LunaLoadingState.INACTIVE);
  }
}
