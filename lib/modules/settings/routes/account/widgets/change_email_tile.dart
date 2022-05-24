import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/firebase/auth.dart';
import 'package:lunasea/modules/settings.dart';

class ChangeEmailTile extends StatefulWidget {
  const ChangeEmailTile({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<ChangeEmailTile> {
  LunaLoadingState _loadingState = LunaLoadingState.INACTIVE;

  void updateState(LunaLoadingState state) {
    if (mounted) setState(() => _loadingState = state);
  }

  @override
  Widget build(BuildContext context) {
    return LunaBlock(
      title: 'settings.UpdateEmail'.tr(),
      trailing: LunaIconButton(
        icon: LunaIcons.EMAIL,
        loadingState: _loadingState,
      ),
      onTap: _update,
    );
  }

  Future<void> _update() async {
    if (_loadingState == LunaLoadingState.ACTIVE) return;
    updateState(LunaLoadingState.ACTIVE);

    Tuple3<bool, String, String> _result =
        await SettingsDialogs().updateAccountEmail(context);
    if (_result.item1) {
      await LunaFirebaseAuth()
          .updateEmail(_result.item2, _result.item3)
          .then((res) {
        if (res.state) {
          showLunaSuccessSnackBar(
            title: 'settings.EmailUpdated'.tr(),
            message: _result.item2,
          );
        } else {
          updateState(LunaLoadingState.INACTIVE);
          showLunaErrorSnackBar(
            title: 'settings.FailedToUpdateEmail'.tr(),
            message: res.error?.message ?? 'lunasea.UnknownError'.tr(),
          );
        }
      });
    }
    updateState(LunaLoadingState.INACTIVE);
  }
}
