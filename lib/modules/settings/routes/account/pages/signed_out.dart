import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsAccountSignedOutPage extends StatefulWidget {
  final ScrollController scrollController;

  const SettingsAccountSignedOutPage({
    Key key,
    @required this.scrollController,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<SettingsAccountSignedOutPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  LunaLoadingState _state = LunaLoadingState.INACTIVE;

  @override
  Widget build(BuildContext context) {
    return LunaScaffold(
      scaffoldKey: _scaffoldKey,
      body: _body(),
      bottomNavigationBar: _bottomActionBar(),
    );
  }

  Widget _bottomActionBar() {
    return LunaBottomActionBar(
      actions: [
        LunaButton(
          type: LunaButtonType.TEXT,
          text: 'settings.Register'.tr(),
          icon: Icons.app_registration_rounded,
          onTap: _register,
          loadingState: _state,
        ),
        LunaButton(
          type: LunaButtonType.TEXT,
          text: 'settings.SignIn'.tr(),
          icon: Icons.login_rounded,
          onTap: _signIn,
          loadingState: _state,
        ),
      ],
    );
  }

  Widget _body() {
    return LunaListView(
      controller: widget.scrollController,
      children: [
        Padding(
          child: Center(
            child: Image.asset(
              LunaAssets.brandingFull,
              width: 200.0,
            ),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16.0),
        ),
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
                    AutofillHints.email
                  ],
                ),
                LunaTextInputBar(
                  controller: _passwordController,
                  isFormField: true,
                  margin: const EdgeInsets.only(
                      bottom: 12.0, left: 12.0, right: 12.0),
                  labelIcon: Icons.vpn_key_rounded,
                  labelText: 'settings.Password'.tr(),
                  obscureText: true,
                  keyboardType: TextInputType.text,
                  autofillHints: const [
                    AutofillHints.password,
                    AutofillHints.newPassword
                  ],
                  action: TextInputAction.done,
                ),
              ],
            ),
          ),
        ),
        Padding(
          child: Center(
            child: InkWell(
              child: Text(
                'settings.ForgotYourPassword'.tr(),
                style: const TextStyle(
                  color: LunaColours.accent,
                  fontWeight: LunaUI.FONT_WEIGHT_BOLD,
                  fontSize: LunaUI.FONT_SIZE_H3,
                ),
                textAlign: TextAlign.center,
              ),
              onTap: () async =>
                  SettingsAccountPasswordResetRouter().navigateTo(context),
            ),
          ),
          padding: const EdgeInsets.symmetric(vertical: 8.0),
        )
      ],
    );
  }

  bool _validateEmailAddress({bool showSnackBarOnFailure = true}) {
    if (!LunaValidator().email(_emailController.text)) {
      if (showSnackBarOnFailure)
        showLunaErrorSnackBar(
          title: 'settings.InvalidEmail'.tr(),
          message: 'settings.InvalidEmailMessage'.tr(),
        );
      return false;
    }
    return true;
  }

  bool _validatePassword({bool showSnackBarOnFailure = true}) {
    if (_passwordController.text.isEmpty) {
      if (showSnackBarOnFailure)
        showLunaErrorSnackBar(
          title: 'settings.InvalidPassword'.tr(),
          message: 'settings.InvalidPasswordMessage'.tr(),
        );
      return false;
    }
    return true;
  }

  Future<void> _register() async {
    if (!_validateEmailAddress() || !_validatePassword()) return;
    if (mounted) setState(() => _state = LunaLoadingState.ACTIVE);
    await LunaFirebaseAuth()
        .registerUser(_emailController.text, _passwordController.text)
        .then((response) {
      if (mounted) setState(() => _state = LunaLoadingState.INACTIVE);
      if (response.state) {
        showLunaSuccessSnackBar(
          title: 'settings.RegisteredSuccess'.tr(),
          message: response.user.user.email,
        );
      } else {
        showLunaErrorSnackBar(
          title: 'settings.RegisteredFailure'.tr(),
          message: response.error?.message ?? 'lunasea.UnknownError'.tr(),
        );
      }
    }).catchError((error, stack) {
      if (mounted) setState(() => _state = LunaLoadingState.INACTIVE);
      showLunaErrorSnackBar(
        title: 'settings.RegisteredFailure'.tr(),
        error: error,
      );
    });
  }

  Future<void> _signIn() async {
    if (!_validateEmailAddress() || !_validatePassword()) return;
    if (mounted) setState(() => _state = LunaLoadingState.ACTIVE);
    await LunaFirebaseAuth()
        .signInUser(_emailController.text, _passwordController.text)
        .then((response) {
      if (mounted) setState(() => _state = LunaLoadingState.INACTIVE);
      if (response.state) {
        showLunaSuccessSnackBar(
          title: 'settings.SignedInSuccess'.tr(),
          message: response.user.user.email,
        );
      } else {
        showLunaErrorSnackBar(
          title: 'settings.SignedInFailure'.tr(),
          message: response.error?.message ?? 'lunasea.UnknownError'.tr(),
        );
      }
    }).catchError((error, stack) {
      if (mounted) setState(() => _state = LunaLoadingState.INACTIVE);
      showLunaErrorSnackBar(
        title: 'settings.SignedInFailure'.tr(),
        error: error,
      );
    });
  }
}
