import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/firebase/auth.dart';
import 'package:lunasea/modules/settings.dart';
import 'package:lunasea/router/router.dart';

class ChangePasswordTile extends StatefulWidget {
  const ChangePasswordTile({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<ChangePasswordTile> {
  LunaLoadingState _loadingState = LunaLoadingState.INACTIVE;

  void updateState(LunaLoadingState state) {
    if (mounted) setState(() => _loadingState = state);
  }

  @override
  Widget build(BuildContext context) {
    return LunaBlock(
      title: 'settings.UpdatePassword'.tr(),
      trailing: LunaIconButton(
        icon: LunaIcons.PASSWORD,
        loadingState: _loadingState,
      ),
      onTap: _delete,
    );
  }

  Future<void> _delete() async {
    if (_loadingState == LunaLoadingState.ACTIVE) return;
    updateState(LunaLoadingState.ACTIVE);

    Tuple3<bool, String, String> _result =
        await SettingsDialogs().updateAccountPassword(context);
    if (_result.item1) {
      await LunaFirebaseAuth()
          .updatePassword(_result.item2, _result.item3)
          .then((res) {
        if (res.state) {
          showLunaSuccessSnackBar(
            title: 'settings.PasswordUpdated'.tr(),
            message: 'settings.PleaseSignInAgain'.tr(),
          );
          LunaRouter().popSafely();
          LunaFirebaseAuth().signOut();
        } else {
          updateState(LunaLoadingState.INACTIVE);
          showLunaErrorSnackBar(
            title: 'settings.FailedToUpdatePassword'.tr(),
            message: res.error?.message ?? 'lunasea.UnknownError'.tr(),
          );
        }
      });
    }
    updateState(LunaLoadingState.INACTIVE);
  }
}
