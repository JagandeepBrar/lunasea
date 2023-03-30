import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/firebase/auth.dart';
import 'package:lunasea/utils/validator.dart';

class AccountPasswordResetRoute extends StatefulWidget {
  const AccountPasswordResetRoute({
    Key? key,
  }) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<AccountPasswordResetRoute>
    with LunaScrollControllerMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return LunaScaffold(
      scaffoldKey: _scaffoldKey,
      appBar: _appBar() as PreferredSizeWidget?,
      body: _body(),
      bottomNavigationBar: _bottomActionBar(),
    );
  }

  Widget _appBar() {
    return LunaAppBar(
      title: 'settings.ResetPassword'.tr(),
      scrollControllers: [scrollController],
    );
  }

  Widget _bottomActionBar() {
    return LunaBottomActionBar(
      actions: [
        LunaButton.text(
          text: 'settings.ResetPassword'.tr(),
          icon: Icons.vpn_key_rounded,
          onTap: _resetPassword,
        ),
      ],
    );
  }

  Widget _body() {
    return LunaListView(
      controller: scrollController,
      children: [
        AutofillGroup(
          child: LunaCard(
            context: context,
            child: Column(
              children: [
                LunaTextInputBar(
                  controller: _emailController,
                  isFormField: true,
                  margin: const EdgeInsets.all(12.0),
                  labelIcon: Icons.person_rounded,
                  labelText: 'settings.Email'.tr(),
                  action: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  autofillHints: const [
                    AutofillHints.username,
                    AutofillHints.email,
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _resetPassword() async {
    if (_validateEmailAddress()) {
      LunaFirebaseAuth()
          .resetPassword(_emailController.text)
          .then((_) => showLunaSuccessSnackBar(
                title: 'settings.EmailSentSuccess'.tr(),
                message: 'settings.EmailSentSuccessMessage'.tr(),
              ))
          .catchError((error, stack) {
        LunaLogger().error(
          'Failed to reset password: ${_emailController.text}',
          error,
          stack,
        );
        showLunaErrorSnackBar(
          title: 'settings.EmailSentFailure'.tr(),
          error: error,
        );
      });
    }
  }

  bool _validateEmailAddress({bool showSnackBarOnFailure = true}) {
    if (!LunaValidator().email(_emailController.text)) {
      if (showSnackBarOnFailure) {
        showLunaErrorSnackBar(
          title: 'settings.InvalidEmail'.tr(),
          message: 'settings.InvalidEmailMessage'.tr(),
        );
      }
      return false;
    }
    return true;
  }
}
