import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsAccountDeleteAccountTile extends StatefulWidget {
  const SettingsAccountDeleteAccountTile({
    Key key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<SettingsAccountDeleteAccountTile> {
  LunaLoadingState _loadingState = LunaLoadingState.INACTIVE;

  void updateState(LunaLoadingState state) {
    if (mounted) setState(() => _loadingState = state);
  }

  @override
  Widget build(BuildContext context) {
    return LunaBlock(
      title: 'settings.DeleteAccount'.tr(),
      body: [
        TextSpan(text: 'settings.DeleteAccountDescription'.tr()),
      ],
      trailing: LunaIconButton(
        icon: LunaIcons.DELETE,
        color: LunaColours.red,
        loadingState: _loadingState,
      ),
      onTap: _delete,
    );
  }

  Future<void> _delete() async {
    if (_loadingState == LunaLoadingState.ACTIVE) return;
    updateState(LunaLoadingState.ACTIVE);

    Tuple2<bool, String> _result =
        await SettingsDialogs().confirmDeleteAccount(context);
    if (_result.item1) {
      await LunaFirebaseAuth().deleteUser(_result.item2).then((res) {
        if (res.state) {
          showLunaSuccessSnackBar(
            title: 'settings.AccountDeleted'.tr(),
            message: 'settings.AccountDeletedMessage'.tr(),
          );
          Navigator.of(context).lunaSafetyPop();
        } else {
          updateState(LunaLoadingState.INACTIVE);
          showLunaErrorSnackBar(
            title: 'settings.FailedToDeleteAccount'.tr(),
            message: res.error?.message ?? 'lunasea.UnknownError'.tr(),
          );
        }
      });
    }
    updateState(LunaLoadingState.INACTIVE);
  }
}
